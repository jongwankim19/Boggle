open Prefixtree

type tile = {
  letters : string;
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
  position = pos;
}

(** [generate_board n board] randomly generates a board of n strings. *)
let rec generate_board n board = if n = 0 then board else 
    begin
      let () = Random.self_init () in 
      let char1 = (97 + (Random.int 26)) |> Char.chr |> String.make 1 in
      let char2 = (97 + (Random.int 26)) |> Char.chr |> String.make 1 in
      (*if Random.int 100 < 5 then 
        generate_board (n - 1) ((make_tile (char1 ^ char2) n) :: board) else
      *)generate_board (n - 1) ((make_tile char1 n) :: board)
    end

(** [generate_board_init n] takes in the number of tiles and makes board. *)
let generate_board_init n = generate_board n []

(** [to_board_str board] converts a tile board into string board. *)
let to_board_str_list board = 
  let rec to_str board ret = 
    match board with 
    | [] -> ret
    | h :: t -> to_str t (h.letters :: ret)
  in [] |> to_str board |> List.rev

(** [display b] displays board in square form. *)
let display b = 
  Printf.printf "%s %s %s %s\n%s %s %s %s\n%s %s %s %s\n%s %s %s %s\n"
    (List.nth b 0) (List.nth b 1) (List.nth b 2) (List.nth b 3)
    (List.nth b 4) (List.nth b 5) (List.nth b 6) (List.nth b 7) 
    (List.nth b 8) (List.nth b 9) (List.nth b 10) (List.nth b 11)
    (List.nth b 12) (List.nth b 13) (List.nth b 14) (List.nth b 15)

(** [word_list file_name] loads all words in [file_name] into a list. *)
let word_list file_name = 
  let file = open_in file_name in 
  let rec read lst = 
    match input_line file with
    | word -> read (String.lowercase_ascii word :: lst)
    | exception End_of_file -> close_in file; List.rev lst
  in read []

let rec memword word dict = 
  match dict with 
  | [] -> false
  | h :: t -> if h = word then true else memword word t

let rec all_possible_helper board ind visited running tr st = 
  if mem ind visited then running else 
    let cur_tile = List.nth board ind in 
    let new_str = st ^ cur_tile.letters in 
    let adj = List.nth adjacency_list ind in 
    match find new_str tr with 
    | None -> running
    | Some v -> if memword new_str running then running else 
        for_each board adj (ind::visited) (new_str::running) tr new_str

and for_each board inds visited running tr str = 
  match inds with 
  | [] -> running
  | h :: t -> if mem h visited then running  else for_each board t visited 
        (all_possible_helper board h visited running tr str) tr str

let rec all_possible board ind running tr = 
  if ind = 16 then running else 
    let new_running = all_possible_helper board ind [] running tr "" in 
    all_possible board (ind + 1) (List.append new_running running) tr

let all_words board tr = all_possible board 0 [] tr |> List.sort_uniq compare