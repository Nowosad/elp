
# Proste obiekty {#proste-obiekty}

Więcej informacji na temat podstawowych typów obiektów można znaleźć w rozdziale ["Vectors"](https://adv-r.hadley.nz/vectors-chap.html) książki Advanced R [@wickham2014advanced].

## Typy obiektów

Obiekty w R można podzielić na proste (homogeniczne) i złożone (heterogeniczne). 
Do podstawowych prostych obiektów należą wektory (ang. *vector*) i macierze (ang. *matrix*), natomiast listy (ang. *list*) i ramki danych (ang. *data frame*) to obiekty złożone.

W tym rozdziale skupimy się na wektorach.
Pozostałe podstawowe typy obiektów są omówione w rozdziale \@ref(zlozone-obiekty).

## Wektory

Wektor może przyjmować jeden z czterech podstawowych typów^[Do sprawdzania jakiego typu jest wektor służy funkcja `typeof()`.]:

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

Dodatkowo, istnieją dwa dodatkowe, rzadziej spotykane typy wektorów - czynnikowy (ang. *factor*) i dat (ang. *date*) (sekcja \@ref(facate)).

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">Wiele języków programowania posiada zmienne skalarne (tzw. skalary), czyli takie które mogą przyjmować tylko jedną wartość.
W R one nie występują, zamiast nich stosowane są wektory o długości jeden.</div>\EndKnitrBlock{rmdinfo}

## Właściwości wektorów

Każdy wektor ma trzy właściwości - typ, długość i atrybuty.


```r
# typ
typeof(wek_zmi)
#> [1] "double"

# długość
length(wek_zmi)
#> [1] 2

# atrybuty
attributes(wek_zmi)
#> NULL
```

## Podstawowe funkcje

<!-- metody -->


```r
str(wek_zmi)
#>  num [1:2] 5.3 -7.1
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

<!-- operatory statytyczne -->

## Działania na wektorach

Wiele podstawowych operacji w R jest zwektoryzowana. 
Przykładowo, możliwe jest pomnożenie kolejnych elementów jednego wektora przez kolejne elementy drugiego wektora.


```r
a = c(1, 2, 3)
b = c(3, 5, 10)
a * b
#> [1]  3 10 30
```

Kod zapisany w powyższy sposób zajmuje niewiele miejsca i jest łatwy do odczytania.
Alternatywnie możnaby ten problem rozbić na podelementy i je wymnożyć.


```r
a1 = 1
a2 = 2
a3 = 3
b1 = 3
b2 = 5
b3 = 10
a1 * b1
#> [1] 3
a2 * b2
#> [1] 10
a3 * b3
#> [1] 30
```

Jak można szybko zaobserwować, mnożenie kolejnych elementów w ten sposób wymaga zapisania znacznie więcej kodu i jest trudniejsze do odczytania.
Jest jeszcze trzecia możliwość użycie pętli (rozdział \@ref(petle)).


```r
y = numeric(length = 3)
for (i in 1:3){
  y[i] = a[i] * b[i]
}
y
#> [1]  3 10 30
```

Stworzony kod zajmuje mniej miejsca, ale nadal nie jest on bardzo łatwy do szybkiego zrozumienia.

Wektoryzacja ma też inną zaletę - obliczenia wykonywane w ten sposób są szybkie.
W przypadku stosowania niektórych operacji, np. mnożenia czy dodawania, R wykorzystuje w tle (bez wiedzy użytkownika) zoptymalizowane funkcje zapisane w języku C lub Fortran.
Więcej informacji na temat wektoryzowania kodu można znaleźć w rozdziale \@ref(petle).

## Brakujące wartości

Wyobraź sobie, że wykonujesz codziennie o 12:00 pomiar temperatury.


```r
temperatura = c(8.2, 10.3, 12.0)
```

Czwartego dnia twój termometr się popsuł i nie można było wykonać pomiaru.
Co należałoby w takim razie zrobić?
Możnaby pominąć ten pomiar, naprawić termometr i wykonać pomiar kolejnego dnia. 
Wówczas jednak mielibyśmy cztery wartości dla pięciu dni.
Inną możliwą opcją byłoby użycie wartości, która stałaby się kodem wartości brakujących, np. 999.
Problemem tego rozwiązania jest to w jaki sposób należałoby, np. wyliczyć średnią w tym obiekcie.


```r
temperatura = c(8.2, 10.3, 12.0, 999)
```

Najlepszą opcją byłoby wykorzystanie wbudowanego oznaczenia wartości brakujących w R - `NA`.


```r
temperatura = c(8.2, 10.3, 12.0, NA)
```

Zachowanie zmiennej `NA` (ang. *Not Available*) jest bardzo intuicyjne.
Przykładowo, jeżeli nie znamy jakiejś wartości to jeżeli dodamy do niej 2 to również nie wiemy jaki mamy wynik.


```r
NA + 2
#> [1] NA
5 > NA
#> [1] NA
```

Podobnie będzie w sytuacji, gdy chcemy wyliczyć średnią na podstawie wektora, który zawiera wartość `NA`.


```r
mean(temperatura)
#> [1] NA
```

W takich przypadkach najpierw należałoby usunąć wartość `NA` a następnie wyliczyć średnią z pozostałych wartości w tym wektorze.
Aby ułatwić taką operację w wielu funkcjach istnieje argument `na.rm`.
W momencie, gdy jest on ustalony na `TRUE`, to wszystkie przypadki `NA` są usuwane na potrzeby wyliczania średniej.


```r
mean(temperatura, na.rm = TRUE)
#> [1] 10.2
```

Do sprawdzenia czy w wektorze znajduje się wartość `NA` służy funkcja `is.na()`.


```r
is.na(temperatura)
#> [1] FALSE FALSE FALSE  TRUE
```

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">R posiada też kilka dodatkowych specjalnych obiektów, takich jak `NULL`, `NaN`, `Inf` oraz `-Inf`.
`NULL` ma długość zero i nie posiada żadnych atrybutów. 
Może on posłużyć np. do usuwania kolumn w ramkach danych.
`NaN` (ang. *Not a Number*) oznacza wartość, która nie jest zdefiniowaną lub nie może być reprezentowana w inny sposób, przykładowo `0/0`.
`Inf` i `-Inf` (ang. *Infinity*) jest wynikiem obliczeń, które dały bardzo dużą wartość dodatną lub ujemną, przykładowo `9^999`.</div>\EndKnitrBlock{rmdinfo}

## Wydzielanie 

R posiada trzy podstawowe operatory wydzielania (ang. *subsetting*) - `[]`, `[[]]` oraz `$`, które działają w różny sposób w zależności od tego czy wydzielamy wektory, macierze, ramki danych czy listy.
W tym rozdziale skupimy się na wydzielaniu elementów z wektora przy użyciu operatora `[]`.
Więcej na temat wydzielania innych obiektów można znaleźć w rozdziale \@ref(zlozone-obiekty).

Wydzielanie wektorów używając operatora `[]` może odbywać się używając jednego z poniższych zapytań:

1. Na podstawie pozycji.
2. Na podstawie wektora logicznego.
3. Na podstawie nazwy.
4. Używając elementu pustego.
5. Używając zera.

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

Wydzielanie elementów może mieć kilka dodatkowych zastosowań oprócz wyświetlania wybranych wartości.
Kolejną możliwością jest tworzenie nowych obiektów na podstawie wydzieleń.


```r
temperatura_pon = temperatura["Poniedziałek"]
temperatura_pon
#> Poniedziałek 
#>          8.2
```


```r
temparatura_10 = temperatura[temperatura > 10 & !is.na(temperatura)]
temparatura_10
#> Wtorek  Środa 
#>   10.3   12.0
```

## Modyfikowanie obiektów


```r
temperatura
#> Poniedziałek       Wtorek        Środa     Czwartek 
#>          8.2         10.3         12.0           NA
```


```r
temperatura["Czwartek"]
#> Czwartek 
#>       NA
```


```r
temperatura["Czwartek"] = 9.1
temperatura["Czwartek"]
#> Czwartek 
#>      9.1
```

## Łączenie podstawowych typów obiektów

<!-- tekst -->
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

## Wektory czynnikowe {#facate}

## Wektory dat

<!-- factor i date -->
<!-- https://rstudio-education.github.io/hopr/r-objects.html -->

## Zmiana typów obiektów

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
