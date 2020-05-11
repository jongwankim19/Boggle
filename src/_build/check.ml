let rec mem word dict = 
  match dict with 
  | [] -> false
  | h :: t -> if h = word then true else mem word t

let rec valid_count user_words dict lst = 
  match user_words with 
  | [] -> lst
  | h :: t -> if mem h dict then valid_count t dict (h :: lst)
    else valid_count t dict lst

let get_valids user_words dict = valid_count user_words dict []

let rec intersect_helper lst1 lst2 ret = 
  match lst1 with 
  | [] -> ret
  | h :: t -> if mem h lst2 then intersect_helper t lst2 (h :: ret) else 
      intersect_helper t lst2 ret

let intersect lst1 lst2 = 
  intersect_helper 
    (lst1 |> List.sort_uniq compare) (lst2 |> List.sort_uniq compare) []