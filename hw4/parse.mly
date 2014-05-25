
%{
open Ast
%}

%start program

%type <Ast.exp> exp exp2 exp3 program
%type <Ast.typ> typ

%token LLParen LRParen LColon LDot
%token LInt LArrow LRef
%token LTimes LPlus LGt
%token LFn LIf LThen LElse
%token LSet LGet LRef
%token LLet LIn LEq
%token LEof
%token <int> LConst
%token <string> LVar

%left LGt
%left LPlus
%left LTimes

%right LArrow
%%

typ:
  LInt { Int }
| typ LArrow typ { Arrow($1,$3) }
| LRef LLParen typ LRParen { Ref($3) }
| LLParen typ LRParen { $2 }

exp:
  exp2 { $1 }
| exp  LTimes exp { Times($1,$3) }
| exp  LPlus exp { Plus($1,$3) }
| exp  LGt   exp { GreaterThan($1,$3) }

exp2:
  exp3 { $1 }
| exp2 exp3 { Apply($1,$2) }

exp3:
| LLParen exp LRParen { $2 }
| LConst { Const($1) }
| LVar   { Var($1) } 
| LLParen LIf exp LThen exp LElse exp LRParen { If($3,$5,$7) }
| LLParen LFn  LVar LColon typ LDot exp LRParen { Fun($3,$5,$7) }
| LLParen exp  LSet exp LRParen { Set($2,$4) }
| LLParen LGet exp LRParen { Get($3) }
| LLParen LRef exp LRParen { Alloc($3) }
| LLParen LLet LVar LColon typ LEq exp LIn exp LRParen 
    { Apply(Fun($3,$5,$9),$7) }

program:
    exp LEof { $1 }
