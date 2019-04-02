
# Analiza kodu {#analiza-kodu}

## Benchmarking

<!-- system.time -->


```r
system.time(mean(1:100000000))
#>    user  system elapsed 
#>   0.568   0.000   0.567
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
#> 1 mi_do_km1… 1.43µs 1.89µs 1.65µs   66µs   529202.     300KB     1  9999
#> 2 mi_do_km2… 1.03µs 1.34µs 1.19µs 20.9µs   744840.     222KB     0 10000
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
#> 1 mi_do_km1… 478ms 482.2ms  482ms   486ms      2.07     382MB    16     2
#> 2 mi_do_km2… 870µs   1.2ms  916µs  13.9ms    835.      78.2KB    15   418
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
#> 1 mi_do_km1…    10   3.88µs   5.23µs   4.67µs  73.35µs 191367.          0B
#> 2 mi_do_km2…    10   1.74µs   2.22µs   1.96µs  63.03µs 451340.          0B
#> 3 mi_do_km1…   100  67.46µs  78.23µs  74.08µs 199.27µs  12782.     43.16KB
#> 4 mi_do_km2…   100   9.14µs  10.92µs  10.02µs  97.47µs  91543.        856B
#> 5 mi_do_km1…  1000   4.43ms   4.68ms   4.69ms   5.05ms    214.      3.87MB
#> 6 mi_do_km2…  1000  84.31µs  96.93µs     92µs   2.18ms  10317.      7.87KB
#> 7 mi_do_km1… 10000 496.29ms 505.71ms 505.71ms 515.12ms      1.98  382.04MB
#> 8 mi_do_km2… 10000  916.6µs    1.2ms    946µs  14.14ms    836.     78.18KB
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
x = 1:9999999
y = seq(1, 19999998, by = 2)
df = data.frame(x = x, y = y)
z = rowSums(df)
mean(z)
```


```r
library(profvis)
profvis(source("R/moja_funkcja.R"))
```

<!-- profiling -->
<!-- https://r-prof.github.io/jointprof/articles/proposal.html -->

<!-- https://adv-r.hadley.nz/perf-improve.html -->

<!--  Wektoryzacja kodu -->
<!-- vectorized vs not-vectorized -->
<!-- https://rstudio-education.github.io/hopr/speed.html -->

## Zadanie

<!-- 1. benchmarking -->
<!-- porównaj rowsum vs colsum vs loops implementation -->
<!-- 2. profiling -->
<!-- ??? -->
