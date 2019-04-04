
# Analiza kodu {#analiza-kodu}

<!-- benchmarking -->
<!-- profiling -->
<!-- testing -->

## Benchmarking

Benchmarking oznacza określanie wydajności danej operacji czy funkcji.
Wydajność może być określona na wiele różnych sposobów, w tym najprostszym jest czas wykonania pewnego kodu.
Do określenia ile czasu zajmuje działanie operacji można użyć wbudowanej funkcji `system.time()`.


```r
system.time(kod_do_wykonania)
```

Przykładowo, poniżej nastąpi sprawdzenie czasu jaki zajmie wyliczenie średniej wartości z sekwencji od 1 do 100000000.


```r
system.time(mean(1:100000000))
#>    user  system elapsed 
#>   0.572   0.000   0.570
```

W efekcie dostajemy trzy wartości - `user`, `system` i `elapsed`. Pierwsza z nich określa czas obliczenia po stronie użytkownika (sesji R), druga opisuje czas obliczenia po stronie systemu operacyjnego (np. otwieranie plików), a trzecia to sumaryczny czas wykonywania operacji.

Benchmarking jest często używany w sytuacji, gdy istnieje kilka  funkcji służących do tego samego celu (np. w różnych pakietach) i chcemy znaleźć tę, która ma najwyższą wydajność.
Jest on też stosowany, gdy sami napisaliśmy kilka implementacji rozwiązania tego samego problemu i chcemy sprawdzić, które z nich jest najszybsze.

W sekcji \@ref(for-example) stworzyliśmy kilka wersji pętli `for` pozwalającej na przeliczanie wartości z mil lądowych na kilometry. 
Pierwsza z nich, tutaj zdefiniowana jako funkcja `mi_do_km1`, tworzy pusty wektor o długości 0, do którego następie doklejane są kolejne przeliczone wartości.


```r
mi_do_km1 = function(odl_mile){
  odl_km = vector("list", length = 0)
  for (i in seq_along(odl_mile)) {
    odl_km = c(odl_km, odl_mile[[i]] * 1.609)
  }
  odl_km
}
```

Druga, tutaj zdefiniowana jako funkcja `mi_do_km2`, tworzy pusty wektor o oczekiwanej długości wyniku. 
Następnie kolejne przeliczone wartości są wstawiane w odpowiednie miejsca wektora wynikowego.


```r
mi_do_km2 = function(odl_mile){
  odl_km = vector("list", length = length(odl_mile))
  for (i in seq_along(odl_mile)) {
    odl_km[[i]] = odl_mile[[i]] * 1.609
  }
  odl_km
}
```

Dwie powyższe funkcje można porównać używając `system.time()`. 
Nie zawsze jednak to wystarczy - ta sama funkcja wykonana dwa razy może mieć różny czas obliczeń.<!--why??-->
Dodatkowo, oprócz czasu wykonywania funkcji może nas interesować zużycie zasobów, takich jak pamięc operacyjna.
Do takiego celu powstała funkcja `mark()` z pakietu **bench** [@R-bench], która wykonuje funkcje wiele razy przed zwróceniem wyniku.

Przyjmuje ona wywołania funkcji, które chcemy porównać.
Poniżej nastąpi porównanie funkcji `mi_do_km1` i `mi_do_km2`, w przypadku gdy jako dane wejściowe zostanie podana lista z wartościami 142, 63, 121.


```r
library(bench)
odl_mile = list(142, 63, 121)
wynik_1 = mark(
  mi_do_km1(odl_mile),
  mi_do_km2(odl_mile)
)
wynik_1
#> # A tibble: 2 x 10
#>   expression    min   mean median    max `itr/sec` mem_alloc  n_gc n_itr
#>   <chr>      <bch:> <bch:> <bch:> <bch:>     <dbl> <bch:byt> <dbl> <int>
#> 1 mi_do_km1… 1.42µs 1.96µs 1.66µs 41.1µs   510090.     300KB     1  9999
#> 2 mi_do_km2… 1.02µs 1.29µs 1.16µs 61.1µs   776759.     222KB     1  9999
#> # … with 1 more variable: total_time <bch:tm>
```

