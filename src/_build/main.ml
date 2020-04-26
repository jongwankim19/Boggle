open Setup
open Prefixtree

let main () = 
  ANSITerminal.(print_string [cyan] 
                  "\n\nWelcome to our modified Boggle game! \n\n");
  print_endline "This is your board: \n";
  16 |> generate_board_init |> to_board_str |> display;
  print_endline "\n";
  match read_line () with
  | exception End_of_file -> ()
  | file_name -> raise (Failure "not done")

(* Execute the game engine. *)
let () = main ()