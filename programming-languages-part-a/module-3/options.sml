(* fn: int list -> int option *)
fun max1 (xs : int list) =
	if null xs
	then NONE
	else
		let val tl_ans = max1(tl xs)
		in if isSome tl_ans andalso valOf tl_ans > hd xs
			then tl_ans
			else SOME (hd xs) (* build and option from the head of the list*)
		end

(* even better *)		
fun max2 (xs : int list) =
	if null xs
	then NONE
	else let (* fine to assume argument nonempty because it is local *)
		fun max_nonempty (xs : int list) =
			if null (tl xs) (* xs better not be [] *)
			then hd xs
			else let val tl_ans = max_nonempty(tl xs)
				in
					if hd xs > tl_ans
					then hd xs
					else tl_ans
				end
		in
			SOME (max_nonempty xs)
		end