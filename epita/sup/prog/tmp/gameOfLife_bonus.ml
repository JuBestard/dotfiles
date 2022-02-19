
#use "gameOfLife.ml";;

let load_board name =
  let ic = open_in name in
  let try_read () =
    try Some (input_line ic) with End_of_file -> None in
  let rec convert acc i maxSize string = match i with
    |i when i = maxSize -> acc
    |_ -> convert (int_of_string(Char.escaped(string.[i]))::acc) (i+1) maxSize string in
  let rec loop () = match try_read() with
    Some s -> (convert [] 0 (String.length s) s)::(loop ())
    |None -> close_in ic; []
  in loop();;

let save_board filename board =
  let oc = open_out filename in
  let rec auxList = function
    |[] -> Printf.fprintf oc "\n"
    |e::l -> Printf.fprintf oc "%i" e; auxList l in
  let rec auxBoard = function
    |[] -> close_out oc
    |e::b -> auxList e;auxBoard b
  in auxBoard board;;

let init_pattern pattern size =
  let rec placeAlive board = function
    |[] -> board
    |e::b -> placeAlive (put_cell 1 e board) b
  in placeAlive (init_board (size,size) 0) pattern;;

let new_game_pattern board size nb = game board size nb;;

let rec searchl list = match list with
    |[] -> false
    |e::l when e = 1 -> true
    |e::l -> searchl l;;

let rec remaining board = match board with
  |[] -> false
  |l::b when searchl l = true -> true
  |l::b -> remaining b;;

let new_game_survival size nbcell =
  let board = new_board size nbcell in
  let rec flag board size =
    if (remaining board) = true then
      (draw_board board cell_size;sleep 1; flag (next_generation board size) size)
    else
      draw_board board cell_size
  in flag board size;;

let new_game_pattern_survial board size =
  let board = init_pattern board size in
  let rec flag board size =
    if (remaining board) = true then
      (draw_board board cell_size;sleep 1; flag (next_generation board size) size)
    else
      draw_board board cell_size
  in flag board size;;




let gameWDrawing board size n =
  let rec p_list oldList newList (x,y) = match oldList,newList with
    |[],[] -> ()
    |[],_ | _,[] -> failwith "warning suppr"
    |e1::ol,e2::nl -> (if e1<>e2 then
                         (draw_cell (x,y) cell_size (cell_color e2) ;
                          p_list ol nl (x,y+cell_size))
                       else
                         p_list ol nl (x,y+cell_size)) in

  let rec draw oldBoard newBoard (x,y) = match oldBoard,newBoard with
    |[],[] -> ()
    |[],_ | _,[] -> failwith "warning suppr"
    |ol::ob,nl::nb -> (p_list ol nl (x,y); draw ob nb (x+cell_size,y)) in

  let rec flag board = function
    |0 -> ()
    |n -> (sleep 1 ; draw board (next_generation board size) (50,50) ;
           flag (next_generation board size) (n-1))

  in (draw_board board cell_size ; flag board n);;

