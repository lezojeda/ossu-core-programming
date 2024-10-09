fun only_capitals (lst: string list) =
	List.filter (fn s => Char.isUpper(String.sub(s, 0))) lst

fun longest_string1 (lst: string list) =
	foldl (fn (s, acc) => if String.size(s) > String.size(acc) then s else acc) "" lst;

fun longest_string2 (lst: string list) =
	foldl (fn (s, acc) => if String.size(s) >= String.size(acc) then s else acc) "" lst;

fun longest_string_helper f = foldl (fn (x,y) => if f(String.size(x), String.size(y)) then x else y) ""

val longest_string3 = longest_string_helper (fn (x, y) => x > y)

val longest_string4 = longest_string_helper (fn (x, y) => x >= y)

val longest_capitalized = longest_string1 o only_capitals

val rev_string = String.implode o List.rev o String.explode

exception NoAnswer
fun first_answer pred xs =
	case xs of
	[] => raise NoAnswer
	| x::xs' => case pred x of
		SOME b => b
		| NONE =>  first_answer pred xs'

fun all_answers pred xs =
    let fun f (ys, acc) =
        case ys of
        	[] => SOME (List.rev acc)
        	| x::xs' =>
        		case pred x of
                      	SOME b => f (xs', b @ acc)
                    	| NONE => NONE
    in
        f (xs, [])
    end

(* /// *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu
 
fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

val count_wildcards = g (fn _ => 1) (fn _ => 0)

val count_wild_and_variable_lengths = g (fn () => 1) (fn (x) => String.size x)

val count_some_var  = fn (str, p) =>  g (fn () => 0) (fn (x) => if x = str then 1 else 0) p

fun get_strings p =
	case p of
	    Wildcard          => []
	  | Variable x        => [x]
	  | TupleP ps         => List.foldl (fn (p,acc) => acc @ get_strings p) [] ps
	  | ConstructorP(_,p) => get_strings p
	  | _                 => []

fun has_repeats (l, acc) =
	case l of
		[] => false
		| x::xs' => if List.exists (fn y => x = y) acc then true else has_repeats (xs', x::acc)

fun check_pat p =
	not (has_repeats (get_strings p, []))

fun match (v, p) =
	case (v, p) of
	(v, Wildcard)                 => SOME []
	| (v, Variable s)             => SOME [(s, v)] 
	| (Unit, UnitP)               => SOME []
	| (Const v, ConstP i)         => if i = v then SOME [] else NONE
	| (Tuple vs, TupleP ps)       =>
          if List.length vs = List.length ps then
              all_answers (fn (x, y) => match (x, y)) (ListPair.zip (vs, ps))
          else NONE
	| (Constructor (s1, v1), 
		ConstructorP (s2, p)) => if s1 = s2 then match (v1, p) else NONE
	| (_, _)                      => NONE

fun first_match v ps =
	SOME(first_answer (fn p => match(v, p)) ps)
	handle NoAnswer => NONE