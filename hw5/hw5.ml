
open Event

exception BadLockState

(************* put problem 3 here ***************)

(********* complicated way to do se_locks *******)

type se_lock1 = unit channel channel * unit channel channel * unit channel

let new_selock1 () =
  let share_ch     = new_channel() in
  let exclusive_ch = new_channel() in
  let release_ch   = new_channel() in
  let rec unlocked () =
    sync (choose [ wrap (receive share_ch)
		     (fun c -> 
		       sync (send c ());
		       shared 1 []);
		   wrap (receive exclusive_ch)
		     (fun c ->
		       sync (send c ());
		       exclusive [] []);
		   wrap (receive release_ch)
		     (fun () -> raise BadLockState) ])
  and shared count waiting_exclusive =
    sync (choose [ wrap (receive share_ch) 
		     (fun c -> 
		       sync (send c ());
		       shared (count + 1) waiting_exclusive);
		   wrap (receive exclusive_ch)
		     (fun c -> 
		       shared count (c::waiting_exclusive));
		   wrap (receive release_ch)
		     (fun () ->
		       match count, waiting_exclusive with
		       | 1, []     -> unlocked ()
		       | 1, hd::tl -> sync (send hd ()); exclusive [] tl
		       | _, _      -> shared (count - 1) waiting_exclusive) ])
  and exclusive waiting_shared waiting_exclusive =
    sync (choose [ wrap (receive share_ch)
		     (fun c ->
		       exclusive (c::waiting_shared) waiting_exclusive);
		   wrap (receive exclusive_ch)
		     (fun c ->
		       exclusive waiting_shared (c::waiting_exclusive));
		   wrap (receive release_ch)
		     (fun () ->
		       match waiting_shared, waiting_exclusive with
		       | [],[]     -> unlocked ()
		       | [],hd::tl -> sync (send hd ()); exclusive [] tl
		       | _::_,_    -> List.iter (fun c -> sync (send c ())) 
			                        waiting_shared;
			              shared (List.length waiting_shared) 
			                     waiting_exclusive) ])
  in
  ignore(Thread.create unlocked ());
  (share_ch,exclusive_ch,release_ch)

let with_lock1 start_ch end_ch th =
  let c = new_channel() in
  sync (send start_ch c);
  sync (receive c);
  try let ans = th () in sync (send end_ch ()); ans
  with x -> sync (send end_ch ()); raise x

let shared_do1    (c1,_,c2) th = with_lock1 c1 c2 th
let exclusive_do1 (_,c1,c2) th = with_lock1 c1 c2 th

(************* put problem 4 here ***************)

type se_lock2 = unit channel * unit channel * unit channel (* don't change *)

