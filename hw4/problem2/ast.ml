
type var = string
type label = string

type typ =
    Int
  | Arrow of typ * typ (* Arrow(t1,t2) means function from t1 to t2 *)
  | Ref of typ (* Ref t means a mutable reference holding a t *)

type context = (var * typ) list

type exp =
  | Const of int
  | Plus of exp * exp
  | Times of exp * exp
  | GreaterThan of exp * exp (* return 1 for true, 0 for false *)
  | If of exp * exp * exp (* third exp if first exp is 0, else second exp *)
  | Var of var
  | Fun of var * typ * exp
  | Apply of exp * exp
  | Closure of exp * env (* not in source programs *)
  | Get of exp (* retrieve label contents *)
  | Set of exp * exp (* assignment of second to contents of first *)
  | Alloc of exp (* make a new reference *)
  | Label of label (* not in source programs *)
and env = (var * exp) list
and heap = (label * exp) list

(* for debugging purposes -- not thoroughly tested -- buyer beware *)

let rec typ2string t =
  match t with
    Int -> "int"
  | Arrow(t1,t2) -> "(" ^ (typ2string t1) ^ "->" ^ (typ2string t2) ^ ")"
  | Ref t -> "ref(" ^ (typ2string t) ^ ")"

let rec exp2string e =
  match e with
    Const i -> string_of_int i
  | Plus(e1,e2) -> "(" ^ (exp2string e1) ^ "+" ^ (exp2string e2) ^ ")"
  | Times(e1,e2) -> "(" ^ (exp2string e1) ^ "*" ^ (exp2string e2) ^ ")"
  | GreaterThan(e1,e2) -> "(" ^ (exp2string e1) ^ ">" ^ (exp2string e2) ^ ")"
  | If(e1,e2,e3) -> "(if "   ^ (exp2string e1) ^ 
                    " then " ^ (exp2string e2) ^ 
                    " else " ^ (exp2string e3) ^ ")"
  | Var(v) -> v
  | Fun(x,t,e) ->
      "(fun " ^ x ^ " : " ^ (typ2string t) ^ " . " ^ (exp2string e) ^ ")"
  | Apply(e1,e2) -> (exp2string e1) ^ " " ^ (exp2string e2)
  | Closure(e,env) ->
      "<" ^ (exp2string e) ^ " , " ^ list2string env ^ ">" 
  | Get e -> "(! " ^ (exp2string e) ^ ")"
  | Set(e1,e2) -> "(" ^ (exp2string e1) ^ " := " ^ (exp2string e2) ^ ")"
  | Alloc e -> "(ref " ^ (exp2string e) ^ ")"
  | Label l ->	"__" ^ l

and list2string env = (* works for environments and heaps *)
  match env with
    [] -> "."
  | (x,v)::tl -> (list2string tl) ^ "," ^ x ^ " --> " ^ (exp2string v)


