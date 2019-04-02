
# Analiza kodu {#analiza-kodu}

## Benchmarking

<!-- system.time -->


```r
system.time(mean(1:100000000))
#>    user  system elapsed 
#>   0.576   0.000   0.575
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
#>   expression    min   mean median     max `itr/sec` mem_alloc  n_gc n_itr
#>   <chr>      <bch:> <bch:> <bch:> <bch:t>     <dbl> <bch:byt> <dbl> <int>
#> 1 mi_do_km1… 1.44µs 1.92µs 1.65µs   105µs   520401.     300KB     1  9999
#> 2 mi_do_km2… 1.02µs 1.28µs 1.16µs  17.7µs   780714.     222KB     0 10000
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
#> 1 mi_do_km1… 532ms 532.07ms  532ms 532.1ms      1.88     382MB     8     1
#> 2 mi_do_km2… 872µs   1.18ms  923µs  12.8ms    846.      78.2KB    16   426
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
#> 1 mi_do_km1…    10    3.9µs   5.01µs   4.57µs 119.54µs 199453.          0B
#> 2 mi_do_km2…    10   1.72µs   2.11µs   1.93µs  17.43µs 473664.          0B
#> 3 mi_do_km1…   100  67.24µs  77.57µs  74.73µs 227.95µs  12892.     43.16KB
#> 4 mi_do_km2…   100   9.18µs  10.63µs   9.96µs 107.15µs  94052.        856B
#> 5 mi_do_km1…  1000   4.38ms   4.64ms   4.58ms   5.73ms    216.      3.87MB
#> 6 mi_do_km2…  1000  84.84µs  96.66µs  92.24µs  262.5µs  10346.      7.87KB
#> 7 mi_do_km1… 10000 480.74ms 485.46ms 485.46ms 490.18ms      2.06  382.04MB
#> 8 mi_do_km2… 10000 884.71µs   1.14ms 917.69µs   9.92ms    877.     78.18KB
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
