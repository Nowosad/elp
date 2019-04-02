
# Analiza kodu {#analiza-kodu}

## Benchmarking

<!-- system.time -->


```r
system.time(mean(1:100000000))
#>    user  system elapsed 
#>   0.576   0.004   0.577
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
#>   expression    min   mean median   max `itr/sec` mem_alloc  n_gc n_itr
#>   <chr>      <bch:> <bch:> <bch:> <bch>     <dbl> <bch:byt> <dbl> <int>
#> 1 mi_do_km1… 1.46µs 1.96µs 1.69µs  50µs   510985.     300KB     1  9999
#> 2 mi_do_km2… 1.06µs 1.34µs 1.19µs  31µs   746693.     222KB     0 10000
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
#> 1 mi_do_km1… 474ms 483.43ms  483ms 492.9ms      2.07     382MB    16     2
#> 2 mi_do_km2… 878µs   1.17ms  916µs  13.3ms    857.      78.2KB    16   429
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
#> 1 mi_do_km1…    10   3.95µs   5.27µs   4.65µs  66.08µs 189831.          0B
#> 2 mi_do_km2…    10   1.76µs    2.4µs   2.02µs  31.23µs 415789.          0B
#> 3 mi_do_km1…   100  67.51µs  79.83µs  73.46µs   1.69ms  12526.     43.16KB
#> 4 mi_do_km2…   100   9.17µs  11.02µs  10.05µs 228.91µs  90713.        856B
#> 5 mi_do_km1…  1000   4.35ms   4.67ms   4.66ms   6.29ms    214.      3.87MB
#> 6 mi_do_km2…  1000  84.34µs  95.52µs  90.12µs  341.2µs  10469.      7.87KB
#> 7 mi_do_km1… 10000 479.53ms 482.58ms 482.58ms 485.63ms      2.07  382.04MB
#> 8 mi_do_km2… 10000 875.59µs   1.16ms 912.92µs  14.24ms    862.     78.18KB
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
