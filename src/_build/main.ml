open Setup
open Prefixtree
open Check

let rec compile_words user_words = 
  match user_words with 
  | [] -> ""
  | h :: [] -> h
  | h :: t -> h ^ ", " ^ compile_words t


let end_state user_words dict = 
  "This is the list of your inputs: " ^ "[" ^ compile_words user_words ^ "]\n" 
  |> print_string;
  get_valids user_words dict 0 |> 
  Printf.printf "The number of your valid words is: %d";
  exit 0

(** [round_float flt] rounds [flt] to two decimal places. *)
let round_float flt = (flt *. 100. +. 0.5 |> floor) /. 100.

(** [play board time_limit start] plays the game until [time_limit]. *)
let rec play user_words dict board time_limit start = 
  let time_diff = Unix.gettimeofday () -. start in 
  let () = ANSITerminal.(print_string [green] 
                           ("\n" ^ (time_diff |> round_float |> string_of_float)
                            ^ " seconds elapsed.\n\n")); in 
  if time_diff > time_limit then begin
    ANSITerminal.(print_string [magenta] "\n\n*** TIME UP ***\n\n");
    end_state (List.sort_uniq compare user_words) dict
  end 
  else begin
    print_string "> ";
    let word = read_line () in 
    play (word :: user_words) dict board time_limit start
  end

(** [main ()] sets up the game. *)
let main () = 
  ANSITerminal.(print_string [cyan] 
                  "\n\nWelcome to our Boggle game! \n\n");

  let board = generate_board_init 16 in 
  let dictionary = word_list "dictionary.txt" in begin
    ANSITerminal.(print_string [yellow] "This is your board: \n\n");
    board |> to_board_str_list |> display;

    print_endline "\n";

    ANSITerminal.(print_string [yellow] "How many seconds would you like? ");

    let req_time = read_line () |> float_of_string_opt in 
    match req_time with 
    | None -> 
      ANSITerminal.(print_string [magenta] 
                      "\n\nGame ended due to invalid time.\n\n");
    | Some time -> Unix.gettimeofday () |> play [] dictionary board time
  end

(* Execute the game engine. *)
let () = main ()