(* Homework3 Simple Test*)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

val test1 = only_capitals ["A","B","c", "d"] = ["A","B"]

val test2a = longest_string1 ["A","bc","C"] = "bc"
val test2b = longest_string1 ["aa","bb","cc"] = "aa"

val test3a = longest_string2 ["A","bc","C"] = "bc"
val test3b = longest_string2 ["aa","bb","cc"] = "cc"

val test4a = longest_string3 ["A","bc","C"] = "bc"
val test4b = longest_string4 ["A","B","C"] = "C"

val test5a = longest_capitalized ["A","bc","C"] = "A"
val test5b = longest_capitalized ["CC","CCC","DDD", "aaa"] = "CCC"
val test5c = longest_capitalized ["CC","CCC","DDD", "EEEE"] = "EEEE"


val test6a = rev_string "abc" = "cba"
val test6b = rev_string "menem" = "menem"
val test6c = rev_string "luz ojeda" = "adejo zul"

val test7a = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4
val test7b = first_answer (fn x => if x = 3 then SOME x else NONE) [1,2,3] = 3
val test7c = first_answer (fn x => if x > 7 then SOME x else NONE) [1,2,3,16] = 16

val test8a = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE
val test8b = all_answers (fn x => if x = 1 then SOME [x] else NONE) [1] = SOME [1]
val test8b = all_answers (fn x => if x > 1 then SOME [x] else NONE) [2,3,4,5] = SOME [5,4,3,2]

val test9a = count_wildcards Wildcard = 1

val test9b = count_wild_and_variable_lengths (Variable("a")) = 1

val test9c = count_wild_and_variable_lengths (Variable("abc")) = 3

val test9d = count_wild_and_variable_lengths Wildcard = 1

val test9e = count_some_var ("x", Variable("x")) = 1

val test9f = count_some_var ("y", Variable("x")) = 0

val test10a = check_pat (Variable("x")) = true

val test10b = check_pat (TupleP [Variable "x", Variable "x"]) = false

val test11 = match (Const(1), UnitP) = NONE

val pat1 = Wildcard
val pat2 = Variable "pat2"
val pat3 = UnitP
val pat4 = ConstP 17
val pat5 = TupleP [pat1, pat2, pat3, pat4]
val val5 = Tuple [Const(1), Const(2), Unit, Const(17)]

val test11a = match (Const(1), UnitP) = NONE
val test11b = match (Const(17), ConstP 17) = SOME []
val test11b2 = match (Const(16), ConstP 17) = NONE
val test11c = match (Const(1), Wildcard) = SOME []
val test11d = match (Unit, Wildcard) = SOME []
val test11e = match (Unit, pat3) = SOME []
val test11f = match (Const(1), pat2) = SOME [("pat2", Const(1))]
val test11g = match (Const(1), pat5) = NONE
val test11h = match (Tuple[Const(1)], pat5) = NONE
val test11i = match (val5, pat5) = SOME [("pat2", Const(2))]
val test11j = match (Tuple[Const 17, Unit, Const 4, Constructor ("egg", Const 4),
    Constructor("egg", Constructor ("egg", Const 4))], TupleP[Wildcard, Wildcard])
    = NONE

val test12 = first_match Unit [UnitP] = SOME []