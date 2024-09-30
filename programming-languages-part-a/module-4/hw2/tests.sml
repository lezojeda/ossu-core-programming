(* Homework2 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

val test1 = all_except_option ("string", ["string"]) = SOME []

val test2 = get_substitutions1 ([["foo"],["there"]], "foo") = []
val test21 = get_substitutions1 ([["foo"],["there"]], "foo") = []
val test22 = get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") = ["Fredrick","Freddie","F"];

val test3 = get_substitutions2 ([["foo"],["there"]], "foo") = []
val test32 = get_substitutions2([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") = ["Fredrick","Freddie","F"];
val test33 = get_substitutions2([["a", "b"], ["c", "d"]], "c") = ["d"];
val test34 = get_substitutions2([], "c") = [];

val test4 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
	     {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]

(* Test case 42: Basic substitution with original name *)
val test42 = similar_names (
    [["Fred", "Fredrick"], ["Elizabeth", "Betty"], ["Freddie", "Fred", "F"]],
    {first="Fred", middle="W", last="Smith"}
) = [
    {first="Fred", middle="W", last="Smith"},
    {first="Fredrick", middle="W", last="Smith"},
    {first="Freddie", middle="W", last="Smith"},
    {first="F", middle="W", last="Smith"}
];

(* Test case 43: No substitutions available *)
val test43 = similar_names (
    [[]],  (* No substitutions *)
    {first="Alice", middle="B", last="Johnson"}
) = [
    {first="Alice", middle="B", last="Johnson"}
];

(* Test case 44: Multiple names in the same substitution group *)
val test44 = similar_names (
    [["John", "Johnny", "Jon"], ["Alice", "Ally"]],
    {first="John", middle="K", last="Doe"}
) = [
    {first="John", middle="K", last="Doe"},
    {first="Johnny", middle="K", last="Doe"},
    {first="Jon", middle="K", last="Doe"},
    {first="Alice", middle="K", last="Doe"},
    {first="Ally", middle="K", last="Doe"}
];

(* Test case 45: Substitutions with the same name *)
val test45 = similar_names (
    [["Chris", "Chris"], ["Bob"]],
    {first="Chris", middle="C", last="Brown"}
) = [
    {first="Chris", middle="C", last="Brown"},
    {first="Chris", middle="C", last="Brown"}
];

(* Test case 46: Single substitution for a first name *)
val test46 = similar_names (
    [["Sam"]],
    {first="Sam", middle="D", last="Smith"}
) = [
    {first="Sam", middle="D", last="Smith"},
    {first="Sam", middle="D", last="Smith"}
];


val test5 = card_color (Clubs, Num 2) = Black

val test6 = card_value (Clubs, Num 2) = 2

val test7 = remove_card ([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []

val test8 = all_same_color [(Hearts, Ace), (Hearts, Ace)] = true

val test9 = sum_cards [(Clubs, Num 2),(Clubs, Num 2)] = 4

val test10 = score ([(Hearts, Num 2),(Clubs, Num 4)],10) = 4
val test10b = score ([(Clubs, Num 4), (Clubs, Num 5)],10) = 0 (* 5+4 < 10 then we divide by 2 since same color  *)
val test10c = score ([(Clubs, Num 4), (Clubs, Num 9)],10) = 4 (* 4+9 > 10 then preliminary 3 * 3 and divide by 2 since same color  *)
val test10e = score ([(Clubs, Num 4), (Hearts, Num 9)],10) = 9 (* 4+9 > 10 then preliminary 3 * 3 and not divide by 2 since different color  *)
val test10f = score ([(Clubs, Num 4), (Hearts, Num 4)],10) = 2 (* 4+4 < 10 then preliminary 2 and not divide by 2 since different color  *)

val test11 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6

val test12 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                        [Draw,Draw,Draw,Draw,Draw],
                        42)
             = 3

val test13 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false) 
              handle IllegalMove => true)
             
             

