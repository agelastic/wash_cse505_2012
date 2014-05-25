type token =
  | LLParen
  | LRParen
  | LColon
  | LDot
  | LInt
  | LArrow
  | LRef
  | LTimes
  | LPlus
  | LGt
  | LFn
  | LIf
  | LThen
  | LElse
  | LSet
  | LGet
  | LLet
  | LIn
  | LEq
  | LEof
  | LConst of (int)
  | LVar of (string)

open Parsing;;
let _ = parse_error;;
# 3 "parse.mly"
open Ast
# 30 "parse.ml"
let yytransl_const = [|
  257 (* LLParen *);
  258 (* LRParen *);
  259 (* LColon *);
  260 (* LDot *);
  261 (* LInt *);
  262 (* LArrow *);
  263 (* LRef *);
  264 (* LTimes *);
  265 (* LPlus *);
  266 (* LGt *);
  267 (* LFn *);
  268 (* LIf *);
  269 (* LThen *);
  270 (* LElse *);
  271 (* LSet *);
  272 (* LGet *);
  273 (* LLet *);
  274 (* LIn *);
  275 (* LEq *);
  276 (* LEof *);
    0|]

let yytransl_block = [|
  277 (* LConst *);
  278 (* LVar *);
    0|]

let yylhs = "\255\255\
\005\000\005\000\005\000\005\000\002\000\002\000\002\000\002\000\
\003\000\003\000\004\000\004\000\004\000\004\000\004\000\004\000\
\004\000\004\000\004\000\001\000\000\000"

let yylen = "\002\000\
\001\000\003\000\004\000\003\000\001\000\003\000\003\000\003\000\
\001\000\002\000\003\000\001\000\001\000\008\000\008\000\005\000\
\004\000\004\000\010\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\012\000\013\000\021\000\000\000\000\000\
\009\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\020\000\010\000\000\000\000\000\000\000\000\000\
\000\000\011\000\000\000\006\000\000\000\000\000\018\000\000\000\
\000\000\017\000\000\000\000\000\000\000\001\000\000\000\000\000\
\000\000\000\000\016\000\000\000\000\000\000\000\000\000\000\000\
\000\000\004\000\000\000\000\000\000\000\000\000\000\000\003\000\
\015\000\014\000\000\000\000\000\019\000"

let yydgoto = "\002\000\
\006\000\007\000\008\000\009\000\040\000"

let yysindex = "\004\000\
\007\255\000\000\005\255\000\000\000\000\000\000\075\255\007\255\
\000\000\007\255\245\254\007\255\007\255\012\255\023\255\007\255\
\007\255\007\255\000\000\000\000\090\255\034\255\127\255\095\255\
\047\255\000\000\007\255\000\000\043\255\011\255\000\000\126\255\
\007\255\000\000\126\255\099\255\126\255\000\000\041\255\254\254\
\116\255\017\255\000\000\033\255\126\255\007\255\126\255\007\255\
\007\255\000\000\038\255\104\255\052\255\108\255\078\255\000\000\
\000\000\000\000\007\255\113\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\039\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\053\255\062\255\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\255\254\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\253\255\000\000\052\000\044\000"

let yytablesize = 140
let yytable = "\015\000\
\002\000\046\000\002\000\047\000\001\000\003\000\021\000\003\000\
\023\000\024\000\022\000\010\000\028\000\029\000\030\000\011\000\
\012\000\002\000\016\000\017\000\013\000\014\000\047\000\036\000\
\026\000\004\000\005\000\004\000\005\000\041\000\016\000\017\000\
\018\000\025\000\050\000\049\000\032\000\027\000\047\000\056\000\
\005\000\045\000\052\000\047\000\054\000\055\000\005\000\005\000\
\005\000\035\000\016\000\005\000\005\000\005\000\007\000\060\000\
\005\000\047\000\005\000\020\000\000\000\007\000\007\000\008\000\
\000\000\007\000\007\000\007\000\000\000\000\000\007\000\008\000\
\007\000\000\000\008\000\008\000\008\000\000\000\042\000\008\000\
\044\000\008\000\016\000\017\000\018\000\016\000\017\000\018\000\
\051\000\000\000\053\000\031\000\000\000\000\000\019\000\059\000\
\034\000\016\000\017\000\018\000\043\000\000\000\016\000\017\000\
\018\000\057\000\016\000\017\000\018\000\058\000\000\000\016\000\
\017\000\018\000\061\000\016\000\017\000\018\000\000\000\000\000\
\016\000\017\000\018\000\016\000\017\000\018\000\037\000\000\000\
\000\000\048\000\038\000\000\000\039\000\000\000\016\000\017\000\
\018\000\000\000\000\000\033\000"

