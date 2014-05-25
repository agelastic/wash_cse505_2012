(* This file is the only one you should modify for problems 2 and 3 *)
open Ast
  
exception InterpUnimplemented
exception DoNotTakeStepWithSkip

(* There are simpler heap definitions, but these will be easier
   for extending/modifying to support pushheap, popheap, pushvar, and popvar *)
let empty_heap = []
let rec get_var heap str = 
  match heap with
      [] -> 0
    | (str',i)::tl -> if str=str' then i else get_var tl str
let rec  set_var heap str num = 
  match heap with
      [] -> [(str,num)]
    | (str',i)::tl -> if str=str' 
                      then (str,num)::tl 
                      else (str',i)::(set_var tl str num)

let rec interp_exp h e =
  let interp_exp_r = interp_exp h in
  match e with
      Int i -> i
    | Var v -> get_var h v
    | Plus(e1,e2)  -> (interp_exp_r e1) + (interp_exp_r e2)
    | Times(e1,e2) -> (interp_exp_r e1) * (interp_exp_r e2)
 
let rec interp_step h s =
  match s with
      Skip ->  raise DoNotTakeStepWithSkip 
    | Assign(v,e) -> (set_var h v (interp_exp h e), Skip)
    | Seq(Skip,s2) -> (h,s2)
    | Seq(s1,s2) -> 
      let (h3,s3) = interp_step h s1 in
      (h3, Seq(s3,s2))
    | If(e,s1,s2) ->
      if((interp_exp h e) <= 0)
      then (h,s2)
      else (h,s1)
    | While(e,s1) -> (h, If(e,Seq(s1,s),Skip))
    | _ -> raise InterpUnimplemented

let rec iter h s =
  match (h,s) with
      (_,Skip) -> get_var h "ans"
    | _ -> let (h',s') = interp_step h s in iter h' s'
  
let interp = iter empty_heap

(* the next two bindings really belong in a "main" module, but this
keeps all the code you need in one place *)

(* expect one command-line argument, a file to parse and interpret *)
(* you do not need to understand this interaction with the system *)
let get_prog () =
  let argv = Sys.argv in
  let _ = 
    if Array.length argv != 2
    then (prerr_string ("usage: " ^ argv.(0) ^ " [file-to-interpret]\n");
	  exit 1) in
  let ch = open_in argv.(1) in
  Parse.program Lex.lexer (Lexing.from_channel ch)

let _ =
  let prog = get_prog () in
  print_string ("ans = " ^ string_of_int (interp prog) ^"\n")
