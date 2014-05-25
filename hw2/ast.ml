
type valu = VConst of int 
          | VPair of valu * valu 
	  | VTagged of string * valu

type pattern = PWild 
             | PVar of string 
	     | PConst of int 
	     | PPair of pattern * pattern
	     | PTagged of string * pattern
	     | PDescendent of pattern

