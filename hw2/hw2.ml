(* This file is the only one you should modify *)
open Ast

exception Unimplemented

(* a little warm-up *)
let rec string_of_valu v = 
  match v with
    VConst(i) -> string_of_int i
  | VPair(v,v') -> "(" ^ string_of_valu v ^ "," ^ string_of_valu v' ^ ")"
  | VTagged(s,v) -> s ^ "(" ^ string_of_valu v ^ ")"

let rec string_of_binding_list lst = 
  match lst with
    [] -> ""
  | (str, v)::tl -> "\n" ^ str ^ ": " ^ string_of_valu v ^ string_of_binding_list tl

(* a little helper function you may find useful; you don't have to use it *)
let orelse opt thunk =
  match opt with
    Some x -> opt
  | None -> thunk()

let rec large p v = 
  match (p,v) with
    (PWild, _) -> Some []
  | (PVar(s), v') -> Some [(s,v')]
  | (PConst(i), VConst(i')) -> if i = i' then Some [] else None
  | (PPair(p',p''), VPair(v',v'')) -> 
    let b = large p' v' in 
    let b' = large p'' v'' in
    (match (b,b') with
       (Some x, Some x') -> Some (x @ x')
     | _ -> None)
  | (PTagged(s,p'), VTagged(s',v')) -> if s = s' then large p' v' else None
  | (PDescendent(p'), v') -> 
    orelse (large p' v') (fun () ->
        match v' with
        (* works with p instead of p' for all cases, which is more like the definiton *)
          VTagged(s,v'') -> large p' v'' 
        | VPair(v'',v''') ->
          orelse (large p' v'') (fun () -> large p' v''')
        | _ -> None
      )
  | (_,_) -> None

let rec small_step p v b = 
  match (p,v) with
    (PVar(s), _) -> [(PWild, v, [(s,v)] @ b)]
  | (PConst(c), VConst(c')) -> 
    if c = c' then [(PWild, v, b)] else []
  | (PTagged(s',p'), VTagged(s'',v'')) -> 
    if s' = s'' then [(p',v'',b)] else []
  | (PDescendent(p'), VTagged(s',v')) -> 
    [(p',v,b); (p,v',b)]
  | (PDescendent(p'), VPair(v',v'')) -> [(p',v,b); (p,v',b); (p,v'',b)]
  | (PDescendent(p'), _) -> [(p',v,b)]
  | (PPair(PWild,p'), VPair(v',v'')) -> [(p',v'',b)]
  | (PPair(p',p''), VPair(v',v'')) -> 
    let simpler = small_step p' v' b in
    let remap (x,y,z) = (PPair(x,p''), VPair(y,v''), z) in
    List.map remap simpler
  | (PWild,_) -> [(p,v,b)]
  | (_,_) -> []


let rec iter stack = (* do not change *)
  match stack with
    [] -> None
  | (PWild,_,b)::tl -> Some b
  | (p,v,b)::tl -> iter ((small_step p v b) @ tl)

let small p v = iter [(p, v, [])] (* do not change *)

let rec denote p = 
  match p with
    PWild -> fun v -> Some []
  | PVar(s) -> fun v -> Some [(s,v)]
  | PConst(i) -> 
    fun v -> 
      (match v with 
         VConst(j) -> Some []
       | _ -> None)
  | PPair(p',p'') ->
    let d' = denote p' in
    let d'' = denote p'' in
    fun v ->
      (match v with
         VPair(v',v'') ->
         (match (d' v', d'' v'') with
            (Some b', Some b'') -> Some (b' @ b'')
          | _ -> None) 
       | _ -> None)
  | PTagged(s',p') -> let d' = denote p' in
    fun v ->
      (match v with
         VTagged(s'',v'') -> if s'' = s' then d' v'' else None
       | _ -> None)
  | PDescendent(p') -> 
    let d' = denote p' in
    let rec f v =
      match v with
        VTagged(s',v') -> d' v'
      | VPair(v',v'') ->
        orelse (d' v') (fun () -> d' v'')
      | _ -> None
    in
    fun v -> 
      orelse (f v) (fun () -> d' v)

(* do not change *)
let print_ans ans =
  print_string
    (match ans with
       None -> "\nno match"
     | Some b -> "\nmatch: " ^ (string_of_binding_list b))

(* the next two bindings really belong in a "main" module, but this
   keeps all the code you need in one place *)

(* expect one command-line argument, a file to parse and interpret *)
(* do not change this *)
let get_prog () =
  let argv = Sys.argv in
  let _ = 
    if Array.length argv != 2
    then (prerr_string ("usage: " ^ argv.(0) ^ " [file-to-interpret]\n");
	  exit 1) in
  let ch = open_in argv.(1) in
  Parse.program Lex.lexer (Lexing.from_channel ch)

(* change this only by uncommenting out parts when you are ready *)
let _ =
  let (p,v) = get_prog () in
  ();
  print_ans (large p v);
  print_ans (denote p v);
  print_ans (small p v);
  print_string "\n"
