
{
open Parse
} 

let ws = [' ' '\t']

rule lexer = parse
  ws+   { lexer lexbuf }
| '\n'  { LNewline }
| '('   { LLParen }
| ')'   { LRParen }
| ','   { LComma }
| "..."   { LDotDotDot }
| '_'   { LUnderscore }
| ['a'-'z''A'-'Z']+ { LString (Lexing.lexeme lexbuf) }
| '0' { LInt(0) }
| ['1'-'9']['0'-'9']* { LInt(int_of_string (Lexing.lexeme lexbuf)) }
| eof { LEof }
