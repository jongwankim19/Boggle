open Setup
open Prefixtree

(** [round_float flt] rounds [flt] to two decimal places. *)
let round_float flt = (flt *. 100. +. 0.5 |> floor) /. 100.

(** [play time_limit start] plays the game until [time_limit]. *)
let rec play time_limit start = 
  let time_diff = Unix.gettimeofday () -. start in 
  if time_diff > time_limit then begin
    ANSITerminal.(print_string [magenta] "\n\n*** GAME OVER ***\n\n"); exit 0 
  end 
  else begin
    ANSITerminal.(print_string [green] 
                    ("\n" ^ (time_diff |> round_float |> string_of_float) 
                     ^ " seconds elapsed.\n\n"));
    print_string "> ";
    let c = read_line () in 
    play time_limit start
  end

(** [main ()] sets up the game. *)
let main () = 
  ANSITerminal.(print_string [cyan] 
                  "\n\nWelcome to our modified Boggle game! \n\n");

  let board = generate_board_init 16 in 
  ANSITerminal.(print_string [yellow] "These are the point values: \n\n");
  board |> scores;
  ANSITerminal.(print_string [yellow] "This is your board: \n\n");
  board |> to_board_str_list |> display;

  print_endline "\n";

  ANSITerminal.(print_string [yellow] "How many seconds would you like? ");

  let req_time = read_line () |> float_of_string_opt in 
  match req_time with 
  | None -> 
    ANSITerminal.(print_string [magenta] 
                    "\n\nGame ended due to invalid time.\n\n");
  | Some time -> Unix.gettimeofday () |> play time

(* Execute the game engine. *)
let () = main ()