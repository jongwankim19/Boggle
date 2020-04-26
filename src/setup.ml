open Prefixtree

type tile = {
  letters : string;
  points : int;
  position : int;
}

let adjacency_list = 
  [
    [1;4;5];
    [0;2;4;5;6];
    [1;3;5;6;7];
    [2;6;7];
    [0;1;5;9;8];
    [0;1;2;4;6;8;9;10];
    [1;2;3;5;7;9;10;11];
    [2;3;6;10;11];
    [4;5;9;12;13];
    [4;5;6;8;10;12;13;14];
    [5;6;7;9;11;13;14;15];
    [6;7;10;14;15];
    [8;9;13];
    [8;9;10;12;14];
    [9;10;11;13;15];
    [10;11;14];
  ]

(** [make_tile ltrs pos] instantiates the tile given the letter and position. *)
let make_tile ltrs pos = {
  letters = ltrs;
  points = Random.int 50;
  position = pos;
}

(** [generate_board n board] randomly generates a board of n strings. *)
let rec generate_board n board = if n = 0 then board else 
    begin
      let char1 = (97 + (Random.int 26)) |> Char.chr |> String.make 1 in 
      let char2 = (97 + (Random.int 26)) |> Char.chr |> String.make 1 in
      if Random.int 20 <= 5 then 
        generate_board (n-1) ((make_tile (char1 ^ char2) n) :: board) else 
        generate_board (n - 1) ((make_tile char1 n) :: board)
    end

(** [generate_board_init n] takes in the number of tiles and makes board. *)
let generate_board_init n = generate_board n []

(** [to_board_str board] converts a tile board into string board. *)
let to_board_str board = 
  let rec to_str board ret = 
    match board with 
    | [] -> ret
    | h :: t -> to_str t (h.letters :: ret)
  in [] |> to_str board |> List.rev |> String.concat ""

(** [display board_str] displays board in square form. *)
let display b = 
  Printf.printf "%c %c %c %c\n%c %c %c %c\n%c %c %c %c\n%c %c %c %c\n"
    b.[ 0] b.[ 1] b.[ 2] b.[ 3]
    b.[ 4] b.[ 5] b.[ 6] b.[ 7]
    b.[ 8] b.[ 9] b.[10] b.[11]
    b.[12] b.[13] b.[14] b.[15]