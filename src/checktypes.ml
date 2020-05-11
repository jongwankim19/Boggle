module type SetupSig = sig
  type tile 
  val adjacency_list : int list list
  val make_tile : string -> int -> tile
  val generate_board_init : int -> tile list
  val to_board_str_list : tile list -> string list
  val display : string list -> unit
  val word_list : string -> string list
  val all_words : tile list -> Prefixtree.t -> string list
end

module SetupCheck : SetupSig = Setup

module type PrefixtreeSig = sig
  type node
  type t
  val empty : t
  val mem : int -> int list -> bool
  val str_to_list : string -> char list
  val update : string -> t -> t
  val find : string -> t -> int option
  val create_trie : string list -> t
  val print_trie : t -> unit
end

module PrefixTreeCheck : PrefixtreeSig = Prefixtree

module type CheckSig = sig
  val get_valids : string list -> string list -> string list
  val intersect : string list -> string list -> string list
end

module CheckCheck : CheckSig = Check

module type FilecheckSig = sig
  val print_to_file : string -> int -> unit
  val clear_score : string -> string -> unit
  val compile_scores : string -> string list
end

module FileCheckCheck : FilecheckSig = Filecheck

module type AuthorsSig = sig
  val hours_worked : int list
end

module AuthorsCheck : AuthorsSig = Authors