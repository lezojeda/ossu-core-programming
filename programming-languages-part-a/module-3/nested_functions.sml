fun countup_from1(x : int) =
	let
	  fun count (from : int) =
		if from=x (* using a binding, x, from countup_from1 environment, an outer one *)
		then x::[]
		else from :: count(from+1)
	in
		count(1)
	end