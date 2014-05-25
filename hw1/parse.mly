%{
open Ast
%}

%start program

%type <Ast.stmt> statement program
%type <Ast.exp>  expression

%token LLParen LRParen 
%token LPlus LTimes 
%token LSkip LAssign LSemi LIf LWhile LPushheap LPopheap LPushvar LPopvar
%token LEof
%token <int> LInt
%token <string> LVar

%left LPlus
%right LTimes
%left LSemi
%%

expression:
  LInt { Int($1) }
| LVar { Var($1) }
| expression LPlus  expression { Plus($1,$3)  }
| expression LTimes expression { Times($1,$3) }
| LLParen expression LRParen { $2 }

statement:
  LSkip { Skip }
| LVar LAssign expression { Assign($1,$3) }
| statement LSemi statement { Seq($1,$3) }
| LIf expression LLParen statement LRParen LLParen statement LRParen 
    { If($2,$4,$7) }
| LWhile expression LLParen statement LRParen
    { While($2,$4) }
| LLParen statement LRParen {$2}

| LPushheap     { Pushheap }
| LPopheap LVar { Popheap($2) }
| LPushvar LVar { Pushvar($2) }
| LPopvar  LVar { Popvar($2)  }

program:
  statement LEof { $1 }

%%
