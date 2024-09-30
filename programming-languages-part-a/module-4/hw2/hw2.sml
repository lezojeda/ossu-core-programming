(* Dan Grossman, Coursera PL, HW2 Provided Code *)


(* PROBLEM 1 *)
(* a) *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)
fun all_except_option (str: string, lst: string list) =
   	case lst of
   	[] => NONE
	| i::lst' => if same_string(i, str)
                	then SOME(lst')
                	else case all_except_option(str, lst') of
				NONE => NONE
				| SOME lst'' => SOME (i::lst'')

(* 
all_except_option("a", ["b", "a", "c"])

SOME (case all_except_option("a", ["a", "c"]) of ...)   // i is "b", lst' is ["a", "c"] so in case the recursive call results in SOME, we will return i::lst'

SOME (case (SOME (if same_string("a", "a") then ["c"] else ...)) of ...)  // i is "a" now, lst' ["c"], since strings match we return ["c"]

SOME (case SOME(["c"]) of ...)  // remember that i was "b", so SOME lst' => i::lst' equals "b"::["c"]
SOME ("b" :: ["c"])
SOME card_list["b", "c"]
 *)


(* b) *)

fun get_substitutions1 (substitutions: string list list, s: string) =
	case substitutions of
   	[] => []
	| first_list::lst' => case all_except_option(s, first_list) of
			NONE => get_substitutions1(lst', s)
			| SOME result => result @ get_substitutions1(lst', s)


(* c) *)
fun get_substitutions2 (substitutions: string list list, s: string) =
	let
	  fun f (substitutions: string list list, acc: string list) =
	  	case substitutions of
		[] => acc
		| i::substitutions' => case all_except_option(s, i) of
					NONE => f (substitutions', acc)
					| SOME result => f (substitutions', acc @ result)
	in
	  f (substitutions, [])
	end


(* d) *)
fun similar_names (substitutions: string list list, full_name: {first:string,middle:string,last:string}) =
	let 
		val {first=x,middle=y,last=z} = full_name
		fun f (substitution_results: string list) =
			case substitution_results of
			[] => []
			| s::substitution_results' => {first=s,middle=y,last=z}::f(substitution_results')
	in
		full_name::f (get_substitutions2(substitutions, x))
	end


(* PROBLEM 2 *)
(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 
exception IllegalMove


(* a) *)
fun card_color (c: card) =
	let val (s, v) = c
	in
	  case s of
	  	Spades => Black
		| Clubs => Black
		| Diamonds => Red
		| Hearts => Red
	end


(* b) *)
fun card_value (c: card) =
	let val (s, v) = c
	in
	  case v of
	  	Jack => 10
		| Queen => 10
		| King => 10
		| Ace => 11
		| Num(i) => i
	end


(* c) *)
fun remove_card (ls: card list, c: card, e) =
	case ls of
	[] => raise e
	| crd::ls' => if crd = c
                	then ls'
                	else crd::remove_card(ls', c, e)


(* d) *)
fun all_same_color (ls: card list) =
	case ls of
		[] => true
		| x::xs' => case xs' of
				[] => true
				| y::ys' => card_color(x) = card_color(y) andalso all_same_color(xs')


(* e) *)
fun sum_cards (ls: card list) = 
	let
	  fun f (ls: card list, acc: int) =
		case ls of
			[] => acc
			| x::xs' => f (xs', acc + card_value(x))
	in
	  f (ls, 0)
	end


(* f) *)
fun score (ls: card list, goal: int) =
	let 
		val sum = sum_cards (ls)
		val preliminary = if sum > goal then 3 * (sum - goal) else goal - sum
	in
	  	if all_same_color (ls) then preliminary div 2 else preliminary
	end


(* g) *)
fun officiate (card_list: card list, move_list: move list, goal: int) = 
	let
	  fun play (current_card_list: card list, move_list: move list, held_cards: card list) =
	  	case move_list of
	  		[] => score (held_cards, goal)
			| x::xs' => case x of
					Discard(c) => play(current_card_list, xs', remove_card(held_cards, c, IllegalMove))
					| Draw => case current_card_list of
							[] => score(held_cards, goal)
							| y::ys' => if sum_cards (y::held_cards) > goal
								then score (y::held_cards, goal)
								else play (ys', xs', y::held_cards)
	in
		play (card_list, move_list, [])
	end
