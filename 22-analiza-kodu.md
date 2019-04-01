
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
#>   expression      min   mean median    max `itr/sec` mem_alloc  n_gc n_itr
#>   <chr>      <bch:tm> <bch:> <bch:> <bch:>     <dbl> <bch:byt> <dbl> <int>
#> 1 mi_do_km1…   1.29µs 1.95µs 1.65µs 32.5µs   512473.     4.1MB     0 10000
#> 2 mi_do_km2… 937.14ns 1.32µs 1.19µs 27.8µs   756540.   221.8KB     0 10000
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
#> 1 mi_do_km1… 475ms 478.66ms  479ms 482.01ms      2.09     382MB    16     2
#> 2 mi_do_km2… 832µs   1.06ms  919µs   6.74ms    943.      78.2KB    11   472
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
#> 1 mi_do_km1…    10   3.36µs   4.88µs   4.39µs  59.09µs 204693.          0B
#> 2 mi_do_km2…    10   1.55µs    2.1µs   1.89µs  50.85µs 477401.          0B
#> 3 mi_do_km1…   100  58.71µs  79.39µs  74.59µs   1.17ms  12596.     43.16KB
#> 4 mi_do_km2…   100   7.84µs  10.88µs   9.83µs  43.34µs  91880.        856B
#> 5 mi_do_km1…  1000    4.2ms   4.62ms    4.6ms   5.98ms    216.      3.87MB
#> 6 mi_do_km2…  1000  77.29µs  94.29µs  90.05µs 891.18µs  10605.      7.87KB
#> 7 mi_do_km1… 10000 535.09ms 535.09ms 535.09ms 535.09ms      1.87  382.04MB
#> 8 mi_do_km2… 10000 810.36µs   1.04ms 919.75µs    6.8ms    961.     78.18KB
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
