# wrap
Wrap text for titles and labels.

## Installing via *net install*

To install, user can use the net install command to download from the project's Github page:

```
net install wrap, from("https://aarondwolf.github.io/wrap")
```

## Syntax

```
wrap {varname | anything} [if] , [ local(name, local_options) at(integer)]
```

Options
-----------------------------------------------------------------------------------------------

- **local(name, options)** Store wrapped string or variable label in local name
- **at(integer)** Wrap text at every Nth character.  wrap will split the string only after completion of a full word. The default value is 40.

### Local Options

- **label** Store wrapped string or variable label in local *name*
- **relabel** Wrap text at every Nth character.  wrap will split the string only after completion of a full word. The default value is 40.

## Description

**wrap** takes a single string argument (*anything*) or a variable name (*varname*) as and outputs the full text (if *anything*), or variable label and value labels (if *varname*) wrapped into multiple lines of text using compound double quotes.

If **local**(*name*) is specified, the command will store the string in local name.

When *if* is specified (only valid when using **wrap** *varname*), wrap will only wrap value labels for levels of *varname* where *if* holds.

## Examples

Load NLSW data:

```
    .  sysuse nlsw88, clear
```

###  Example 1: Wrap a Simple String

We have a title that is too long, and want to wrap it after 40 characters (the default):

```
    .  wrap "The quick brown fox jumps over the lazy dog."
```

We can now use this in a graph:

```
    .  twoway scatter wage grade, title(`r(name)')
```

We can store the string in local title, and specify when it will wrap:

```
    .  wrap "The quick brown fox jumps over the laxy dog.", local(title) at(20)
    .  twoway scatter wage grade, title(`title')
```

###  Example 2: Wrap Variable Label

Suppose we want the same graph using the variable label of the y-variable as the title. We
could use the wrap varname command:

```
    .  wrap wage, at(10)
    .  twoway scatter wage grade, title(`r(varlabel)')
```

###  Example 3: Wrap Value Labels

We may wish to wrap the text of all value labels attached to a variable.  To do this, we could
use the wrap varname command on a variable with attached value labels:

```
    .  wrap collgrad, at(15)
    .  return list
```


​    This is particularly useful when using the graph bar command with the relabel() option.

```
    .  wrap collgrad, at(15)
    .  graph bar wage, over(collgrad, relabel(`r(relabel)'))
```

We can omit subgroups in wrap to mirror what we specify in graph bar:

```
    .  wrap industry if industry != 4, at(15)
    .  graph hbar wage if industry != 4, over(industry, relabel(`r(relabel)'))
```

###  Example 4: Specify a local macro to store results

In all cases, we can optionally store the results in a local macro using the local() option:

```
    .  wrap "The quick brown fox jumps over the laxy dog.", local(title) at(20)
    .  wrap collgrad, local(title) at(10)
```

By default, wrap will store the variable label for varname in local(). If you wish to store the
results in r(labels) (the value-label pairs), specify local(name, labels):

```
    .  wrap industry, local(ind_labs, labels) at(10)
```

If you wish to use the results in in r(relabel) (the value-label pairs re-numbered, starting at
1), specify local(name, relabel):

```
    .  wrap industry, local(ind_labs, relabel) at(10)    
```

You can use this to create wrapped labels for use with graph bar:

```
    .  wrap industry if industry != 4, local(ind_labs, relabel) at(15)
    .  graph hbar wage if industry != 4, over(industry, relabel(`ind_labs'))
```

## Stored results

**wrap** stores the following in r():

###  If specifying  wrap anything:

Scalars        

- r(length): The length of the original string.
- r(pieces): The number of pieces (lines) the string was wrapped to.

Macros        

- r(name): New (wrapped) string.

###  If specifying  wrap varname:

Scalars        

- r(length) : The length of the variable label.
- r(pieces): The number of pieces (lines) the variable label was wrapped to.

Macros         

- r(varlab): New (wrapped) variable label.
- r(vallab): Value label for varname.
- r(label): New (wrapped) value labels.
- r(relabel): New (wrapped) value labels, re-numbered to comply with the relabel() option in graph bar.

## Author

Aaron Wolf, Northwestern University
aaron.wolf@u.northwestern.edu

## Acknowledgements

wrap was inspired by an answer on Statlist by Scott Merryman to a similar question: https://www.stata.com/statalist/archive/2007-03/msg00778.html
