{smcl}
{* *! version 1.0.1 Aaron Wolf 27oct2020}{...}
{title:Title}

{phang}
{cmd:wrap} {hline 2} A simple Stata program to wrap text for titles and labels.

{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{opt wrap}
{help anything}
{cmd:,} [{opth local(name)} {opth at(integer)}]

{* Using -help odkmeta- as a template.}{...}
{* 24 is the position of the last character in the first column + 3.}{...}
{synoptset 24 tabbed}{...}
{synopthdr}
{synoptline}

{synopt:{opth local(name)}}Store wrapped string to {help local} {it: name}. {p_end}
{synopt:{opth at(integer)}}Wrap text at every {it:Nth} character. {cmd: wrap} will split the string only after completion of a full word. The default value is 40. {p_end}


{synoptline}

{title:Description}

{pstd}
{cmd:wrap} takes a single argument, {help anything}, as a string input and
outputs a new local with the full text wrapped into multiple lines of text
using compound double quotes.

{pstd}
If {opth local(name)} is specified, the command will store the string in
local {it: name}. 

title:Examples}

{pstd}
Load auto data:

        {cmd:.} {cmd: sysuse auto, clear}
		
{pstd}
We have a title that is too long, and want to wrap it after 40 characters:

	{cmd:.} {cmd: wrap "The quick brown fox jumps over the laxy dog."}
		
{pstd}
We can now use this in a graph:
	
	{cmd:.} {cmd: twoway scatter price mpg, title(`r(name)')}
	
We can store the string in local {it: title}, and specify when it will wrap:
	
	{cmd:.} {cmd: wrap "The quick brown fox jumps over the laxy dog.", local(title) at(20)}
	{cmd:.} {cmd: twoway scatter price mpg, title(`title')}
	
{title:Stored results}

{pstd}
{cmd:wrap} stores the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:r(length)}}The length of the original string.{p_end}
{synopt:{cmd:r(pieces)}}The number of pieces (lines) the string was wrapped to.{p_end}

{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:r(name)}}New (wrapped) string.{p_end}

{title:Author}

{pstd}Aaron Wolf, Yale University {p_end}
{pstd}aaron.wolf@yale.edu{p_end}

{title:Acknowledgements}

{pstd}
{cmd:wrap} was inspired by an answer on Statlist by Scott Merryman to a 
similar question: https://www.stata.com/statalist/archive/2007-03/msg00778.html













