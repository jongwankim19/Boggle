let print_to_file file score = 
  let oc = open_out_gen [Open_append; Open_creat] 0o666 file in 
  Printf.fprintf oc "%d\n" score;
  close_out oc

let clear_score file ans = if ans = "y" then
    let oc = open_out_gen [Open_trunc] 0o666 file in close_out oc
  else if ans = "n" then () else begin 
    let () = ANSITerminal.(print_string [magenta; Bold] 
                             "\n\nGame ended due to invalid response.\n\n") in
    exit 0
  end

let rec top_three n ret lst = 
  match lst with 
  | [] -> ret
  | h :: t -> if n = 0 then ret else 
      top_three (n - 1) (("(" ^ string_of_int (4 - n) ^ ") " ^ h) :: ret) t

let compile_scores file = 
  let ic = open_in file in 
  let rec read lst = 
    match input_line ic with
    | score -> read (score :: lst)
    | exception End_of_file -> close_in ic; 
      lst |> List.sort compare |> List.rev
  in [] |> read |> top_three 3 [] |> List.sort compare