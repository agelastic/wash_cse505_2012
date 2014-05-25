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

val program :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.exp
