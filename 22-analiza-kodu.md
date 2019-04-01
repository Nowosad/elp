
# Analiza kodu {#analiza-kodu}

## Benchmarking


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
#> 1 mi_do_km1… 1.45µs 2.03µs 1.76µs 31.2µs   493041.     4.1MB     0 10000
#> 2 mi_do_km2… 1.03µs 1.32µs 1.19µs 13.4µs   757666.   221.8KB     0 10000
#> # … with 1 more variable: total_time <bch:tm>
```


```r
odl_mile2 = as.list(0:10000)
mark(mi_do_km1(odl_mile2),
     mi_do_km2(odl_mile2))
#> Warning: Some expressions had a GC in every iteration; so filtering is
#> disabled.
#> # A tibble: 2 x 10
#>   expression   min     mean median      max `itr/sec` mem_alloc  n_gc n_itr
#>   <chr>      <bch> <bch:tm> <bch:> <bch:tm>     <dbl> <bch:byt> <dbl> <int>
#> 1 mi_do_km1… 467ms 468.42ms  468ms 470.29ms      2.13     382MB    16     2
#> 2 mi_do_km2… 885µs   1.06ms  907µs   7.02ms    941.      78.2KB    11   471
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
#> 1 mi_do_km1…    10   3.92µs   5.03µs   4.66µs     63µs 198939.          0B
#> 2 mi_do_km2…    10   1.72µs   2.18µs   1.95µs  57.67µs 458554.          0B
#> 3 mi_do_km1…   100  68.04µs  78.43µs  75.33µs 268.35µs  12750.     43.16KB
#> 4 mi_do_km2…   100   9.17µs     11µs  10.19µs   1.92ms  90879.        856B
#> 5 mi_do_km1…  1000   4.41ms   4.62ms   4.61ms   5.65ms    216.      3.87MB
#> 6 mi_do_km2…  1000  84.45µs  94.97µs  90.81µs    2.5ms  10530.      7.87KB
#> 7 mi_do_km1… 10000 530.51ms 530.51ms 530.51ms 530.51ms      1.88  382.04MB
#> 8 mi_do_km2… 10000 876.62µs   1.05ms 916.98µs   7.24ms    951.     78.18KB
#> # … with 3 more variables: n_gc <dbl>, n_itr <int>, total_time <bch:tm>
```


```r
ggplot2::autoplot(porownanie)
```


## Profiling

<!-- profiling -->
<!-- https://r-prof.github.io/jointprof/articles/proposal.html -->

<!--  Wektoryzacja kodu -->
<!-- vectorized vs not-vectorized -->
<!-- https://rstudio-education.github.io/hopr/speed.html -->

## Zadanie
