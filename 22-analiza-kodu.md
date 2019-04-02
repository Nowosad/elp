
# Analiza kodu {#analiza-kodu}

## Benchmarking

<!-- system.time -->


```r
system.time(mean(1:100000000))
#>    user  system elapsed 
#>   0.568   0.004   0.572
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
#> 1 mi_do_km1… 1.41µs 1.87µs 1.61µs 71.2µs   534270.     300KB     1  9999
#> 2 mi_do_km2… 1.02µs  1.3µs 1.16µs 24.6µs   767845.     222KB     0 10000
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
#> 1 mi_do_km1… 479ms 488.85ms  489ms 498.5ms      2.05     382MB    16     2
#> 2 mi_do_km2… 869µs   1.18ms  918µs  13.6ms    844.      78.2KB    16   426
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
#> 1 mi_do_km1…    10   3.87µs   5.13µs   4.56µs 113.19µs 194977.          0B
#> 2 mi_do_km2…    10   1.72µs   2.16µs   1.94µs 110.95µs 462417.          0B
#> 3 mi_do_km1…   100  67.22µs  78.16µs  73.69µs  298.2µs  12794.     43.16KB
#> 4 mi_do_km2…   100   9.14µs  10.75µs   9.98µs 115.39µs  92993.        856B
#> 5 mi_do_km1…  1000   4.49ms   4.75ms   4.74ms   5.11ms    211.      3.87MB
#> 6 mi_do_km2…  1000  84.38µs  97.09µs  91.63µs 497.42µs  10300.      7.87KB
#> 7 mi_do_km1… 10000 487.06ms 491.12ms 491.12ms 495.18ms      2.04  382.04MB
#> 8 mi_do_km2… 10000 887.15µs   1.16ms 925.92µs  14.27ms    859.     78.18KB
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

<!--  Wektoryzacja kodu -->
<!-- vectorized vs not-vectorized -->
<!-- https://rstudio-education.github.io/hopr/speed.html -->

## Zadanie

<!-- 1. benchmarking -->
<!-- porównaj rowsum vs colsum vs loops implementation -->
<!-- 2. profiling -->
<!-- ??? -->
