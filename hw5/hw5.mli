
(* uncomment when you do problem 3
type barrier
val new_barrier : int -> barrier
val wait : barrier -> unit
*)

type se_lock1
val new_selock1   : unit -> se_lock1
val shared_do1    : se_lock1 -> (unit -> 'a) -> 'a
val exclusive_do1 : se_lock1 -> (unit -> 'a) -> 'a

(* uncomment when you do problem 4
type se_lock2
val new_selock2   : unit -> se_lock2
val shared_do2    : se_lock2 -> (unit -> 'a) -> 'a
val exclusive_do2 : se_lock2 -> (unit -> 'a) -> 'a
*)
