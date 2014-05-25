%{
open Ast
%}

%start program

%type <Ast.pattern * Ast.valu> program
%type <Ast.pattern> pattern
%type <Ast.valu> valu

%token LLParen LRParen LNewline LComma LDotDotDot LUnderscore
%token LEof
%token <string> LString
%token <int> LInt

%%

pattern:
  LUnderscore { PWild }
| LString { PVar($1) }
| LInt { PConst($1) }
| LLParen pattern LComma pattern LRParen { PPair($2,$4) }
| LString LLParen pattern LRParen { PTagged($1,$3) }
| LDotDotDot LLParen pattern LRParen { PDescendent($3) }

valu:
  LInt { VConst($1) }
| LLParen valu LComma valu LRParen { VPair($2,$4) }
| LString LLParen valu LRParen { VTagged($1,$3) }

program:
  pattern nl valu nl LEof { ($1,$3) }
| pattern nl valu LEof { ($1,$3) }

nl:
  LNewline {()}
| LNewline nl {()}

%%
