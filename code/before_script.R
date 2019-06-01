library(methods)

knitr::opts_chunk$set(
  background = "#FCFCFC",
  comment = "#>",
  collapse = TRUE,
  cache = TRUE,
  fig.pos = "H",
  fig.path = "figures/",
  fig.align = "center",
  fig.width = 6,
  # fig.asp = 0.618,  # 1 / pi (golden ratio)
  fig.asp = 0.7072136,  # 1 / 1.414 (silver ratio)
  fig.show = "hold",
  out.width = "\\textwidth"
)

if(!knitr:::is_html_output()){
  options("width" = 56)
  knitr::opts_chunk$set(tidy.opts = list(width.cutoff = 56, indent = 2),
                        tidy = TRUE)
}

set.seed(2018-12-22)
options(digits = 3, knitr.graphics.auto_pdf = TRUE, tinytex.verbose = TRUE)
