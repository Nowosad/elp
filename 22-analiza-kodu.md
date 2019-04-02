
# Analiza kodu {#analiza-kodu}

## Benchmarking

<!-- system.time -->


```r
system.time(mean(1:100000000))
#>    user  system elapsed 
#>   0.564   0.000   0.566
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
#>   expression    min   mean median    max `itr/sec` mem_alloc  n_gc n_itr
#>   <chr>      <bch:> <bch:> <bch:> <bch:>     <dbl> <bch:byt> <dbl> <int>
#> 1 mi_do_km1… 1.45µs 1.92µs 1.66µs 46.4µs   521186.     300KB     1  9999
#> 2 mi_do_km2… 1.04µs 1.32µs 1.18µs 20.4µs   759734.     222KB     0 10000
#> # … with 1 more variable: total_time <bch:tm>
```


```r
odl_mile2 = as.list(0:10000)
mark(mi_do_km1(odl_mile2),
     mi_do_km2(odl_mile2))
#> Warning: Some expressions had a GC in every iteration; so filtering is
#> disabled.
#> # A tibble: 2 x 10
#>   expression   min     mean median     max `itr/sec` mem_alloc  n_gc n_itr
#>   <chr>      <bch> <bch:tm> <bch:> <bch:t>     <dbl> <bch:byt> <dbl> <int>
#> 1 mi_do_km1… 479ms 491.96ms  492ms 504.9ms      2.03     382MB    16     2
#> 2 mi_do_km2… 874µs   1.18ms  911µs  13.8ms    851.      78.2KB    16   426
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
#> 1 mi_do_km1…    10   3.92µs   5.14µs    4.6µs  67.16µs 194695.          0B
#> 2 mi_do_km2…    10   1.73µs    2.2µs   1.96µs  42.89µs 454215.          0B
#> 3 mi_do_km1…   100  67.42µs  77.09µs  73.28µs 182.93µs  12972.     43.16KB
#> 4 mi_do_km2…   100   9.14µs   10.7µs   9.96µs 174.32µs  93471.        856B
#> 5 mi_do_km1…  1000    4.4ms   4.66ms   4.65ms    5.2ms    214.      3.87MB
#> 6 mi_do_km2…  1000   84.6µs  96.68µs  90.87µs   1.69ms  10343.      7.87KB
#> 7 mi_do_km1… 10000 506.79ms 506.79ms 506.79ms 506.79ms      1.97  382.04MB
#> 8 mi_do_km2… 10000 896.45µs   1.16ms 941.95µs  10.27ms    861.     78.18KB
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
