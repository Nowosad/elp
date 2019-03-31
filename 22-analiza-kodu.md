
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
#> 1 mi_do_km1… 1.43µs 2.08µs 1.78µs 26.9µs   481493.     4.1MB     0 10000
#> 2 mi_do_km2… 1.03µs 1.35µs 1.23µs 95.2µs   738991.   221.8KB     0 10000
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
#> 1 mi_do_km1… 475ms 478.76ms  479ms 482.47ms      2.09     382MB    16     2
#> 2 mi_do_km2… 889µs   1.09ms  923µs   7.57ms    914.      78.2KB    11   460
#> # … with 1 more variable: total_time <bch:tm>
```


```r
tworz_liste = function(x){
  as.list(0:x)
}
```


```r
porownanie = press(x = c(10, 100, 1000, 10000),
                   {
                   l = tworz_liste(x)
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
