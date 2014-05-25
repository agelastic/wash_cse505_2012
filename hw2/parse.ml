type token =
  | LLParen
  | LRParen
  | LNewline
  | LComma
  | LDotDotDot
  | LUnderscore
  | LEof
  | LString of (string)
  | LInt of (int)

open Parsing;;
let _ = parse_error;;
# 2 "parse.mly"
open Ast
# 17 "parse.ml"
let yytransl_const = [|
  257 (* LLParen *);
  258 (* LRParen *);
  259 (* LNewline *);
  260 (* LComma *);
  261 (* LDotDotDot *);
  262 (* LUnderscore *);
  263 (* LEof *);
    0|]

let yytransl_block = [|
  264 (* LString *);
  265 (* LInt *);
    0|]

let yylhs = "\255\255\
\002\000\002\000\002\000\002\000\002\000\002\000\003\000\003\000\
\003\000\001\000\001\000\004\000\004\000\000\000"

let yylen = "\002\000\
\001\000\001\000\001\000\005\000\004\000\004\000\001\000\005\000\
\004\000\005\000\004\000\001\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\001\000\000\000\003\000\014\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\013\000\000\000\000\000\007\000\000\000\000\000\006\000\
\005\000\000\000\000\000\011\000\000\000\004\000\000\000\000\000\
\010\000\000\000\009\000\008\000"

let yydgoto = "\002\000\
\008\000\009\000\022\000\014\000"

let yysindex = "\002\000\
\010\255\000\000\010\255\005\255\000\000\006\255\000\000\000\000\
\018\255\022\255\010\255\010\255\018\255\019\255\010\255\020\255\
\030\255\000\000\019\255\032\255\000\000\254\254\033\255\000\000\
\000\000\034\255\019\255\000\000\029\255\000\000\019\255\035\255\
\000\000\037\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\027\255\000\000\000\000\
\000\000\000\000\000\000\000\000\016\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\253\255\239\255\247\255"

let yytablesize = 39
let yytable = "\010\000\
\013\000\026\000\001\000\018\000\028\000\011\000\012\000\016\000\
\017\000\032\000\003\000\023\000\029\000\034\000\004\000\005\000\
\012\000\006\000\007\000\019\000\013\000\024\000\012\000\012\000\
\012\000\015\000\020\000\021\000\002\000\002\000\002\000\025\000\
\027\000\000\000\030\000\033\000\035\000\031\000\036\000"

let yycheck = "\003\000\
\003\001\019\000\001\000\013\000\007\001\001\001\001\001\011\000\
\012\000\027\000\001\001\015\000\022\000\031\000\005\001\006\001\
\001\001\008\001\009\001\001\001\003\001\002\001\007\001\008\001\
\009\001\004\001\008\001\009\001\002\001\003\001\004\001\002\001\
\001\001\255\255\002\001\007\001\002\001\004\001\002\001"

let yynames_const = "\
  LLParen\000\
  LRParen\000\
  LNewline\000\
  LComma\000\
  LDotDotDot\000\
  LUnderscore\000\
  LEof\000\
  "

let yynames_block = "\
  LString\000\
  LInt\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    Obj.repr(
# 19 "parse.mly"
              ( PWild )
# 104 "parse.ml"
               : Ast.pattern))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 20 "parse.mly"
          ( PVar(_1) )
# 111 "parse.ml"
               : Ast.pattern))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 21 "parse.mly"
       ( PConst(_1) )
# 118 "parse.ml"
               : Ast.pattern))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : Ast.pattern) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : Ast.pattern) in
    Obj.repr(
# 22 "parse.mly"
                                         ( PPair(_2,_4) )
# 126 "parse.ml"
               : Ast.pattern))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Ast.pattern) in
    Obj.repr(
# 23 "parse.mly"
                                  ( PTagged(_1,_3) )
# 134 "parse.ml"
               : Ast.pattern))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Ast.pattern) in
    Obj.repr(
# 24 "parse.mly"
                                     ( PDescendent(_3) )
# 141 "parse.ml"
               : Ast.pattern))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 27 "parse.mly"
       ( VConst(_1) )
# 148 "parse.ml"
               : Ast.valu))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : Ast.valu) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : Ast.valu) in
    Obj.repr(
# 28 "parse.mly"
                                   ( VPair(_2,_4) )
# 156 "parse.ml"
               : Ast.valu))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Ast.valu) in
    Obj.repr(
# 29 "parse.mly"
                               ( VTagged(_1,_3) )
# 164 "parse.ml"
               : Ast.valu))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : Ast.pattern) in
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'nl) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : Ast.valu) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'nl) in
    Obj.repr(
# 32 "parse.mly"
                          ( (_1,_3) )
# 174 "parse.ml"
               : Ast.pattern * Ast.valu))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : Ast.pattern) in
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'nl) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Ast.valu) in
    Obj.repr(
# 33 "parse.mly"
                       ( (_1,_3) )
# 183 "parse.ml"
               : Ast.pattern * Ast.valu))
; (fun __caml_parser_env ->
    Obj.repr(
# 36 "parse.mly"
           (())
# 189 "parse.ml"
               : 'nl))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'nl) in
    Obj.repr(
# 37 "parse.mly"
              (())
# 196 "parse.ml"
               : 'nl))
(* Entry program *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let program (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.pattern * Ast.valu)
;;