Efektem porównania jest ramka danych, w której każdy wiersz oznacza inną porównywaną funkcję.
Zawiera ona szereg charakterystyk, w tym:

- `min` - minimalny czas wykonania funkcji
- `mean` - średni czas wykonania funkcji
- `median` - mediana czasu wykonania funkcji
- `max` - maksymalny czas wykonania funkcji
- `itr/sec` - liczba wykonań funkcji na sekundę
- `mem_alloc` - pamięć użyta przez wywołanie funkcji
- `n_itr` - liczba powtórzeń wywołania funkcji

Wynik działania funkcji `mark()` pozwala na zauważnie, że na tym przykładzie funkcja `mi_do_km2` jest ok. 30% szybsza od `mi_do_km1`.
Czasami możliwe jest, że jakaś funkcja działa relatywnie szybko na małych danych, ale dużo wolniej na większych danych wejściowych.
Warto jest więc sprawdzić, jak będzie wyglądało nasze porównanie na większej liście, np. z wartościami od 0 do 10000 co 1.


```r
odl_mile2 = as.list(0:10000)
wynik_2 = mark(
  mi_do_km1(odl_mile2),
  mi_do_km2(odl_mile2)
)
#> Warning: Some expressions had a GC in every iteration; so filtering is
#> disabled.
wynik_2
#> # A tibble: 2 x 10
#>   expression   min     mean median     max `itr/sec` mem_alloc  n_gc n_itr
#>   <chr>      <bch> <bch:tm> <bch:> <bch:t>     <dbl> <bch:byt> <dbl> <int>
#> 1 mi_do_km1… 459ms 469.19ms  469ms 479.8ms      2.13     382MB    16     2
#> 2 mi_do_km2… 874µs   1.15ms  917µs  13.6ms    868.      78.2KB    15   434
#> # … with 1 more variable: total_time <bch:tm>
```

W tym przypadku róznica pomiędzy `mi_do_km1` a `mi_do_km2` staje się dużo większa. 
Funkcja `mi_do_km1` jest w stanie wykonać tylko 2.13 operacji na sekundę, przy aż 867.86 operacji na sekundę funkcji `mi_do_km2`.
Dodatkowo, funkcja `mi_do_km1` potrzebowała aż kilka tysięcy (!) razy więcej pamięci operacyjnej niż `mi_do_km2`.


```
#> Running with:
#>       x
#> 1    10
#> 2   100
#> 3  1000
#> 4 10000
#> Warning: Some expressions had a GC in every iteration; so filtering is
#> disabled.
#> # A tibble: 8 x 11
#>   expression     x      min     mean   median      max `itr/sec` mem_alloc
#>   <chr>      <dbl> <bch:tm> <bch:tm> <bch:tm> <bch:tm>     <dbl> <bch:byt>
#> 1 mi_do_km1…    10   3.89µs   5.08µs   4.59µs  52.77µs 196809.          0B
#> 2 mi_do_km2…    10   1.72µs   2.16µs   1.96µs  17.04µs 463215.          0B
#> 3 mi_do_km1…   100   66.3µs  77.51µs  74.23µs 834.58µs  12901.     43.16KB
#> 4 mi_do_km2…   100   8.94µs  10.68µs     10µs  41.61µs  93615.        856B
#> 5 mi_do_km1…  1000    4.4ms   4.67ms   4.65ms   5.13ms    214.      3.87MB
#> 6 mi_do_km2…  1000  84.73µs  95.93µs  91.94µs   1.35ms  10425.      7.87KB
#> 7 mi_do_km1… 10000  497.7ms 508.69ms 508.69ms 519.67ms      1.97  382.04MB
#> 8 mi_do_km2… 10000 876.55µs   1.05ms 921.41µs   9.86ms    949.     78.18KB
#> # … with 3 more variables: n_gc <dbl>, n_itr <int>, total_time <bch:tm>
```



