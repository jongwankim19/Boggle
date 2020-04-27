open Setup
open Prefixtree

let main () = 
  ANSITerminal.(print_string [cyan] 
                  "\n\nWelcome to our modified Boggle game! \n\n");
  let board = generate_board_init 16 in 
  ANSITerminal.(print_string [yellow] 
                  "These are the point values: \n\n");
  board |> scores;
  ANSITerminal.(print_string [yellow] 
                  "This is your board: \n\n");
  board |> to_board_str_list |> display;
  print_endline "\n";
  match read_line () with
  | exception End_of_file -> ()
  | file_name -> raise (Failure "not done")

(* Execute the game engine. *)
let () = main ()