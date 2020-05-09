let rec mem word dict = 
  match dict with 
  | [] -> false
  | h :: t -> if h = word then true else mem word t

let rec valid_count user_words dict cnt = 
  match user_words with 
  | [] -> cnt
  | h :: t -> if mem h dict then valid_count t dict (1 + cnt)
    else valid_count t dict (1 + cnt)

let get_valids user_words dict cnt = valid_count user_words dict cnt