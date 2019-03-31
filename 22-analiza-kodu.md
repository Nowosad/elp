
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
#> 1 mi_do_km1… 1.47µs 2.03µs 1.78µs   29µs   492041.     4.1MB     0 10000
#> 2 mi_do_km2… 1.08µs 1.41µs 1.25µs 17.4µs   709409.   221.8KB     0 10000
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
#> 1 mi_do_km1… 468ms 479.66ms  480ms  491.8ms      2.08     382MB    16     2
#> 2 mi_do_km2… 888µs   1.06ms  907µs   6.79ms    939.      78.2KB    11   470
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
#> 1 mi_do_km1…    10   3.95µs   4.98µs   4.61µs  79.77µs 200701.          0B
#> 2 mi_do_km2…    10   1.79µs   2.12µs   1.99µs  75.27µs 470911.          0B
#> 3 mi_do_km1…   100  67.99µs  78.58µs  75.23µs   3.37ms  12727.     43.16KB
#> 4 mi_do_km2…   100   9.24µs  10.89µs  10.15µs  82.43µs  91842.        856B
#> 5 mi_do_km1…  1000   4.41ms   4.61ms   4.52ms    5.6ms    217.      3.87MB
#> 6 mi_do_km2…  1000  84.58µs  93.28µs   90.6µs 811.47µs  10720.      7.87KB
#> 7 mi_do_km1… 10000 534.83ms 534.83ms 534.83ms 534.83ms      1.87  382.04MB
#> 8 mi_do_km2… 10000 875.64µs   1.05ms 914.96µs   7.71ms    948.     78.18KB
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
