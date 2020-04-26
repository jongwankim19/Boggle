type prefix_tree = {
  letter : string;
  children : (string * prefix_tree) list;
}

let init ltr = {
  letter = ltr;
  children = [];
}

let str_to_list word = 
  let rec tokenize i lst = 
    if i < 0 then lst else tokenize (i - 1) (String.make 1 word.[i] :: lst) in 
  tokenize (String.length word - 1) []

let rec mem ltr lst = 
  match lst with 
  | [] -> false
  | (k, v) :: t -> if k = ltr then true else mem ltr t

let insert key trie lst = (key, trie) :: lst

let rec get ltr lst d = 
  match lst with 
  | [] -> begin 
      insert ltr (init ltr) d;
      init ltr
    end
  | (k, v) :: t -> if k = ltr then v else get ltr t d

let rec add word trie =
  match str_to_list word with
  | [] -> trie
  | h :: t -> add (String.concat "" t) (get h trie.children trie.children)