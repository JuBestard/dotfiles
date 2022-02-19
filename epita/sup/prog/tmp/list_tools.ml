#load "graphics.cma";;
#use "topfind";;
#require "graphics";;
open Graphics;;

(* Return the nth elt of a list -> 'a *)
(* i -> int | list -> a' list *)
let rec nth i list =
  if i < 0 then
    invalid_arg "i must be positive (>=0)"
  else
    let rec nth_rec i list = match i,list with
    |_,[] -> failwith "nth: list is too short"
    |0,e::l -> e
    |i,e::l -> nth (i-1) l
    in nth_rec i list;;

(* Build a list of n times x *)
(* n & x -> int *)
let init_list n x =
  if n < 0 then
    invalid_arg "init_list : n must be a natural"
  else
    let rec init_rec n x = match n with
      |0 -> []
      |_ -> x::init_rec (n-1) x
    in init_rec n x;;

(* Replace the nth element of list by v*)
(* i -> int | v -> 'a | list -> 'a list *)
let put_list v i list =
  if i<0 then
    list
  else
    let rec replace v i l = match l with
      |[] -> l
      |e::l when i=0 -> v::l
      |e::l -> e::replace v (i-1) l
    in replace v i list;;

(* Build a matrice of size l*c filled with v -> 'a list list *)
(* (l,c) -> int * int | v -> 'a *)
let rec init_board (l,c) v = match l with
  |0 -> [init_list c v]
  |_ -> (init_list c v)::init_board ((l-1),c) v;;

(* Return the element at position (x,y) -> 'a*)
(* (x,y) -> int*int *)
let get_cell (x,y) board = nth y (nth x board);;

(* Replace the element at position (x,y) by v -> 'a list list *)
(* v -> 'a | (x,y) -> int * int *)
let rec put_cell v (x,y) board = match board with
  |[] -> board
  |l::b when x = 0 -> (put_list v y l)::b
  |l::b -> l::put_cell v ((x-1),y) b;;

let rec length list = match list with
  |[] -> 0
  |e::l -> 1 + length l;;

let rec print_board board =
  let rec print list = match list with
    |[] -> ()
    |e::l -> (print_int(e);print l)
  in match board with
  |[] -> ()
  |e::b -> (print e;print_newline();print_board(b));;

let open_window size = open_graph( " " ^ string_of_int size ^ "x" ^ string_of_int(size+20));;

let draw_cell (x,y) size color =
  set_color color;
  fill_rect x y size size;
  set_color black;
  draw_rect x y size size;;

let cell_color = function
    |0 -> white
    |_ -> black;;

let draw_board board cellsize =
  clear_graph();
  let rec p_list list (x,y) = match list with
    |[] -> ()
    |e::l -> draw_cell (x,y) cellsize (cell_color e); p_list l (x,y+cellsize) in
  let rec draw board (x,y) = match board with
    |[] -> ()
    |e::b -> (p_list e (x,y); draw b (x+cellsize,y))
  in draw board (50,50);;

let board =
[[1;0;1;1;0];
 [0;1;0;0;1];
 [0;0;1;0;0];
 [1;1;0;0;1];
 [0;1;0;1;0]];;

let test_display board cell_size =
  open_window( length board * cell_size +40);
  draw_board board cell_size ;;
