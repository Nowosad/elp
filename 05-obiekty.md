
# Proste obiekty {#proste-obiekty}

Więcej informacji na temat podstawowych typów obiektów można znaleźć w rozdziale ["Vectors"](https://adv-r.hadley.nz/vectors-chap.html) książki Advanced R [@wickham2014advanced].

## Działania na obiektach (wektoryzacja)

<!-- Zmienna skalarna (block) -->

## Typy obiektów

Obiekty w R można podzielić na proste (homogeniczne) i złożone (heterogeniczne). 
Do podstawowych prostych obiektów należą wektory (ang. *vector*) i macierze (ang. *matrix*), natomiast listy (ang. *list*) i ramki danych (ang. *data frame*) to obiekty złożone.

<!-- `str()` -->

W tym rozdziale skupimy się na wektorach.
Pozostałe podstawowe typy obiektów są omówione w rozdziale \@ref(zlozone-obiekty).
Wektor może przyjmować jeden z czterech typów^[Do sprawdzania jakiego typu jest wektor służy funkcja `typeof()`.]:

1. logiczny (ang. *logical*)


```r
wek_log = c(TRUE, FALSE)
wek_log
#> [1]  TRUE FALSE
```

2. liczba całkowita (ang. *interger*)


```r
wek_cal = c(5L, -7L)
wek_cal
#> [1]  5 -7
```

3. liczba zmiennoprzecinkowa (ang. *double*)^[Liczby zmiennoprzecinkowe mogą być też reprezentowane poprzez notację naukową, np. 11111.2 może być zapisane jako 1.11112e4, a 0.00021 jako 2.1e-4.]


```r
wek_zmi = c(5.3, -7.1)
wek_zmi
#> [1]  5.3 -7.1
```

4. znakowy (ang. *character*)


```r
wek_zna = c("kot", "pies")
wek_zna
#> [1] "kot"  "pies"
```

<!--ref to style-->
<!-- Typ numeryczny -->
<!-- block factor -->

## Podstawowe funkcje

<!-- metody -->


```r
str(wek_zmi)
#>  num [1:2] 5.3 -7.1
```


```r
typeof(wek_zmi)
#> [1] "double"
```


```r
length(wek_zmi)
#> [1] 2
```


```r
names(wek_zmi)
#> NULL
```


```r
names(wek_zmi) = c("a", "b")
wek_zmi
#>    a    b 
#>  5.3 -7.1
```


```r
names(wek_zmi)
#> [1] "a" "b"
```


```r
rep(wek_zmi, 4)
#>    a    b    a    b    a    b    a    b 
#>  5.3 -7.1  5.3 -7.1  5.3 -7.1  5.3 -7.1
```


```r
seq(1, 12, by = 2)
#> [1]  1  3  5  7  9 11
```

<!-- block - nazwa tekstem -->

<!-- operatory statytyczne -->

## Brakujące wartości

Wyobraź sobie, że wykonujesz codziennie o 12:00 pomiar temperatury.


```r
temperatura = c(8.2, 10.3, 12.0)
```

Czwartego dnia twój termometr się popsuł i nie można było wykonać pomiaru.
Co należałoby w takim razie zrobić?

- Możnaby pominąć ten pomiar, naprawić termometr i wykonać pomiar kolejnego dnia. 
Wówczas jednak mielibyśmy cztery wartości dla pięciu dni.
- Inną możliwą opcją byłoby użycie wartości, która stałaby się kodem wartości brakujących, np. 999.
Problemem tego rozwiązania jest to w jaki sposób należałoby, np. wyliczyć średnią w tym obiekcie.


```r
temperatura = c(8.2, 10.3, 12.0, 999)
```

- Najlepszą opcją byłoby wykorzystanie wbudowanego oznaczenia wartości brakujących w R - `NA`.


```r
temperatura = c(8.2, 10.3, 12.0, NA)
```

<!-- operacje na NA -->
<!-- `is.na()` -->
<!-- na.rm -->
<!-- NULL -->

## Wydzielanie 

R posiada trzy podstawowe operatory wydzielania (ang. *subsetting*) - `[]`, `[[]]` oraz `$`, które działają w różny sposób w zależności od tego czy wydzielamy wektory, macierze, ramki danych czy listy.
W tym rozdziale skupimy się na wydzielaniu elementów z wektora przy użyciu operatora `[]`.
Więcej na temat wydzielania innych obiektów można znaleźć w rozdziale \@ref(zlozone-obiekty).

Wydzielanie wektorów używając operatora `[]` może odbywać się używając jednego z poniższych zapytań:

1. Na podstawie pozycji
2. Na podstawie wektora logicznego
3. Na podstawie nazwy
4. Używając elementu pustego
5. Używając zera

<!-- na podstawie pozycji -->


```r
temperatura[c(1, 3)]
#> [1]  8.2 12.0
```


```r
temperatura[-c(2, 4)]
#> [1]  8.2 12.0
```

<!-- na podstawie wektora logicznego -->


```r
temperatura[c(TRUE, FALSE, TRUE, FALSE)]
#> [1]  8.2 12.0
```


```r
temperatura[temperatura > 10]
#> [1] 10.3 12.0   NA
```

<!-- na podstawie nazwy -->

```r
names(temperatura) = c("Poniedziałek", "Wtorek", "Środa", "Czwartek")
temperatura
#> Poniedziałek       Wtorek        Środa     Czwartek 
#>          8.2         10.3         12.0           NA
```


```r
temperatura[c("Wtorek", "Czwartek")]
#>   Wtorek Czwartek 
#>     10.3       NA
```

<!-- nic -->


```r
temperatura[]
#> Poniedziałek       Wtorek        Środa     Czwartek 
#>          8.2         10.3         12.0           NA
```

<!-- zero -->


```r
temperatura[0]
#> named numeric(0)
```

## Wydzielanie i przypisanie

<!-- ... -->

## Modyfikowanie obiektów

<!-- ... -->

### Łączenie podstawowych typów obiektów

<!-- tekst -->


```r
c(temperatura, temperatura)
#> Poniedziałek       Wtorek        Środa     Czwartek Poniedziałek 
#>          8.2         10.3         12.0           NA          8.2 
#>       Wtorek        Środa     Czwartek 
#>         10.3         12.0           NA
```

Właściwością wektora jest to, że może on przyjmować tylko jeden typ.
Próba stworzenia obiektu składającego się z wielu typów spowoduje wymuszenie (ang. *coercion*) do najbliższego możliwego typu.
Odbywa się to zgodnie z zasadą: logiczny -> liczba całkowita -> liczba zmiennoprzecinkowa -> znakowy.


```r
FALSE
#> [1] FALSE
```


```r
c(FALSE, 0L)
#> [1] 0 0
```


```r
c(FALSE, 0L, 3.1)
#> [1] 0.0 0.0 3.1
```


```r
c(FALSE, 0L, 3.1, "kot")
#> [1] "FALSE" "0"     "3.1"   "kot"
```

## ...

<!-- factor i date -->
<!-- https://rstudio-education.github.io/hopr/r-objects.html -->

### Zmiana typów obiektów

<!--rzutowanie??-->

Do zmiany typu obiektu służą funkcje `as.logical()`, `as.integer()`, `as.double()`, oraz `as.character()`^[Do sprawdzenia czy dany obiekt należy do wybranego typu służą funkcje `is.logical()`, `is.integer()`,`is.double()`,  oraz `is.character()`.].


```r
as.logical(c("FALSE", "TRUE")) # znakowy na logiczny
#> [1] FALSE  TRUE
```


```r
as.integer(c("3", "2")) # znakowy na liczba całkowita 
#> [1] 3 2
```


```r
as.double(c(3L, 2L)) # liczba całkowita na liczba zmiennoprzecinkowa
#> [1] 3 2
```


```r
as.character(c(3L, 2L)) # liczba całkowita na znakowy
#> [1] "3" "2"
```


## Zadania
