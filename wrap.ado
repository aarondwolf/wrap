*! version 1.0.1  27oct2020 Aaron Wolf, aaron.wolf@yale.edu	
cap program drop wrap
program define wrap, rclass
		
	syntax anything, [LOCAL(name) at(integer 40)]
		
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
	
	di `"`name'"'
	return local name = `"`name'"'
	return scalar length = `length'
	return scalar pieces = `pieces'
	
	
	if "`local'" != "" c_local `local' = `"`name'"'
		
end
	
	
	
	
