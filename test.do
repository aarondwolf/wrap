sysuse nlsw88, clear
set trace off

cap program drop wrap
qui do wrap.ado

* Example 1: Any String
wrap "The quick brown fox jumped over the lazy dog.", local(test) at(30)
return list
macro list _test

* Example 2: Wrap Variable Label
wrap age, local(test) at(15)
return list
macro list _test

* Example 3: Wrap Variable and Value Labels
wrap collgrad, local(test) at(15)
return list
macro list _test

wrap collgrad, local(test) at(15) novallab
return list
macro list _test

* Example 4: Wrap Variable and Value Labels; Store Value Labels to Local test
wrap collgrad, local(test, labels) at(15)
return list
macro list _test

wrap collgrad, local(test, relabel) at(15) novarlab
return list
macro list _test

* Example 5: Wrap Value Labels, omitting group(s)
wrap industry if industry != 4, local(test, relabel) at(15)
return list
macro list _test
graph hbar wage if industry != 4, over(industry, relabel(`test'))
