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

val program :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.pattern * Ast.valu
