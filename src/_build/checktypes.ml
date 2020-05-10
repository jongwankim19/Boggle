module type SetupSig = sig
  type tile 
  val make_tile : string -> int -> tile
  val generate_board_init : int -> tile list
  val to_board_str_list : tile list -> string list
  val display : string list -> unit
  val word_list : string -> string list
end

module SetupCheck : SetupSig = Setup

module type PrefixtreeSig = sig
  type prefix_tree
  val init : string -> prefix_tree
end

module PrefixTreeCheck : PrefixtreeSig = Prefixtree

module type CheckSig = sig
  val get_valids : string list -> string list -> int -> int
end

module CheckCheck : CheckSig = Check

module type AuthorsSig = sig
  val hours_worked : int list
end

module AuthorsCheck : AuthorsSig = Authors