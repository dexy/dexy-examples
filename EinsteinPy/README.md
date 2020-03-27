LaTeX template from https://www.sharelatex.com/templates/journals/aps

EinsteinPy source code from EinsteinPy project documentation

## Source Listings

Source code is highlighted using the Pygments package. The pygmentize command
line tool can be used to generate stylesheets for LaTeX or HTML. See pastie.sh
for example. The `fancyvrb` package must be included for the `Verbatim`
environment. The `xcolor` package must be included for `\textcolor` commands.


## Jinja for LaTeX

By default, Jinja uses double curly braces {{ }} to create a substitution.
When writing LaTeX documents, Dexy automatically changes the delimiter to << and >> 
