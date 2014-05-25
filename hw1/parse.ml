type token =
  | LLParen
  | LRParen
  | LPlus
  | LTimes
  | LSkip
  | LAssign
  | LSemi
  | LIf
  | LWhile
  | LPushheap
  | LPopheap
  | LPushvar
  | LPopvar
  | LEof
  | LInt of (int)
  | LVar of (string)

open Parsing;;
let _ = parse_error;;
# 2 "parse.mly"
open Ast
# 24 "parse.ml"
let yytransl_const = [|
  257 (* LLParen *);
  258 (* LRParen *);
  259 (* LPlus *);
  260 (* LTimes *);
  261 (* LSkip *);
  262 (* LAssign *);
  263 (* LSemi *);
  264 (* LIf *);
  265 (* LWhile *);
  266 (* LPushheap *);
  267 (* LPopheap *);
  268 (* LPushvar *);
  269 (* LPopvar *);
  270 (* LEof *);
    0|]

let yytransl_block = [|
  271 (* LInt *);
  272 (* LVar *);
    0|]

let yylhs = "\255\255\
\003\000\003\000\003\000\003\000\003\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\002\000\002\000\002\000\001\000\
\000\000"

let yylen = "\002\000\
\001\000\001\000\003\000\003\000\003\000\001\000\003\000\003\000\
\008\000\005\000\003\000\001\000\002\000\002\000\002\000\002\000\
\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\006\000\000\000\000\000\012\000\000\000\
\000\000\000\000\000\000\017\000\000\000\000\000\000\000\001\000\
\002\000\000\000\000\000\013\000\014\000\015\000\000\000\000\000\
\016\000\011\000\000\000\000\000\000\000\000\000\000\000\000\000\
\008\000\005\000\000\000\000\000\000\000\000\000\000\000\010\000\
\000\000\000\000\009\000"

let yydgoto = "\002\000\
\012\000\013\000\018\000"

let yysindex = "\002\000\
\001\255\000\000\001\255\000\000\003\255\003\255\000\000\245\254\
\010\255\020\255\023\255\000\000\250\254\030\255\003\255\000\000\
\000\000\054\255\058\255\000\000\000\000\000\000\003\255\001\255\
\000\000\000\000\048\255\001\255\003\255\003\255\001\255\019\255\
\000\000\000\000\038\255\052\255\052\255\042\255\059\255\000\000\
\001\255\046\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\013\255\
\000\000\000\000\000\000\032\255\040\255\000\000\000\000\000\000\
\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\253\255\001\000"

let yytablesize = 62
let yytable = "\014\000\
\024\000\003\000\001\000\015\000\020\000\004\000\019\000\025\000\
\005\000\006\000\007\000\008\000\009\000\010\000\007\000\027\000\
\011\000\016\000\017\000\007\000\033\000\029\000\030\000\032\000\
\035\000\021\000\007\000\038\000\023\000\036\000\037\000\026\000\
\003\000\003\000\003\000\022\000\024\000\042\000\003\000\039\000\
\004\000\004\000\004\000\040\000\024\000\003\000\004\000\043\000\
\024\000\034\000\029\000\030\000\024\000\004\000\028\000\030\000\
\029\000\030\000\031\000\041\000\029\000\030\000"

let yycheck = "\003\000\
\007\001\001\001\001\000\001\001\016\001\005\001\006\000\014\001\
\008\001\009\001\010\001\011\001\012\001\013\001\002\001\015\000\
\016\001\015\001\016\001\007\001\024\000\003\001\004\001\023\000\
\028\000\016\001\014\001\031\000\006\001\029\000\030\000\002\001\
\001\001\002\001\003\001\016\001\007\001\041\000\007\001\002\001\
\001\001\002\001\003\001\002\001\007\001\014\001\007\001\002\001\
\007\001\002\001\003\001\004\001\007\001\014\001\001\001\004\001\
\003\001\004\001\001\001\001\001\003\001\004\001"

let yynames_const = "\
  LLParen\000\
  LRParen\000\
  LPlus\000\
  LTimes\000\
  LSkip\000\
  LAssign\000\
  LSemi\000\
  LIf\000\
  LWhile\000\
  LPushheap\000\
  LPopheap\000\
  LPushvar\000\
  LPopvar\000\
  LEof\000\
  "

let yynames_block = "\
  LInt\000\
  LVar\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 23 "parse.mly"
       ( Int(_1) )
# 137 "parse.ml"
               : Ast.exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 24 "parse.mly"
       ( Var(_1) )
# 144 "parse.ml"
               : Ast.exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Ast.exp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Ast.exp) in
    Obj.repr(
# 25 "parse.mly"
                               ( Plus(_1,_3)  )
# 152 "parse.ml"
               : Ast.exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Ast.exp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Ast.exp) in
    Obj.repr(
# 26 "parse.mly"
                               ( Times(_1,_3) )
# 160 "parse.ml"
               : Ast.exp))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Ast.exp) in
    Obj.repr(
# 27 "parse.mly"
                             ( _2 )
# 167 "parse.ml"
               : Ast.exp))
; (fun __caml_parser_env ->
    Obj.repr(
# 30 "parse.mly"
        ( Skip )
# 173 "parse.ml"
               : Ast.stmt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Ast.exp) in
    Obj.repr(
# 31 "parse.mly"
                          ( Assign(_1,_3) )
# 181 "parse.ml"
               : Ast.stmt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Ast.stmt) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Ast.stmt) in
    Obj.repr(
# 32 "parse.mly"
                            ( Seq(_1,_3) )
# 189 "parse.ml"
               : Ast.stmt))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 6 : Ast.exp) in
    let _4 = (Parsing.peek_val __caml_parser_env 4 : Ast.stmt) in
    let _7 = (Parsing.peek_val __caml_parser_env 1 : Ast.stmt) in
    Obj.repr(
# 34 "parse.mly"
    ( If(_2,_4,_7) )
# 198 "parse.ml"
               : Ast.stmt))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : Ast.exp) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : Ast.stmt) in
    Obj.repr(
# 36 "parse.mly"
    ( While(_2,_4) )
# 206 "parse.ml"
               : Ast.stmt))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Ast.stmt) in
    Obj.repr(
# 37 "parse.mly"
                            (_2)
# 213 "parse.ml"
               : Ast.stmt))
; (fun __caml_parser_env ->
    Obj.repr(
# 39 "parse.mly"
                ( Pushheap )
# 219 "parse.ml"
               : Ast.stmt))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 40 "parse.mly"
                ( Popheap(_2) )
# 226 "parse.ml"
               : Ast.stmt))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 41 "parse.mly"
                ( Pushvar(_2) )
# 233 "parse.ml"
               : Ast.stmt))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 42 "parse.mly"
                ( Popvar(_2)  )
# 240 "parse.ml"
               : Ast.stmt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Ast.stmt) in
    Obj.repr(
# 45 "parse.mly"
                 ( _1 )
# 247 "parse.ml"
               : Ast.stmt))
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
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.stmt)
;;
