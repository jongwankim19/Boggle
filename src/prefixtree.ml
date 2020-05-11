type node = {
  letter : char;
  children : t
} 

and t = node list

let empty : t = []

let rec mem_helper x lst = 
  match lst with 
  | [] -> false
  | h :: t -> if h = x then true else mem_helper x t

let mem x lst = mem_helper x lst

(** [str_to_list word] converts a string into a list of char characters. *)
let str_to_list word : char list = 
  let rec tokenize i lst = 
    if i < 0 then lst else tokenize (i - 1) (word.[i] :: lst) in 
  tokenize (String.length word - 1) []

let update str tr : t = 
  let to_list = str_to_list str in 
  let rec update_helper st tr = 
    match st with 
    | [] -> tr
    | h :: tl ->  
      let nd = 
        try List.find (fun x -> x.letter = h) tr
        with Not_found -> {letter = h; children = []}
      in {letter = nd.letter; children = update_helper tl nd.children} :: 
         List.filter (fun x -> x.letter != h) tr 
  in update_helper to_list tr

let rec find_helper len ind tr str = 
  try 
    let nd = List.find (fun x -> str.[ind] = x.letter) tr in 
    if ind = len - 1 then Some ind else 
      find_helper len (ind + 1) nd.children str
  with Not_found -> None

let find str tr : int option = find_helper (String.length str) 0 tr str

let create_trie dict : t =
  let rec create_helper lst tr =
    match lst with 
    | [] -> tr
    | h :: tl -> let tr = update h tr in create_helper tl tr
  in
  create_helper dict empty

let rec print_trie_helper tr = 
  match tr with 
  | [] -> ""
  | h :: [] -> String.make 1 h.letter
  | h :: t -> String.make 1 h.letter ^ ", " ^ print_trie_helper t

let print_trie (tr : t) = 
  "Trie: " ^ "[" ^ print_trie_helper tr ^ "]\n" |> print_endline;