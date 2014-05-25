(* Modify only interpret and typecheck *)

open Ast

exception ListError
exception TypeError
exception RunTimeError
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

let rec update lst y v =
  match lst with
    [] -> raise ListError
  | (x,v2)::tl -> if x=y then (x,v)::tl else (x,v2)::(update tl y v)

(* assumes lst was built only by previous calls to extend_fresh and update *)
let extend_fresh lst e = 
  let newlab = "l" ^ (string_of_int ((List.length lst) + 1)) in
  (newlab, (newlab,e)::lst)

(* Do not change anything above here. *)

(************* interpreter ***************)
(* note: remember we are large-step -- return a heap and a value *)
(* note: we did two cases for you *)

let rec interpret heap env e =
  match e with
    Const i -> heap,e
  | If(e1,e2,e3) ->
    let h',v1 = interpret heap env e1 in
    (match v1 with
       Const(0) -> interpret h' env e3
     |	Const _  -> interpret h' env e2
     |	_ -> raise RunTimeError)
  | Plus(e1,e2) ->
    (match (e1,e2) with
       (Const(i),Const(j)) -> heap, Const(i+j)
     | _ ->   
       let h',v1 = interpret heap env e1 in
       let h'',v2 = interpret h' env e2 in
       interpret h'' env (Plus(v1,v2)))
  | Times(e1,e2) ->
    (match (e1,e2) with
       (Const(i),Const(j)) -> heap, Const(i*j)
     | _ ->   
       let h',v1 = interpret heap env e1 in
       let h'',v2 = interpret h' env e2 in
       interpret h'' env (Times(v1,v2)))
  | GreaterThan(e1,e2) ->
    let h',v1 = interpret heap env e1 in
    let h'',v2 = interpret h' env e2 in
    (match v1,v2 with
       (Const(i),Const(j)) -> h'', if i>j then Const(1) else Const(0)
     | _ -> raise RunTimeError)
  | Var(v) -> heap, (try lookup env v with _ -> raise RunTimeError)
  | Fun(v,t,e1) -> 
    heap, Closure(e,env)
  | Apply(e1,e2) -> 
    let (h',v1) = interpret heap env e1 in
    let (h'',v2) = interpret h' env e2 in
    (match v1 with
       Closure(Fun(v,_,e3), env') -> 
       interpret h'' (extend env' v v2) e3
     | _ -> raise RunTimeError)
  | Closure(_,_) -> heap,e
  | Get(e1) -> 
    (match interpret heap env e1 with
       (h',Label(l)) ->  h', lookup h' l
     | _ -> raise RunTimeError)
  | Set(e1,e2) ->
    (match interpret heap env e1 with
       (h',Label(l)) -> 
       let (h'',v1) = interpret h' env e2 in
       update h'' l v1, v1
     | _ -> raise RunTimeError)
  | Alloc(e1) ->
    (match interpret heap env e1 with
       (h',e2) -> 
       let (l,h'') = extend_fresh h' e2 in
       h'',Label(l))
  | Label(l) -> raise RunTimeError

(************** type-checker ***********)
(* note: t1=t2 will do what you want to compare types structurally, 
   e.g., Arrow(Int,Int)=Arrow(Int,Int)
   But t1==t2 is roughly pointer-equality -- do not accidentally use it or
   you will be very sorry *)
(* note: we did two cases for you *)

let rec typecheck ctxt e = (* return a type *)
  (* ( print_string ("\n typechecking " ^ exp2string e^ "\n"); *)
  match e with
    Const i -> Int
  | If(e1,e2,e3) ->
    let t1 = typecheck ctxt e1 in
    let t2 = typecheck ctxt e2 in
    let t3 = typecheck ctxt e3 in
    if t1=Int && t2=t3
    then t2
    else raise TypeError
  | Plus(e1,e2) | Times(e1,e2) ->
    let t1 = typecheck ctxt e1 in
    let t2 = typecheck ctxt e2 in
    if t1=t2 
    then t2 
    else raise TypeError
  | GreaterThan(e1,e2) ->
    let t1 = typecheck ctxt e1 in
    let t2 = typecheck ctxt e2 in
    if t1=t2 
    then Int
    else raise TypeError
  | Var(v) -> 
    (try lookup ctxt v with 
       ListError -> raise TypeError
     | _ -> raise RunTimeError)
  | Fun(v,t,e) -> 
    let t1 = typecheck (extend ctxt v t) e in
    Arrow(t,t1)
  | Apply(e1,e2) ->
    let t1 = typecheck ctxt e1 in
    let t2 = typecheck ctxt e2 in
    (match t1 with 
       Arrow(t3,t4) -> if t3 = t2 then t4 else raise TypeError
     | _ -> raise TypeError)
  | Closure(_,_) -> raise TypeError
  | Get(e) -> (match typecheck ctxt e with
        Ref(t) -> t
      | _ -> raise TypeError)
  | Set(e1,e2) -> 
    let t1 = typecheck ctxt e1 in
    let t2 = typecheck ctxt e2 in
    (match t1 with
       Ref(t3) -> if t3 = t2 then t2 else raise TypeError
     | _ -> raise TypeError)
  | Alloc(e) -> 
    let t = typecheck ctxt e in
    Ref(t)
  | Label(l) -> raise TypeError
(* ) *)

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
  (try
     (ignore(typecheck empty prog);
      print_string (exp2string prog); (* useful for debugging *)
      print_string "\ntypechecking complete";
      flush stdout;
      print_string ("\ninterpreted answer = ");
      print_string (exp2string ((fun (_,x)->x) (interpret empty empty prog)));
      print_newline ())
   with TypeError -> print_string "did not typecheck\n")
