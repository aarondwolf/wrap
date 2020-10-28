# wrap
A simple Stata program to wrap text for titles and labels.

## Installing via *net install*

To install, user can use the net install command to download from the project's Github page:

```
net install wrap, from("https://aarondwolf.github.io/wrap")
```

## Syntax

```
wrap anything , [local(name) at(integer)]
```

Options
-----------------------------------------------------------------------------------------------

- **local(name)** Store wrapped string to local name.

- **at(integer)** Wrap text at every Nth character.  wrap will split the string only after completion of a full word. The default value is 40.

## Description

**wrap** takes a single argument, anything, as a string input and outputs a new local with the full text wrapped into multiple lines of text using compound double quotes.

If **local(name)** is specified, the command will store the string in local name.

## Examples

Load auto data:

```
    .  sysuse auto, clear
```


We have a title that is too long, and want to wrap it after 40 characters (the default):

```
    .  wrap "The quick brown fox jumps over the laxy dog."
```


 We can now use this in a graph:

```
  .  twoway scatter price mpg, title(`r(name)')
```

We can store the string in local  title, and specify when it will wrap:
        .  wrap "The quick brown fox jumps over the laxy dog.", local(title) at(20)
        .  twoway scatter price mpg, title(`title')

## Stored results

wrap stores the following in r():

### Scalars       

- **r(length)**           The length of the original string
- **r(pieces)**           The number of pieces (lines) the string was wrapped to.

### Macros         

- **r(name)**             New (wrapped) string.

## Author

Aaron Wolf, Yale University
aaron.wolf@yale.edu

## Acknowledgements

wrap was inspired by an answer on Statlist by Scott Merryman to a similar question: https://www.stata.com/statalist/archive/2007-03/msg00778.html