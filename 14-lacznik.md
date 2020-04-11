# Łącznik {#lacznik}

<!-- intro o r jako jezyku laczacym inne -->
<!-- intro o innych łącznikach -->
<!-- rust, java, javascript, ?? -->

## C++

<!-- Rcpp -->
<!-- intro to Cpp -->
<!-- https://cran.r-project.org/web/packages/Rcpp/vignettes/Rcpp-introduction.pdf -->
<!-- data type -->
<!-- scalars -->
<!-- semicolons -->
<!-- loops -->
<!-- many more -->
[@R-Rcpp]


```r
library(Rcpp)
```

### evalCpp


```r
evalCpp('')
```

### cppFunction


```r
mi_do_km2 = function(odl_mile){
  odl_km = vector("list", length = length(odl_mile))
  for (i in seq_along(odl_mile)) {
    odl_km[[i]] = odl_mile[[i]] * 1.609
  }
  odl_km
}
```


```r
rcpp_fun = "List mi_do_km3(List odl_mile){
  int odl_mile_len = odl_mile.size();
  List result(odl_mile_len);
  for (int i = 0; i < odl_mile_len; i++){
    result[i] = odl_mile[i] * 1.609;
  }
  return(result);
}"
Rcpp::cppFunction(rcpp_fun)
```


```r
odl_mile = list(142, 63, 121)
mi_do_km3(odl_mile)
#> [[1]]
#> [1] 228
#> 
#> [[2]]
#> [1] 101
#> 
#> [[3]]
#> [1] 195
```


```r
odl_mile2 = as.list(0:10000)
wynik = bench::mark(
  mi_do_km2(odl_mile2),
  mi_do_km3(odl_mile2)
)
wynik
#> # A tibble: 2 x 6
#>   expression             min median `itr/sec` mem_alloc
#>   <bch:expr>           <bch> <bch:>     <dbl> <bch:byt>
#> 1 mi_do_km2(odl_mile2) 775µs  810µs     1205.   599.2KB
#> 2 mi_do_km3(odl_mile2) 412µs  452µs     2206.    85.9KB
#> # … with 1 more variable: `gc/sec` <dbl>
```

### .cpp

<!-- ref to \@ref(tworzenie-pakietow) -->

<!-- header file -->


```cpp
#include <Rcpp.h>
```


```cpp
using namespace Rcpp;
```


```cpp
// [[Rcpp::export]]
```

<!-- internal vs exported functions -->


```cpp
#include <Rcpp.h>
using namespace Rcpp;
// [[Rcpp::export]]
List mi_do_km3(List odl_mile){
  int odl_mile_len = odl_mile.size();
  List result(odl_mile_len);
  for (int i = 0; i < odl_mile_len; i++){
    result[i] = odl_mile[i] * 1.609;
  }
  return(result);
}
```


```r
library(Rcpp)
sourceCpp("mi_do_km3.cpp")

odl_mile = list(142, 63, 121)
mi_do_km3(odl_mile)
#> [[1]]
#> [1] 228
#> 
#> [[2]]
#> [1] 101
#> 
#> [[3]]
#> [1] 195
```

<!-- note - packages -->
<!-- indexing starts at 0 -->

<!-- https://adv-r.hadley.nz/rcpp.html -->
<!-- https://csgillespie.github.io/efficientR/performance.html#rcpp -->
<!-- http://thecoatlessprofessor.com/programming/unofficial-rcpp-api-documentation/#minmax -->

## Python
<!-- reticulate -->

[@R-reticulate]


```r
library(reticulate)
```

<!-- setting Python version -->
<!-- four types of connections with Python -->

<!-- Type Conversions -->
<!-- Importing Modules -->
<!-- Getting Help -->

https://rstudio.github.io/reticulate/

## Unix commands


<!-- https://stackoverflow.com/questions/48605776/difference-between-system-and-system2-in-r-capture-file-names-in-variable -->
<!-- https://stackoverflow.com/questions/5745886/r-and-system-calls -->
<!-- https://tomaztsql.wordpress.com/2020/01/06/working-with-system-commands-in-r/ -->
<!-- https://joongsup.rbind.io/post/2018/02/05/run-system-commands-or-shell-sripts-from-an-interactive-r-session/ -->

<!-- grep -->
<!-- cat -->
<!-- find -->
<!-- head/tail -->
<!-- awk -->
<!-- man -->

<!-- https://github.com/microsoft/terminal -->
<!-- http://www.makoweabc.pl/2009/12/os-x-terminal-jak-go-uruchomic-krok-po-kroku/ -->
<!-- https://ubuntu.com/tutorials/command-line-for-beginners#1-overview -->
<!-- https://neowaylabs.github.io/programming/unix-shell-for-data-scientists/?utm_source=hackernewsletter&utm_medium=email&utm_term=data -->
<!-- https://missing.csail.mit.edu/ -->

## Zadania
