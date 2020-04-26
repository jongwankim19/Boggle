open Prefixtree

type tile = {
  letters : string;
  points : int;
  position : int;
}

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