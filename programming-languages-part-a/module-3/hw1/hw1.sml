(* (int * int * int) * (int * int * int) -> bool *)
fun is_older (d1: int * int * int, d2: int * int * int) =
	if (#1 d1) = (#1 d2)
	then
		if (#2 d1) = (#2 d2)
		then (#3 d1 < #3 d2)
		else (#2 d1) < (#2 d2) 
	else (#1 d1) < (#1 d2)

(* (int * int * int) list * int -> int *)
fun number_in_month (dates: (int * int * int) list, month: int) =
	if null dates
	then 0
	else 
		if (#2 (hd dates)) = month
		then 1 + number_in_month(tl dates, month)
		else number_in_month(tl dates, month)

(* (int * int * int) list * int list -> int *)
fun number_in_months (dates: (int * int * int) list, months: int list) =
    if null months
    then 0
    else
        number_in_month(dates, hd months) + number_in_months(dates, tl months)

(* (int * int * int) list * int list -> (int * int * int) list *)
fun dates_in_month (dates: (int * int * int) list, month: int) =
	if null dates
	then []
	else
		if (#2 (hd dates)) = month
		then (hd dates) :: dates_in_month(tl dates, month)
		else dates_in_month(tl dates, month)
		
(* (int * int * int) list * int list -> (int * int * int) list *)
fun dates_in_months (dates: (int * int * int) list, months: int list) =
	if null months
	then []
	else
		dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

(* string list * int -> string *)
fun get_nth(lst: string list, n: int) =
	if n = 1
	then (hd lst)
	else
		get_nth(tl lst, n - 1)

val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
(* (int * int * int) list -> string *)
fun date_to_string(date: (int * int * int)) = 
	get_nth(months, (#2 date)) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)

(* int * int list -> int *)
fun number_before_reaching_sum (sum: int, lst: int list) =
	let fun number_before_reaching_sum_helper(sum: int, total: int, nums: int list, n: int) =
		if (sum > total + (hd nums))
		then number_before_reaching_sum_helper(sum, total + (hd nums), tl nums, n + 1)
		else n
	in
		number_before_reaching_sum_helper(sum, 0, lst, 1)
	end

val months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
(* int -> int *)
fun what_month (num_day: int) =
	number_before_reaching_sum(num_day, months)

(* int * int -> int list *)
fun month_range (day1: int, day2: int) =
	if day1 > day2
	then []
	else
		what_month(day1) :: month_range(day1 + 1, day2)

(* (int * int * int) list -> (int * int * int) option) *)

fun oldest (dates: (int * int * int) list) =
	if null dates
	then NONE
	else let
		fun oldest_nonempty(dates: (int * int * int) list) =
			if null (tl dates)
			then hd dates
			else let val tl_ans = oldest_nonempty(tl dates)
				in
					if is_older((hd dates, tl_ans))
					then hd dates
					else tl_ans
				end
		in
			SOME (oldest_nonempty dates)
		end

(* oldest([(2023,01,01), (2025,01,01)]); *)