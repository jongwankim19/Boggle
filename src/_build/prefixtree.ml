type prefix_tree = {
  letter : string;
  children : (string * prefix_tree) list;
  leaf : bool;
}

let init ltr = {
  letter = ltr;
  children = [];
  leaf = false;
}