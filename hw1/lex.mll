(* simple lexer.  A production version would not lex keywords
   specially. It would also hash variables. *)

(* Note: definition of variables _must_ follow keywords. *)

{
open Parse
}

let ws = [' ' '\t' '\n' '\r']

rule lexer = parse
  ws+   { lexer lexbuf }
| '('   { LLParen }
| ')'   { LRParen }
| '+'   { LPlus }
| '*'   { LTimes }
| ":="  { LAssign}
| ';'   { LSemi }
| "skip"   { LSkip }
| "if"     { LIf }
| "while"  { LWhile }
| "pushheap" { LPushheap }
| "popheap"  { LPopheap  }
| "pushvar"  { LPushvar  }
| "popvar"   { LPopvar   }
| '-'? ['0'-'9']+ { LInt (int_of_string (Lexing.lexeme lexbuf)) }
| ['a'-'z']+      { LVar (Lexing.lexeme lexbuf) }
| eof { LEof }
