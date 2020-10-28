sysuse auto, clear
set trace off
*set trace on
wrap "The quick brown fox jumped over the lazy dog.", local(test) at(30)
return list
macro list _test

twoway scatter price mpg, title(`test')
