
(* Modify only interpret and typecheck *)

open Ast

exception ListError
exception Unimplemented (* shows you what to change *)

(******* environment, context, and heap implementation *******)
(* note: using mutation and a "fresh" function would make some things
         more efficient, but that is not our focus *)

let empty = []

let extend lst x e = (x,e)::lst

let rec lookup lst y =
  match lst with
    [] -> raise ListError
  | (x,v)::tl -> if x=y then v else lookup tl y

(* you don't have to change this even though it's not tail-recursive 
  (it could be made so by reversing the list, or by using mutable list elements) *)
let rec update lst y v =
  match lst with
    [] -> raise ListError
  | (x,v2)::tl -> if x=y then (x,v)::tl else (x,v2)::(update tl y v)

(* assumes lst was built only by previous calls to extend_fresh and update *)
let extend_fresh lst e = 
  let newlab = "l" ^ (string_of_int ((List.length lst) + 1)) in
  (newlab, (newlab,e)::lst)

(* interpreter
   remember we are large-step -- pass a value and a heap to the continuation
*)

let interpret e =
  let rec interp_k heap env e k =
    (* two cases done for you -- rest up to you *)
    match e with
      Const i -> k e heap
    | If(e1,e2,e3) ->
	interp_k heap env e1 (fun v1 h1 ->
	  match v1 with
	    Const(0) -> interp_k h1 env e3 k
	  | Const _  -> interp_k h1 env e2 k
	  | _ -> None)
    | Plus(e1,e2) ->
      (match (e1,e2) with
         (Const(i),Const(j)) -> interp_k heap env (Const(i+j)) k
       | _ ->
         interp_k heap env e1 (fun v1 h' ->
             interp_k h' env e2 (fun v2 h'' ->
                 interp_k h'' env (Plus(v1,v2)) k)))
    | Times(e1,e2) ->
      (match (e1,e2) with
         (Const(i),Const(j)) -> interp_k heap env (Const(i*j)) k
       | _ ->
         interp_k heap env e1 (fun v1 h' ->
             interp_k h' env e2 (fun v2 h'' ->
                 interp_k h'' env (Times(v1,v2)) k)))
    | GreaterThan(e1,e2) ->
      interp_k heap env e1 (fun v1 h' ->
          interp_k h' env e2 (fun v2 h'' ->
              match v1,v2 with
                (Const(i),Const(j)) -> interp_k h'' env (if i>j then Const(1) else Const(0)) k
              | _ -> None))
    | Var(v) -> 
      (try k (lookup env v)  heap with _ -> None)
    | Fun(v,t,e1) -> k (Closure(e,env)) heap
    | Apply(e1,e2) ->
      interp_k heap env e1 (fun v1 h' ->
          interp_k h' env e2 (fun v2 h'' ->
              (match v1 with
                 Closure(Fun(v,_,e3), env') -> 
                 interp_k h'' (extend env' v v2) e3 k
               | _ -> None)))
    | Closure(_,_) -> k e heap
    | Get(e1) ->
      interp_k heap env e1 (fun l h' ->
          match l with
            Label(l') -> k (lookup h' l') h' 
          | _ -> None)
    | Set(e1,e2) ->
      interp_k heap env e1 (fun l h' ->
          match l with
            Label(l') -> interp_k h' env e2 (fun v1 h'' ->
              k v1 (update h'' l' v1))
          | _ -> None)
    | Alloc(e1) ->
      interp_k heap env e1 (fun e2 h' ->
          let(l,h'') = extend_fresh h' e2 in
          k (Label(l)) h'')
    | Label(l) -> None
  in interp_k empty empty e (fun x y -> Some (x,y))

(************** type-checker ***********)
(* Note: t1=t2 will do what you want to compare types structurally, 
   e.g., Arrow(Int,Int)=Arrow(Int,Int)
   But t1==t2 is roughly pointer-equality -- do not accidentally use it or
   you will be very sorry *)

let typecheck e = 
 (* for you to do:
    similar to interpret, except we have a context
    instead of a heap and environment and we compute a typ option rather than
    a (heap and value) option *)
  let rec typecheck_k ctxt e k = 
    match e with
      Const i -> k Int
    | If(e1,e2,e3) ->
      typecheck_k ctxt e1 (fun t1 ->
          typecheck_k ctxt e2 (fun t2 ->
              typecheck_k ctxt e3 (fun t3 ->
                  if t1 = Int && t2 = t3 then k t2 else None)))
    | Plus(e1,e2) | Times(e1,e2) ->
      typecheck_k ctxt e1 (fun t1 ->
          typecheck_k ctxt e2 (fun t2 ->
              if t1 = t2 then k t2 else None))
    | GreaterThan(e1,e2) ->
      typecheck_k ctxt e1 (fun t1 ->
          typecheck_k ctxt e2 (fun t2 ->
              if t1 = t2 then k Int else None))
    | Var(v) -> 
      (try k (lookup ctxt v) with _ -> None)
    | Fun(v,t,e) ->
      typecheck_k (extend ctxt v t) e (fun t1-> k (Arrow(t,t1)))
    | Apply(e1,e2) ->
      typecheck_k ctxt e1 (fun t1 ->
          typecheck_k ctxt e2 (fun t2 ->
              match t1 with
                 Arrow(t3,t4) -> if t3 = t2 then k t4 else None
               | _ -> None))
    | Closure(_,_) -> None
    | Get(e) ->
      typecheck_k ctxt e (fun t1 ->
          match t1 with
           Ref(t2) -> k t2
           | _ -> None)
    | Set(e1,e2) ->
      typecheck_k ctxt e1 (fun t1 ->
          typecheck_k ctxt e2 (fun t2 ->
              match t1 with
                Ref(t3) -> if t3 = t2 then k t2 else None
              | _ -> None))
    | Alloc(e) -> typecheck_k ctxt e (fun t -> k (Ref(t)))
    | Label(l) -> None
  in typecheck_k empty e (fun t -> Some t) 

(* Do not change anything below here *)

(* expect one command-line argument, a file to parse *)
(* you do not need to understand this interaction with the system *)
let parse_file () =
  let argv = Sys.argv in
  let _ = 
    if Array.length argv != 2
    then (prerr_string ("usage: " ^ argv.(0) ^ " [file-to-parse]\n");
	  exit 1) in
  let ch = open_in argv.(1) in
  Parse.program Lex.lexer (Lexing.from_channel ch)

let _ = 
  let prog = parse_file() in
  match typecheck prog with
    Some t ->
    print_string "\ntypechecking complete";
    flush stdout;
    print_string ("\ninterpreted answer = ");
    (match interpret prog with
        Some(v,_) -> print_string ((exp2string v) ^ "\n")
      |	None -> print_string "interpreter encountered an error")
  | None -> print_string "did not typecheck\n"
