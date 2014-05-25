(* this file can be a "drop-in replacement" for interp.ml from hw1 *)
(* just add these two lines to the Makefile appropriately:
   $(COMPILER) -c denote.ml
   $(COMPILER) -o denote ast.cmo parse.cmo lex.cmo denote.cmo # order matters
*)
open Ast

(* all about _when_ things are computed, though hard to tell b/c
   everything is functional in the metalanguage In particular, if we
   float the fun h out, then our denotations are still deconstructing
   abstract syntax -- basically a large-step semantics -- as we do it
   here, our denotations make no use of abstract syntax, which is
   cool!  And look at if case -- we actually denote both sides! *)

(* See how our language without "functions" is denoted by OCaml functions
   taking heaps *)

exception InterpUnimplemented

let rec denote_exp e = 
  match e with
    Int i -> (fun h -> i)
  | Var v -> (fun h -> h v)
  | Plus(e1,e2) -> 
    let d1 = denote_exp e1 in
    let d2 = denote_exp e2 in
    (fun h -> (d1 h) + (d2 h))
  (* WRONG: fun h -> ((denote_exp e1) h) + ((denote_exp e2) h) *)
  | Times(e1,e2) -> 
    let d1 = denote_exp e1 in
    let d2 = denote_exp e2 in
    (fun h -> (d1 h) * (d2 h))

let rec denote_stmt s =
  match s with
    Skip -> (fun h -> h)
  | Assign(v,e) -> 
    let d = denote_exp e in
    (fun h -> 
       let c = d h in
       fun x -> if x=v then c else h x)
  | Seq(s1,s2) ->
    let d1 = denote_stmt s1 in
    let d2 = denote_stmt s2 in
    (fun h -> d2 (d1 h)) (* i.e., d2 o d1 *)
  | If(e,s1,s2) ->
    let d1 = denote_exp e in
    let d2 = denote_stmt s1 in
    let d3 = denote_stmt s2 in
    (fun h -> if (d1 h) > 0 then (d2 h) else (d3 h))
  | While(e,s) ->
    let d1 = denote_exp e in
    let d2 = denote_stmt s in
    let rec f h = if (d1 h) > 0 then f (d2 h) else h in
    f
  | _ -> raise InterpUnimplemented

let denote_prog s = 
  let d = denote_stmt s in
  fun () -> (d (fun x -> 0)) "ans"

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
  let translated_prog = denote_prog prog in
  (* no further need for the AST module! *)
  let result = translated_prog () in
  print_string ("ans = " ^ string_of_int result ^ "\n")
