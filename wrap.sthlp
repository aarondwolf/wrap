{smcl}
{* *! version 2.0.1 Aaron Wolf 14dec2020}{...}
{title:Title}

{phang}
{cmd:wrap} {hline 2} Wrap text for titles and labels.

{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{opt wrap}
{{help varname} | {help anything}}
[{help if}]
{cmd:,} [{cmd: local(}{help name}, local_options{cmd:)} {opth at(integer)}]

{* Using -help odkmeta- as a template.}{...}
{* 24 is the position of the last character in the first column + 3.}{...}
{synoptset 24 tabbed}{...}
{synopthdr}
{synoptline}

{synopt:{cmd: local(}{help name}, options{cmd:)}}Store wrapped string or variable label in {help local} {it: name}. {p_end}
{synopt:{opth at(integer)}}Wrap text at every {it:Nth} character. {cmd: wrap} will split the string only after completion of a full word. The default value is 40. {p_end}
{synoptline}

{synoptset 24 tabbed}{...}
{synopthdr:local_options}
{synoptline}
{synopt:{opt label}}Store value-label pairs in local {help name} instead of variable label (when using {cmd: wrap} {help varname}). {p_end}

{synopt:{opt relabel}}Store re-numbered value-label pairs in local {help name} for use with the {it: relabel()} option in {help graph bar} (when using {cmd: wrap} {help varname}).  {p_end}
{synoptline}

{title:Description}

{pstd}
{cmd:wrap} takes a single string argument ({help anything}) or a variable name 
({help varname}) as and outputs the full text (if {help anything}), or variable label and value labels (if {help varname}) wrapped into multiple lines of text using compound double quotes. 

{pstd}
If {opth local(name)} is specified, the command will store the string in
local {it: name}.

{pstd} When {help if} is specified (only valid when using {cmd: wrap} {help varname}),
{cmd: wrap} will only wrap value labels for levels of {help varname} where {help if} holds.

{title:Examples}

{pstd}
Load NLSW data:

        {cmd:.} {cmd: sysuse nlsw88, clear}

{bf: Example 1: Wrap a Simple String}

{pstd}
We have a title that is too long, and want to wrap it after 40 characters (the default):

	{cmd:.} {cmd: wrap "The quick brown fox jumps over the lazy dog."}

{pstd}
We can now use this in a graph:

	{cmd:.} {cmd: twoway scatter wage grade, title(`r(name)')}

{pstd}
We can store the string in local {it: title}, and specify when it will wrap:

	{cmd:.} {cmd: wrap "The quick brown fox jumps over the laxy dog.", local(title) at(20)}
	{cmd:.} {cmd: twoway scatter wage grade, title(`title')}
	
{bf: Example 2: Wrap Variable Label}

{pstd}
Suppose we want the same graph using the variable label of the y-variable
as the title. We could use the {cmd: wrap} {help varname} command:

	{cmd:.} {cmd: wrap wage, at(10)}
	{cmd:.} {cmd: twoway scatter wage grade, title(`r(varlabel)')}
	
{bf: Example 3: Wrap Value Labels}

{pstd}
We may wish to wrap the text of all value labels attached to a variable. 
To do this, we could use the {cmd: wrap} {help varname} command on a variable
with attached value labels:	

	{cmd:.} {cmd: wrap collgrad, at(15)}
	{cmd:.} {cmd: return list}
	
{pstd}
This is particularly useful when using the {help graph bar} command with the 
{it: relabel()} option.   	

	{cmd:.} {cmd: wrap collgrad, at(15)}
	{cmd:.} {cmd: graph bar wage, over(collgrad, relabel(`r(relabel)'))}
	
{pstd}
We can omit subgroups in {cmd: wrap} to mirror what we specify in {help graph bar}:

	{cmd:.} {cmd: wrap industry if industry != 4, at(15)}
	{cmd:.} {cmd: graph hbar wage if industry != 4, over(industry, relabel(`r(relabel)'))}

{bf: Example 4: Specify a {help local} macro to store results}

{pstd}
In all cases, we can optionally store the results in a {help local} macro using
the {opt local()} option:

	{cmd:.} {cmd: wrap "The quick brown fox jumps over the laxy dog.", local(title) at(20)}
	{cmd:.} {cmd: wrap collgrad, local(title) at(10)}
	
{pstd}
By default, {cmd:wrap} will store the variable label for {help varname} in 
{opt local()}. If you wish to store the results in {it:r(labels)} 
(the value-label pairs), specify {opt local(name, labels)}:	

	{cmd:.} {cmd: wrap industry, local(ind_labs, labels) at(10)}
	
{pstd}
If you wish to use the results in in {it:r(relabel)} (the value-label pairs
re-numbered, starting at 1), specify {opt local(name, relabel)}:	

	{cmd:.} {cmd: wrap industry, local(ind_labs, relabel) at(10)}	

{pstd}
You can use this to create wrapped labels for use with {help graph bar}:

	{cmd:.} {cmd: wrap industry if industry != 4, local(ind_labs, relabel) at(15)}
	{cmd:.} {cmd: graph hbar wage if industry != 4, over(industry, relabel(`ind_labs'))}

{title:Stored results}

{pstd}
{cmd:wrap} stores the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{it: If specifying} {cmd: wrap} {help anything}:

{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:r(length)}}The length of the original string.{p_end}
{synopt:{cmd:r(pieces)}}The number of pieces (lines) the string was wrapped to.{p_end}

{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:r(name)}}New (wrapped) string.{p_end}

{it: If specifying} {cmd: wrap} {help varname}:
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:r(length)}}The length of the variable label.{p_end}
{synopt:{cmd:r(pieces)}}The number of pieces (lines) the variable label was wrapped to.{p_end}

{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:r(varlab)}}New (wrapped) variable label.{p_end}
{synopt:{cmd:r(vallab)}}Value label for {help varname}.{p_end}
{synopt:{cmd:r(label)}}New (wrapped) value labels.{p_end}
{synopt:{cmd:r(relabel)}}New (wrapped) value labels, re-numbered to comply with the {it: relabel()} option in {help graph bar}.{p_end}


{title:Author}

{pstd}Aaron Wolf, Yale University {p_end}
{pstd}aaron.wolf@yale.edu{p_end}

{title:Acknowledgements}

{pstd}
{cmd:wrap} was inspired by an answer on Statlist by Scott Merryman to a
similar question: https://www.stata.com/statalist/archive/2007-03/msg00778.html
