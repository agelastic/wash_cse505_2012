
type exp = 
    Int of int
  | Var of string
  | Plus of exp * exp
  | Times of exp * exp

type stmt = 
    Skip 
  | Assign of string * exp 
  | Seq of stmt * stmt
  | If of exp * stmt * stmt
  | While of exp * stmt

  | Pushheap
  | Popheap of string
  | Pushvar of string
  | Popvar  of string
