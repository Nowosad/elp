
# Analiza kodu {#analiza-kodu}

## Benchmarking

<!-- system.time -->


```r
system.time(mean(1:100000000))
#>    user  system elapsed 
#>   0.572   0.000   0.572
```


```r
mi_do_km1 = function(odl_mile){
  odl_km = vector("list", length = 0)
  for (i in seq_along(odl_mile)) {
    odl_km = c(odl_km, odl_mile[[i]] * 1.609)
  }
  odl_km
}
```


```r
mi_do_km2 = function(odl_mile){
  odl_km = vector("list", length = length(odl_mile))
  for (i in seq_along(odl_mile)) {
    odl_km[[i]] = odl_mile[[i]] * 1.609
  }
  odl_km
}
```

[@R-bench]


```r
library(bench)
odl_mile = list(142, 63, 121)
mark(mi_do_km1(odl_mile),
     mi_do_km2(odl_mile))
#> # A tibble: 2 x 10
#>   expression      min   mean median    max `itr/sec` mem_alloc  n_gc n_itr
#>   <chr>      <bch:tm> <bch:> <bch:> <bch:>     <dbl> <bch:byt> <dbl> <int>
#> 1 mi_do_km1…   1.43µs 1.91µs 1.64µs   99µs   523387.     300KB     1  9999
#> 2 mi_do_km2… 975.91ns 1.33µs 1.12µs 27.5µs   753920.     222KB     0 10000
#> # … with 1 more variable: total_time <bch:tm>
```


```r
odl_mile2 = as.list(0:10000)
mark(mi_do_km1(odl_mile2),
     mi_do_km2(odl_mile2))
#> Warning: Some expressions had a GC in every iteration; so filtering is
#> disabled.
#> # A tibble: 2 x 10
#>   expression   min    mean median     max `itr/sec` mem_alloc  n_gc n_itr
#>   <chr>      <bch> <bch:t> <bch:> <bch:t>     <dbl> <bch:byt> <dbl> <int>
#> 1 mi_do_km1… 491ms 499.1ms  499ms 506.9ms      2.00     382MB    16     2
#> 2 mi_do_km2… 869µs   1.2ms  917µs  13.9ms    835.      78.2KB    15   418
#> # … with 1 more variable: total_time <bch:tm>
```


```r
porownanie = press(x = c(10, 100, 1000, 10000),
                   {
                   l = as.list(0:x)
                   mark(mi_do_km1(l),
                   mi_do_km2(l))
                   })
#> Running with:
#>       x
#> 1    10
#> 2   100
#> 3  1000
#> 4 10000
#> Warning: Some expressions had a GC in every iteration; so filtering is
#> disabled.
porownanie
#> # A tibble: 8 x 11
#>   expression     x      min     mean   median      max `itr/sec` mem_alloc
#>   <chr>      <dbl> <bch:tm> <bch:tm> <bch:tm> <bch:tm>     <dbl> <bch:byt>
#> 1 mi_do_km1…    10    3.9µs   5.44µs   4.81µs  105.1µs 183975.          0B
#> 2 mi_do_km2…    10   1.73µs   2.28µs   1.99µs  97.84µs 438713.          0B
#> 3 mi_do_km1…   100  67.41µs  79.77µs  74.22µs   4.19ms  12537.     43.16KB
#> 4 mi_do_km2…   100   9.14µs  11.07µs  10.01µs 209.05µs  90361.        856B
#> 5 mi_do_km1…  1000   4.44ms   4.69ms   4.69ms   5.31ms    213.      3.87MB
#> 6 mi_do_km2…  1000  84.77µs  96.64µs  91.21µs 406.87µs  10348.      7.87KB
#> 7 mi_do_km1… 10000 503.74ms 503.74ms 503.74ms 503.74ms      1.99  382.04MB
#> 8 mi_do_km2… 10000 879.62µs   1.16ms 929.36µs    9.9ms    860.     78.18KB
#> # … with 3 more variables: n_gc <dbl>, n_itr <int>, total_time <bch:tm>
```


```r
ggplot2::autoplot(porownanie)
```


## Profiling

Istnieją trzy podstawowe reguły optymalizacji kodu^[http://www.moscowcoffeereview.com/programming/the-3-rules-of-optimization/]:

1. Nie.
2. Jeszcze nie.
3. Profiluj przed optymalizowaniem.

Czym jest profilowanie i dlaczego powinno być wykonywane przed optymalizowaniem kodu?
Profilowanie mierzy czas działania każdej linii kodu.

[@R-profvis]


```r
# plik R/moja_funkcja.R
```


```r
library(profvis)
profvis(source("R/moja_funkcja.R"))
```


<!-- profiling -->
<!-- https://r-prof.github.io/jointprof/articles/proposal.html -->

<!--  Wektoryzacja kodu -->
<!-- vectorized vs not-vectorized -->
<!-- https://rstudio-education.github.io/hopr/speed.html -->

## Zadanie
