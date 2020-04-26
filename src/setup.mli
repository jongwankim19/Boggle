type tile 

val make_tile : string -> int -> tile

val generate_board_init : int -> tile list

val to_board_str : tile list -> string

val display : string -> unit