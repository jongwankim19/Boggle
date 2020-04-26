type prefix_tree = {
  letter : string;
  children : (string * prefix_tree) list;
}

let init ltr = {
  letter = ltr;
  children = [];
}

(** [str_to_list word] converts a string into a list of string characters. *)
let str_to_list word = 
  let rec tokenize i lst = 
    if i < 0 then lst else tokenize (i - 1) (String.make 1 word.[i] :: lst) in 
  tokenize (String.length word - 1) []

(** [mem ltr lst] checks if key of [ltr] exists in [lst]. *)
let rec mem ltr lst = 
  match lst with 
  | [] -> false
  | (k, v) :: t -> if k = ltr then true else mem ltr t

(** [get ltr lst] gets the value associated with the key of [ltr] from [lst]. *)
let rec get ltr lst = 
  match lst with 
  | [] -> raise (Failure "Something went wrong")
  | (k, v) :: t -> if k = ltr then v else get ltr t

(** [insert key trie lst] inserts (key, trie) pair to [lst]. *)
let rec insert key trie lst = 
  match lst with 
  | [] -> (key, trie) :: lst
  | (k, v) :: t -> if k = key then lst else insert key trie t

(** [add word trie] adds the word to prefix tree recursively. *)
let rec add word trie =
  match str_to_list word with
  | [] -> trie
  | h :: t -> if mem h trie.children 
    then trie.children |> get h |> add (String.concat "" t)
    else trie.children |> insert h (init h) |> get h |> add (String.concat "" t)