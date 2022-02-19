#use "list_tools.ml";;
#use "topfind";;
#require "unix";;

open Random;;
open Unix;;


let new_cell = 1;;
let empty = 0;;
let is_alive cell = cell <> empty;;

(*==LES REGLES==*)

let rules0 cell near = match cell with
  |0 -> if near = 3 then 1 else 0
  |_ -> if near = 3 || near = 2 then 1 else 0;;

let count_neighbours (x,y) board size = match x with
  |x when x = 0 -> if y = 0 then
      get_cell (x+1,y) board + get_cell (x+1,y+1) board + get_cell (x,y+1) board
    else if  y = size then
      get_cell (x,y-1) board + get_cell (x+1,y-1) board  +get_cell (x+1,y) board
    else
      get_cell (x,y-1) board + get_cell (x+1,y-1) board + get_cell (x+1,y) board +
      get_cell (x+1,y+1) board + get_cell (x,y+1) board

  |x when x = size -> if y = 0 then
      get_cell (x-1,y) board + get_cell (x-1,y+1) board +get_cell (x,y+1) board
    else if y = size then
      get_cell (x-1,y) board + get_cell (x-1,y-1) board +get_cell (x,y-1) board
    else
      get_cell (x,y-1) board + get_cell (x-1,y-1) board + get_cell (x-1,y) board +
      get_cell (x-1,y+1) board + get_cell (x,y+1) board

  |_ -> if y = 0 then
      get_cell (x-1,y) board + get_cell (x-1,y+1) board + get_cell (x,y+1) board +
      get_cell (x+1,y+1) board + get_cell (x+1,y) board

    else if  y = size then
      get_cell (x-1,y) board + get_cell (x-1,y-1) board + get_cell (x,y-1) board +
      get_cell (x+1,y-1) board + get_cell (x+1,y) board

    else  get_cell (x-1,y-1) board + get_cell (x-1,y) board +
          get_cell (x-1,y+1) board + get_cell (x,y+1) board +
          get_cell (x+1,y+1) board + get_cell (x+1,y) board +
          get_cell (x+1,y-1) board + get_cell (x,y-1) board ;;

(*==LA VIE==*)

let seed_life board size nb_cell =
  if nb_cell <= (size*size) then
    let rec life board size nb_cell = match nb_cell with
      |0 -> board
      |_ -> begin
          let (x,y) = (int(size),int(size)) in
          if (get_cell (x,y) board) = 1 then
            life board size nb_cell
          else
            life (put_cell 1 (x,y) board) size (nb_cell -1)
        end in life board size nb_cell
  else
    invalid_arg "not enough case top place this number of cell";;

let new_board size nb_cell = seed_life (init_board (size,size) 0) size nb_cell;;

let next_generation board size =
  let rec parcours (x,y) acc acc2 = match x,y with
    |0,0 -> let temp = ((rules0 (get_cell (x,y) board) (count_neighbours (x,y) board size))::acc) in
      temp::acc2
    |_,y when y = 0 -> let temp = ((rules0 (get_cell (x,y) board) (count_neighbours (x,y) board size))::acc)
      in  parcours (x-1,size) []  (temp::acc2)
    |_,_ -> parcours (x,y-1) ((rules0 (get_cell (x,y) board) (count_neighbours (x,y) board size))::acc) acc2
  in parcours (size,size) [] [];;

let next_generation2 board size =
  let rec parcours (x,y) board size = match x,y with
    |x,y when x=size && y=size -> put_cell (rules0 (get_cell (x,y) board) (count_neighbours (x,y) board size)) (x,y) board
    |_,y when y = size -> parcours (x+1,0) (put_cell (rules0 (get_cell (x,y) board) (count_neighbours (x,y) board size)) (x,y) board) size
    |_,_ -> parcours (x,y+1) (put_cell (rules0 (get_cell (x,y) board) (count_neighbours (x,y) board size)) (x,y) board) size
  in parcours (0,0) board size;;

let cell_size = 50 ;;

(*open_window( length board * cell_size +40);;*)

let game board size n = 
  open_window (length board * cell_size+100);
  let rec flag board n = match n with
  |0 -> draw_board board cell_size
  |_ -> (draw_board board cell_size;sleep 1;flag (next_generation board size) (n-1))
  in flag board n;;

let new_game size nbcell n =
  game (new_board size nbcell) (size-1) n;;


