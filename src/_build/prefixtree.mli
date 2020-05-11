type node

type t

val empty : t

val mem : int -> int list -> bool

val str_to_list : string -> char list

val update : string -> t -> t

val find : string -> t -> int option

val create_trie : string list -> t

val print_trie : t -> unit