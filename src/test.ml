open OUnit2
open Setup
open Prefixtree
open Check
open Filecheck

(********************************************************************
   Here are some helper functions for your testing of set-like lists. 
 ********************************************************************)

(** [cmp_set_like_lists lst1 lst2] compares two lists to see whether
    they are equivalent set-like lists.  That means checking two things.
    First, they must both be {i set-like}, meaning that they do not
    contain any duplicates.  Second, they must contain the same elements,
    though not necessarily in the same order. *)
let cmp_set_like_lists lst1 lst2 =
  let uniq1 = List.sort_uniq compare lst1 in
  let uniq2 = List.sort_uniq compare lst2 in
  List.length lst1 = List.length uniq1
  &&
  List.length lst2 = List.length uniq2
  &&
  uniq1 = uniq2

(** [pp_string s] pretty-prints string [s]. *)
let pp_string s = "\"" ^ s ^ "\""

(** [pp_list pp_elt lst] pretty-prints list [lst], using [pp_elt]
    to pretty-print each element of [lst]. *)
let pp_list pp_elt lst =
  let pp_elts lst =
    let rec loop n acc = function
      | [] -> acc
      | [h] -> acc ^ pp_elt h
      | h1::(h2::t as t') ->
        if n=100 then acc ^ "..."  (* stop printing long list *)
        else loop (n+1) (acc ^ (pp_elt h1) ^ "; ") t'
    in loop 0 "" lst
  in "[" ^ pp_elts lst ^ "]"

(* These tests demonstrate how to use [cmp_set_like_lists] and 
   [pp_list] to get helpful output from OUnit. *)
let cmp_demo = 
  [
    "order is irrelevant" >:: (fun _ -> 
        assert_equal ~cmp:cmp_set_like_lists ~printer:(pp_list pp_string)
          ["foo"; "bar"] ["bar"; "foo"]);
    (* Uncomment this test to see what happens when a test case fails.
       "duplicates not allowed" >:: (fun _ -> 
        assert_equal ~cmp:cmp_set_like_lists ~printer:(pp_list pp_string)
          ["foo"; "foo"] ["foo"]);
    *)
  ]

(********************************************************************
   End helper functions.
 ********************************************************************)

let word_tests = [
  "Testing small test input" >:: 
  (fun _ -> assert_equal ["computer"; "science"] (word_list "small_text.txt"));

  "Testing small test 1 input" >:: 
  (fun _ -> 
     assert_equal ["this"; "is"; "a"; "weird"; "set"; "of"; "words"] 
       (word_list "small_text_1.txt"));

  "Testing small test 2 input" >:: 
  (fun _ -> 
     assert_equal ["hello world"; "cs 3110"; "nate is great"; "checking 1"; 
                   "hello from the other side"] (word_list "small_text_2.txt"))
]

let suite =
  "test suite for Boggle"  >::: List.flatten [
    word_tests;
  ]

let _ = run_test_tt_main suite