let yycheck = "\003\000\
\002\001\004\001\004\001\006\001\001\000\001\001\010\000\001\001\
\012\000\013\000\022\001\007\001\016\000\017\000\018\000\011\001\
\012\001\019\001\008\001\009\001\016\001\017\001\006\001\027\000\
\002\001\021\001\022\001\021\001\022\001\033\000\008\001\009\001\
\010\001\022\001\002\001\019\001\003\001\015\001\006\001\002\001\
\002\001\001\001\046\000\006\001\048\000\049\000\008\001\009\001\
\010\001\003\001\008\001\013\001\014\001\015\001\002\001\059\000\
\018\001\006\001\020\001\008\000\255\255\009\001\010\001\002\001\
\255\255\013\001\014\001\015\001\255\255\255\255\018\001\010\001\
\020\001\255\255\013\001\014\001\015\001\255\255\035\000\018\001\
\037\000\020\001\008\001\009\001\010\001\008\001\009\001\010\001\
\045\000\255\255\047\000\002\001\255\255\255\255\020\001\018\001\
\002\001\008\001\009\001\010\001\002\001\255\255\008\001\009\001\
\010\001\002\001\008\001\009\001\010\001\002\001\255\255\008\001\
\009\001\010\001\002\001\008\001\009\001\010\001\255\255\255\255\
\008\001\009\001\010\001\008\001\009\001\010\001\001\001\255\255\
\255\255\014\001\005\001\255\255\007\001\255\255\008\001\009\001\
\010\001\255\255\255\255\013\001"

let yynames_const = "\
  LLParen\000\
  LRParen\000\
  LColon\000\
  LDot\000\
  LInt\000\
  LArrow\000\
  LRef\000\
  LTimes\000\
  LPlus\000\
  LGt\000\
  LFn\000\
  LIf\000\
  LThen\000\
  LElse\000\
  LSet\000\
  LGet\000\
  LLet\000\
  LIn\000\
  LEq\000\
  LEof\000\
  "

let yynames_block = "\
  LConst\000\
  LVar\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    Obj.repr(
# 29 "parse.mly"
       ( Int )
# 180 "parse.ml"
               : Ast.typ))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Ast.typ) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Ast.typ) in
    Obj.repr(
# 30 "parse.mly"
                 ( Arrow(_1,_3) )
# 188 "parse.ml"
               : Ast.typ))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Ast.typ) in
    Obj.repr(
# 31 "parse.mly"
                           ( Ref(_3) )
# 195 "parse.ml"
               : Ast.typ))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Ast.typ) in
    Obj.repr(
# 32 "parse.mly"
                      ( _2 )
# 202 "parse.ml"
               : Ast.typ))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Ast.exp) in
    Obj.repr(
# 35 "parse.mly"
       ( _1 )
# 209 "parse.ml"
               : Ast.exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Ast.exp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Ast.exp) in
    Obj.repr(
# 36 "parse.mly"
                  ( Times(_1,_3) )
# 217 "parse.ml"
               : Ast.exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Ast.exp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Ast.exp) in
    Obj.repr(
# 37 "parse.mly"
                 ( Plus(_1,_3) )
# 225 "parse.ml"
               : Ast.exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Ast.exp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Ast.exp) in
    Obj.repr(
# 38 "parse.mly"
                 ( GreaterThan(_1,_3) )
# 233 "parse.ml"
               : Ast.exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Ast.exp) in
    Obj.repr(
# 41 "parse.mly"
       ( _1 )
# 240 "parse.ml"
               : Ast.exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Ast.exp) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Ast.exp) in
    Obj.repr(
# 42 "parse.mly"
            ( Apply(_1,_2) )
# 248 "parse.ml"
               : Ast.exp))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Ast.exp) in
    Obj.repr(
# 45 "parse.mly"
                      ( _2 )
# 255 "parse.ml"
               : Ast.exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 46 "parse.mly"
         ( Const(_1) )
# 262 "parse.ml"
               : Ast.exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 47 "parse.mly"
         ( Var(_1) )
# 269 "parse.ml"
               : Ast.exp))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 5 : Ast.exp) in
    let _5 = (Parsing.peek_val __caml_parser_env 3 : Ast.exp) in
    let _7 = (Parsing.peek_val __caml_parser_env 1 : Ast.exp) in
    Obj.repr(
# 48 "parse.mly"
                                              ( If(_3,_5,_7) )
# 278 "parse.ml"
               : Ast.exp))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 5 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 3 : Ast.typ) in
    let _7 = (Parsing.peek_val __caml_parser_env 1 : Ast.exp) in
    Obj.repr(
# 49 "parse.mly"
                                                ( Fun(_3,_5,_7) )
# 287 "parse.ml"
               : Ast.exp))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : Ast.exp) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : Ast.exp) in
    Obj.repr(
# 50 "parse.mly"
                                ( Set(_2,_4) )
# 295 "parse.ml"
               : Ast.exp))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Ast.exp) in
    Obj.repr(
# 51 "parse.mly"
                           ( Get(_3) )
# 302 "parse.ml"
               : Ast.exp))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Ast.exp) in
    Obj.repr(
# 52 "parse.mly"
                           ( Alloc(_3) )
# 309 "parse.ml"
               : Ast.exp))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 7 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 5 : Ast.typ) in
    let _7 = (Parsing.peek_val __caml_parser_env 3 : Ast.exp) in
    let _9 = (Parsing.peek_val __caml_parser_env 1 : Ast.exp) in
    Obj.repr(
# 54 "parse.mly"
    ( Apply(Fun(_3,_5,_9),_7) )
# 319 "parse.ml"
               : Ast.exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Ast.exp) in
    Obj.repr(
# 57 "parse.mly"
             ( _1 )
# 326 "parse.ml"
               : Ast.exp))
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
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.exp)
