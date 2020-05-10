open Setup
open Prefixtree
open Check
open Filecheck

let rec compile_words user_words = 
  match user_words with 
  | [] -> ""
  | h :: [] -> h
  | h :: t -> h ^ ", " ^ compile_words t

let end_state user_words dict = 
  "You inputted the following words: " ^ "[" ^ compile_words user_words ^ "]\n" 
  |> print_endline;

  let valids = get_valids user_words dict in 
  let cnt = List.length valids in 
  Printf.printf "The count of your valid words is: %d\n" cnt;
  cnt |> print_to_file "scores.txt";
  print_string "These are the words that you got right: ";
  ANSITerminal.(print_string [green; Bold] 
                  ("[" ^ compile_words valids ^ "]\n" ));

  print_endline "\n";

  ANSITerminal.(print_string [yellow] 
                  "Would you like to view the top 3 scores? (y/n) ");
  let ans = read_line () |> String.lowercase_ascii in 
  if ans = "y" then 
    "scores.txt" |> compile_scores |> compile_words |> print_endline 
  else ();

  ANSITerminal.(print_string [magenta; Bold] 
                  "\nGood bye. See you next time.\n\n");
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
    ANSITerminal.(print_string [magenta; Bold] 
                    ("\n" ^ "|-----------------|" ^ "\n" ^ 
                     "|                 |" ^ "\n" ^ "| *** TIME UP *** |" ^ 
                     "\n" ^ "|                 |" ^ "\n"  ^ 
                     "|-----------------|" ^ "\n" ^ "\n\n"));
    end_state (List.sort_uniq compare user_words) dict
  end 
  else begin
    print_string "> ";
    let word = read_line () in 
    play (word :: user_words) dict board time_limit start
  end

(** [main ()] sets up the game. *)
let main () = 
  ANSITerminal.(print_string [cyan; Bold] 
                  "\n\nWelcome to our Boggle game! \n\n");

  ANSITerminal.(print_string [yellow] 
                  "Would you like to clear the existing scores first? (y/n) ");
  let clear = read_line () |> String.lowercase_ascii in 
  clear |> clear_score "scores.txt";

  print_endline "\n";

  let board = generate_board_init 16 in 
  let dictionary = word_list "dictionary.txt" in begin
    ANSITerminal.(print_string [yellow; Bold] "This is your board: \n\n");
    board |> to_board_str_list |> display;

    print_endline "\n";

    ANSITerminal.(print_string [yellow; Bold] 
                    "How many seconds would you like? ");

    let req_time = read_line () |> float_of_string_opt in 
    match req_time with 
    | None -> 
      ANSITerminal.(print_string [magenta; Bold] 
                      "\n\nGame ended due to invalid time.\n\n");
    | Some time -> Unix.gettimeofday () |> play [] dictionary board time
  end

(* Execute the game engine. *)
let () = main ()