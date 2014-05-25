type inttree = Empty | Node of int * inttree * inttree

(* use this function in fromList *)
let rec insert t i =
  match t with
    Empty -> Node(i,Empty,Empty)
  | Node(j,l,r) -> 
     if i=j 
     then t 
     else if i < j 
     then Node(j,insert l i,r)
     else Node(j,l,insert r i)
              
(* no need for this function; it is just an example *)
let rec member t i =
  match t with
    Empty -> false
  | Node(j,l,r) -> i=j || (i < j && member l i) || member r i
                                                          
(* put fromList, sum1, prod1, avg1, map and negateAll here *)
let fromList l = 
  let rec f l a = 
    match l with
      [] -> a
    | h::t -> f t (insert a h)
  in f l Empty 
       
let rec sum1 t = 
  match t with
    Empty -> 0
  | Node(j,l,r) -> j + sum1 l + sum1 r 
                                     
let rec prod1 t = 
  match t with
    Empty -> 1
  | Node(j,l,r) -> j * prod1 l * prod1 r 

exception DivisionByZero

let avg1 t = 
  let rec f t = 
    match t with 
      Empty -> (0,0)
    | Node(j,l,r) -> 
       let (x1,y1) = f l in
       let (x2,y2) = f r in
       (j + x1 + x2, 1 + y1 + y2)
  in
  let (x,y) = f t in
  if y == 0 then raise DivisionByZero else x/y

let rec map f t =
  match t with
    Empty -> Empty
  | Node(j,l,r) -> Node(f j, map f l, map f r)
                       
let negateAll t = map (fun x -> - x) t
                      
let rec fold f a t =
  match t with
    Empty -> a
  | Node(j,l,r) -> fold f (fold f (f a j) l) r

(* put sum2, prod2, and avg2 here *)

let sum2 t = fold (fun x y -> x + y) 0 t
                  
let prod2 t = fold (fun x y -> x * y) 1 t

let avg2 t = 
  let (x, y) = fold (fun (a,b) c -> (a+c, b+1)) (0,0) t in
  if y == 0 then raise DivisionByZero else x / y 

type 'a iterator = Nomore | More of 'a * (unit -> 'a iterator)

let rec iter t =
  let rec f t k =
    match t with
      Empty -> k ()
    | Node(j,l,r) -> More(j, fun () -> f l (fun () -> f r k))
  in f t (fun () -> Nomore)

let sum3 t =
  let rec f i a = 
    match i with
      Nomore -> a
    | More(x,y) -> f (y()) a+x
  in f (iter t) 0

let prod3 t =
  let rec f i a = 
    match i with
      Nomore -> a
    | More(x,y) -> if x == 0 then a else f (y()) a+x
  in f (iter t) 0

let avg3 t =
  let rec f i (a,n) = 
    match i with
      Nomore -> (a,n)
    | More(x,y) -> f (y()) (a+x,n+1)
  in let (a,b) = f (iter t) (0,0) in
     if b = 0 then raise DivisionByZero else a / b

(* challenge problem: put optionToException and exceptionToOption here *)

let optionToException f e a = 
  let v = f a in 
  match v with
    None -> raise e
  | Some x -> x

let exceptionToOption f cond a = 
  try Some (f a)
  with x ->
    if cond x then None else raise x

(* a little testing -- commented out since the functions do not exist yet *)

let tr = fromList [0;1;2;3;4;5;6;7;8;9;9;9;1] (* repeats get removed *)
let print_ans f t = print_string (string_of_int (f t)); print_string "\n"
let _ = print_ans sum1 tr
let _ = print_ans prod1 tr
let _ = print_ans avg1 tr
let _ = print_ans sum2 tr
let _ = print_ans prod2 tr
let _ = print_ans avg2 tr
let _ = print_ans sum3 tr
let _ = print_ans prod3 tr
let _ = print_ans avg3 tr
