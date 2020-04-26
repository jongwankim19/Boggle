module type SetupSig = sig
  type tile 
  val make_tile : string -> int -> tile
  val generate_board_init : int -> tile list
end

module SetupCheck : SetupSig = Setup

module type PrefixTreeSig = sig

end

module PrefixTreeCheck : PrefixTreeSig = PrefixTree

module type AuthorsSig = sig
  val hours_worked : int list
end

module AuthorsCheck : AuthorsSig = Authors