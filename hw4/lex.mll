
{
open Parse
} 

let ws = [' ' '\t' '\n' '\r']

rule lexer = parse
  ws+ { lexer lexbuf }
| '(' { LLParen }
| ')' { LRParen }
| ':' { LColon }
| "->"   { LArrow }
| "int" { LInt }
| "ref" { LRef }
| '.' { LDot }
| "+" { LPlus }
| "*" { LTimes }
| ">" { LGt }
| "fn" { LFn }
| "if"   { LIf }
| "then" { LThen }
| "else" { LElse }
| ":=" { LSet }
| "!"  { LGet }
| "let" { LLet }
| "in" { LIn }
| '=' { LEq }
| '-'?['0'-'9']+ { LConst(int_of_string(Lexing.lexeme lexbuf)) }
| ['a'-'z']['a'-'z''0'-'9']*  { LVar (Lexing.lexeme lexbuf) }
| eof { LEof }
