
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
#> 1 mi_do_km1… 1.45µs 1.95µs 1.73µs 31.5µs   513956.     4.1MB     0 10000
#> 2 mi_do_km2… 1.05µs 1.33µs 1.24µs 12.7µs   749600.   221.8KB     0 10000
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
#> 1 mi_do_km1… 470ms 473.21ms  473ms 476.66ms      2.11     382MB    16     2
#> 2 mi_do_km2… 886µs   1.05ms  908µs   6.77ms    951.      78.2KB    11   476
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
#> 1 mi_do_km1…    10   3.94µs   4.99µs    4.6µs  70.29µs 200276.          0B
#> 2 mi_do_km2…    10   1.75µs   2.14µs   1.98µs  30.64µs 466315.          0B
#> 3 mi_do_km1…   100  68.26µs   79.5µs  75.98µs   1.26ms  12578.     43.16KB
#> 4 mi_do_km2…   100   9.19µs  10.99µs   10.2µs 774.68µs  91006.        856B
#> 5 mi_do_km1…  1000   4.44ms   4.67ms   4.56ms    7.7ms    214.      3.87MB
#> 6 mi_do_km2…  1000  84.52µs  94.65µs  91.36µs 736.74µs  10565.      7.87KB
#> 7 mi_do_km1… 10000 521.24ms 521.24ms 521.24ms 521.24ms      1.92  382.04MB
#> 8 mi_do_km2… 10000 878.53µs   1.04ms 913.97µs   7.05ms    959.     78.18KB
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
