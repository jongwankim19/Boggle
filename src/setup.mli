type tile 

val adjacency_list : int list list

val make_tile : string -> int -> tile

val generate_board_init : int -> tile list

val to_board_str_list : tile list -> string list

val display : string list -> unit

val word_list : string -> string list

val all_words : tile list -> Prefixtree.t -> string list