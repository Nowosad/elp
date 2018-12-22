This is a minimal example of a book based on R Markdown and **bookdown** (https://github.com/rstudio/bookdown).
More detailed instructions are available here https://bookdown.org/yihui/bookdown/build-the-book.html.

This repo contains a few important parts:
1. `index.Rmd` - sets a book title, authors, references files
2. `_output.yml` - configures output formats
3. `_bookdown.yml` - sets bookdown options, e.g. should each chapter be build independetly
4. `before_script.R` - sets, for example, knitr options + a file name
5. `01_` to `06_` - book chapters
6. `book.bib` - references
7. `style/` - contains styles for both latex (e.g. `preamble.tex`) and html (e.g. `style.css`)

8. `Makefile` - allows for easy creation of html, pdf, or epub
9. `.travis` - sets Travis-CI to automaticaly build the book and upload it to the github pages. 
It requires putting the `GH_TOKEN` environment variable
10. `ga.html` - a placeholder for a google analitics script