## Profiling

Istnieją trzy podstawowe reguły optymalizacji kodu^[http://www.moscowcoffeereview.com/programming/the-3-rules-of-optimization/]:

1. Nie.
2. Jeszcze nie.
3. Profiluj przed optymalizowaniem.

Czym jest profilowanie i dlaczego powinno być wykonywane przed optymalizowaniem kodu?
Profilowanie mierzy wydajność działania każdej linii kodu w celu sprawdzenia, która linia zabiera najwięcej czasu lub zasobów.
Dzięki profilowaniu można określić fragmenty kodu, które można poprawić w celu zwiększenia czasu wykonywania skryptu czy funkcji.

Poniżej znajduje się zawartość pliku `R/moja_funkcja.R`.
Jego działanie polega na stworzeniu wektora od 1 do 9999999 (obiekt `x`), wektora od 1 do 19999998 co 2 (obiekt `y`), połączenie tych wektorów do ramki danych (obiekt `df`), wyliczenie sumy wartości dla każdego wiersza (obiekt `z`), a na końcu wyliczenie średniej z obiektu `z`.
Która z tych linii zabiera najwięcej czasu a która najmniej?


```r
# plik R/moja_funkcja.R
x = 1:9999999
y = seq(1, 19999998, by = 2)
df = data.frame(x = x, y = y)
z = rowSums(df)
mean(z)
```

Profilowanie kodu R można wykonać używając pakietu **profvis** [@R-profvis].


```r
library(profvis)
profvis(source("R/moja_funkcja.R"))
```

<img src="images/profvis.png" width="100%" style="display: block; margin: auto;" />

<!-- add image/app -->

<!-- profiling -->
<!-- https://r-prof.github.io/jointprof/articles/proposal.html -->

<!-- https://adv-r.hadley.nz/perf-improve.html -->

<!--  Wektoryzacja kodu -->
<!-- vectorized vs not-vectorized -->
<!-- https://rstudio-education.github.io/hopr/speed.html -->

## Testy jednostkowe

[@R-testthat]


```r
library(testthat)
```


```r
nowy_prostokat = function(xmin, ymin, xmax, ymax){
  if (!all(c(length(xmin), length(ymin), length(xmax), length(ymax)) == 1)){
    stop("Każdy z argumentów może przyjmować tylko jedną wartość")
  }
  vals = c(xmin, ymin, xmax, ymax)
  if (!(is.numeric(vals))){
    stop("Wszystkie argumenty muszą być typu numerycznego")
  }
  x = matrix(vals, ncol = 2)
  structure(x, class = "prostokat")
}
powierzchnia = function(x) {
  UseMethod("powierzchnia")
}
powierzchnia.prostokat = function(x){
  a = x[1, 2] - x[1, 1]
  b = x[2, 2] - x[2, 1]
  a * b
}
```



`expect_warning()`, `expect_message()`


```r
expect_error(nowy_prostokat(3, 5, 2, "a"))
expect_error(nowy_prostokat(1, 2, 3, 6))
#> Error: `nowy_prostokat(1, 2, 3, 6)` did not throw an error.
```


```r
nowy_p = nowy_prostokat(0, 0, 6, 5)
expect_length(powierzchnia(nowy_p), 1)
```

`expect_identical()`, `expect_equivalent()`


```r
expect_equal(powierzchnia(nowy_p), 30)
```

https://testthat.r-lib.org/reference/index.html

<!-- When you find a bug, write a test -->
<!-- Automated testing with Travis CI + codecov -->

## Zadanie

<!-- 1. benchmarking -->
<!-- porównaj rowsum vs colsum vs loops implementation -->
<!-- 2. profiling -->
<!-- ??? -->
