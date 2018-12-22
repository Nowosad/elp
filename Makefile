html:
	Rscript -e 'bookdown::render_book("index.Rmd", output_format = "bookdown::gitbook")'

pdf:
	Rscript -e 'bookdown::render_book("index.Rmd", output_format = "bookdown::pdf_book")'

all:
	Rscript -e 'bookdown::render_book("index.Rmd", output_format = "bookdown::pdf_book")'
	Rscript -e 'bookdown::render_book("index.Rmd", output_format = "bookdown::epub_book")'
	Rscript -e 'bookdown::render_book("index.Rmd", output_format = "bookdown::gitbook", clean = FALSE)'
