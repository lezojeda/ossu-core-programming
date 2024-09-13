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

(* number_in_months([(2023,01,03), (2023,01, 03), (2023,04,03), (2023,02,03)], [02, 03]); *)