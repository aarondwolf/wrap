*! version 2.0.1  14dec2020 Aaron Wolf, aaron.wolf@yale.edu	
cap program drop wrap
program define wrap, rclass
		
	syntax anything [if], [LOCAL(string asis) at(passthru) novallab novarlab]	
	
	* Choose whether to store varlab or labels to local
	if "`local'" == "" local lstore name
	else {
	    tokenize "`local'", parse(",")
		confirm name `1'
		cap assert inlist("`2'","",",") & inlist("`3'","","labels","relabel") & ("`4'" == "")
			if _rc {
				di as error "Option {it: local} misspecified"
				error 198
				}				
	  local local local(`1')
	  local lstore = cond("`3'"=="","name","`3'")
	}
	cap assert !inlist("`lstore'","labels","relabel") if "`vallab'" == "novallab"
	if _rc {
	    di as error "Cannot specify {it:`lstore'} if {it:novallab} specified."
		error 198
	}
	
	* If anything is a variable
	cap confirm variable `anything'
	if _rc == 0 {		
	    * Wrap Value label (if possible)
		local vallabel: value label `anything'
		if "`vallabel'" != "" & "`vallab'" == "" {
			wrap_vallab `anything' `if', `local' `at'
			return local relabel = `"`r(relabel)'"'
			return local labels = `"`r(name)'"'
			local which = cond("`lstore'"=="labels","name","relabel")
			if inlist("`lstore'","labels","relabel") c_local `r(lname)' = `"`r(`which')'"'
			return local vallab = "`vallabel'"
		}
		* Wrap Variable Label
		if "`varlab'" == "" {
			wrap_varlab `anything', `local' `at'
			return local varlab = `"`r(name)'"'
			return scalar length = `r(length)'
			return scalar pieces = `r(pieces)'
			if "`local'" != "" & "`lstore'" == "name" c_local `r(lname)' = `"`r(name)'"'	
		}
	}
	* If anything is a string
	else {
	    wrap_string `anything' `if', `local' `at' `relabel'
		return local name = `"`r(name)'"'
		return scalar length = `r(length)'
		return scalar pieces = `r(pieces)'
		if "`local'" != "" c_local `r(lname)' = `"`r(name)'"'
	}
		
end

cap program drop wrap_varlab
program define wrap_varlab

	syntax varname, [LOCAL(passthru) at(passthru)]
	local varlabel: variable label `varlist'
	wrap_string "`varlabel'", `local' `at'
	

end

cap program drop wrap_vallab
program define wrap_vallab, rclass

	syntax varname [if], [LOCAL(name) at(passthru)]
	
	qui levelsof `varlist' `if'
	local n = 0
	foreach i in `r(levels)' {
	    local label: label (`varlist') `i'
		wrap_string "`label'", `at'
		local vallabs `vallabs' `i' `"`r(name)'"'
		
		* Labels for graph bar
		local++n
		local relabel `relabel' `n' `"`r(name)'"'
	}
	
	return local name = `"`vallabs'"'
	return local relabel = `"`relabel'"'
	if "`local'" != "" return local lname `local'

end

cap program drop wrap_string
program define wrap_string, rclass

	syntax anything, [LOCAL(name) at(integer 40)]

	* Wrap Program	
	local length = length(`anything')
	local pieces = ceil(`length'/`at')

	if `length' > `at' {
		forvalues i = 1/`pieces' {
			local lab`i': piece `i' `at' of `anything', nobreak
			local name `"`name' "`lab`i''" "'
		}
	}
	else {
		local name `anything'
	}
	
	*di `"`name'"'
	return local name = `"`name'"'
	return scalar length = `length'
	return scalar pieces = `pieces'
	if "`local'" != "" return local lname `local'

end
	
	
	
	
