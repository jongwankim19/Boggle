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
  val get_valids : string list -> string list -> string list
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