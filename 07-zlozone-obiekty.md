
# Złożone obiekty {#zlozone-obiekty}

W rozdziale \@ref(proste-obiekty) omówiono wektory atomowe, które są obiektami jednowymiarowymi zawierającymi tylko jeden typ danych.
Ten rozdział jest poświęcony pozostałymi trzema podstawowymi klasami obiektów w R - macierzami, ramkami danych i listami (sekcje \@ref(macierze), \@ref(df), i \@ref(listy)).

## Macierze

Macierze (ang. *matrix*), podobnie jak wektory, są obiektami homogenicznymi - jedna macierz może przyjmować dane tylko jednego typu.
<!-- ref to arrays -->

### Tworzenie


```r
macierz1 = matrix(1:12, nrow = 4, ncol = 3)
macierz1
#>      [,1] [,2] [,3]
#> [1,]    1    5    9
#> [2,]    2    6   10
#> [3,]    3    7   11
#> [4,]    4    8   12
```


```r
macierz2 = matrix(1:12, nrow = 4, ncol = 3, byrow = TRUE)
macierz2
#>      [,1] [,2] [,3]
#> [1,]    1    2    3
#> [2,]    4    5    6
#> [3,]    7    8    9
#> [4,]   10   11   12
```

<!-- Macierze używane są ... zastosowania. -->
<!-- ref to rasters -->

### Podstawowe funkcje


```r
class(macierz2)
#> [1] "matrix"
```


```r
str(macierz2)
#>  int [1:4, 1:3] 1 4 7 10 2 5 8 11 3 6 ...
```


```r
typeof(macierz2)
#> [1] "integer"
```


```r
ncol(macierz2)
#> [1] 3
```


```r
nrow(macierz2)
#> [1] 4
```


```r
colnames(macierz2)
#> NULL
```


```r
colnames(macierz2) = c("a", "b", "c")
macierz2
#>       a  b  c
#> [1,]  1  2  3
#> [2,]  4  5  6
#> [3,]  7  8  9
#> [4,] 10 11 12
colnames(macierz2)
#> [1] "a" "b" "c"
```

<!-- `rownames()` - info about problems with rownames (block) -->

### Wydzielanie

Podobnie jak w przypadku wektorów (rozdział \@ref(proste-obiekty)), macierze można wydzielać używając operatora `[]`.
W tym wypadku odbywa się to jednak w oparciu o dwa indeksy - jeden dla wiersza, drugi dla kolumny - `[wiersz, kolumna]`.


```r
macierz2[c(1, 2), c(1, 3)]
#>      a c
#> [1,] 1 3
#> [2,] 4 6
```


```r
macierz2[c(1, 2), ]
#>      a b c
#> [1,] 1 2 3
#> [2,] 4 5 6
```


```r
macierz2[, c(1, 3)]
#>       a  c
#> [1,]  1  3
#> [2,]  4  6
#> [3,]  7  9
#> [4,] 10 12
```


```r
macierz2[, c(TRUE, FALSE, TRUE)]
#>       a  c
#> [1,]  1  3
#> [2,]  4  6
#> [3,]  7  9
#> [4,] 10 12
```


```r
macierz2[, c("a", "c")]
#>       a  c
#> [1,]  1  3
#> [2,]  4  6
#> [3,]  7  9
#> [4,] 10 12
```

<!-- ref to wektory -->
<!-- block - też prosty wektor i macierz -->

### Łączenie


```r
macierz3 = cbind(macierz1, macierz2)
macierz3
#>              a  b  c
#> [1,] 1 5  9  1  2  3
#> [2,] 2 6 10  4  5  6
#> [3,] 3 7 11  7  8  9
#> [4,] 4 8 12 10 11 12
```


```r
macierz4 = rbind(macierz1, macierz2)
macierz4
#>       a  b  c
#> [1,]  1  5  9
#> [2,]  2  6 10
#> [3,]  3  7 11
#> [4,]  4  8 12
#> [5,]  1  2  3
#> [6,]  4  5  6
#> [7,]  7  8  9
#> [8,] 10 11 12
```

## Ramki danych {#df}

Ramki danych (ang. *data frame*) mają dużo podobieństw z macierzami. 
Są to obiekty dwuwymiarowe, składające się z kolumn i wierszy. 
Główną różnicą pomiędzy macierzą a ramką danych jest to, że pierwsza z nich przyjmuje tylko dane jednego typu, podczas gdy druga może się składać z danych róznych typów.

Ramka danych jest zbudowana z kolumn (wektorów) o równej długości.
<!-- a data frame is a list of equal-length vectors -->
<!-- nested data frames footnote -->

### Tworzenie


```r
ramka1 = data.frame(wek_log = c(TRUE, FALSE, FALSE),
                   wek_cal = c(5L, -7L, 12L), 
                   wek_zmi = c(5.3, -7.1, 1.1), 
                   wek_zna = c("kot", "pies", "nosorożec"),
                   stringsAsFactors = FALSE)
ramka1
#>   wek_log wek_cal wek_zmi   wek_zna
#> 1    TRUE       5     5.3       kot
#> 2   FALSE      -7    -7.1      pies
#> 3   FALSE      12     1.1 nosorożec
```

<!-- problem z `stringsAsFactors` -->

### Podstawowe funkcje


```r
class(ramka1)
#> [1] "data.frame"
```


```r
str(ramka1)
#> 'data.frame':	3 obs. of  4 variables:
#>  $ wek_log: logi  TRUE FALSE FALSE
#>  $ wek_cal: int  5 -7 12
#>  $ wek_zmi: num  5.3 -7.1 1.1
#>  $ wek_zna: chr  "kot" "pies" "nosorożec"
```


```r
ncol(ramka1)
#> [1] 4
```


```r
nrow(ramka1)
#> [1] 3
```


```r
colnames(ramka1)
#> [1] "wek_log" "wek_cal" "wek_zmi" "wek_zna"
```


```r
colnames(ramka1) = c("log", "cal", "zmi", "zna")
ramka1
#>     log cal  zmi       zna
#> 1  TRUE   5  5.3       kot
#> 2 FALSE  -7 -7.1      pies
#> 3 FALSE  12  1.1 nosorożec
colnames(ramka1)
#> [1] "log" "cal" "zmi" "zna"
```

<!-- `rownames()` - info about problems with rownames (block) -->

### Wydzielanie

Do wydzielania elementów z ramki danych może służyć, między innymi, operator `$`, operator `[]`  oraz funkcja `subset()`.

Operator `$` pozwala na wybranie zmiennej (kolumny) na podstawie jej nazwy.


```r
ramka1$zmi
#> [1]  5.3 -7.1  1.1
ramka1$zna
#> [1] "kot"       "pies"      "nosorożec"
```

W przypadku ramek danych operator `[]` wymaga podania dwóch argumentów - jednego dla wierszy (obserwacji) oraz jednego dla kolumn (zmiennych) - `[wiersze, kolumny]`.


```r
ramka1[c(1, 3), c(1, 2)]
#>     log cal
#> 1  TRUE   5
#> 3 FALSE  12
```

Do wydzielania można też wykorzystać operatory logiczne: `==`, `%in%`, `!=`, `>`, `>=`, `<`, `<=`, `&`, `|`.


```r
ramka1[c(1, 3), ramka1$zmi > 0]
#>     log zmi       zna
#> 1  TRUE 5.3       kot
#> 3 FALSE 1.1 nosorożec
```


```r
ramka1[ramka1$zna == "kot", ]
#>    log cal zmi zna
#> 1 TRUE   5 5.3 kot
```

<!-- block == vs = -->


```r
ramka1[ramka1$zna %in% c("kot", "pies"), ]
#>     log cal  zmi  zna
#> 1  TRUE   5  5.3  kot
#> 2 FALSE  -7 -7.1 pies
```


```r
ramka1[ramka1$cal > 6 | ramka1$cal < -6, ]
#>     log cal  zmi       zna
#> 2 FALSE  -7 -7.1      pies
#> 3 FALSE  12  1.1 nosorożec
```

<!-- ref to wektor and matrix -->
<!-- wydzielanie i tworzenie -->

### Łączenie


```r
ramka2 = data.frame(zmi2 = c(4.3, 2.6, 7.4))
ramka2
#>   zmi2
#> 1  4.3
#> 2  2.6
#> 3  7.4
```


```r
cbind(ramka1, ramka2)
#>     log cal  zmi       zna zmi2
#> 1  TRUE   5  5.3       kot  4.3
#> 2 FALSE  -7 -7.1      pies  2.6
#> 3 FALSE  12  1.1 nosorożec  7.4
```


```r
ramka3 = data.frame(log = TRUE, cal = 2L, zmi = 2.3, zna = "żółw")
ramka3
#>    log cal zmi  zna
#> 1 TRUE   2 2.3 żółw
```


```r
rbind(ramka1, ramka3)
#>     log cal  zmi       zna
#> 1  TRUE   5  5.3       kot
#> 2 FALSE  -7 -7.1      pies
#> 3 FALSE  12  1.1 nosorożec
#> 4  TRUE   2  2.3      żółw
```

<!-- info about joins -->
<!-- ref to joins -->

## Listy

### Tworzenie


```r
lista1 = list(c(TRUE, FALSE), 
             c(5L, -7L),
             c(5.3), 
             c("kot", "pies", "nosorożec"))
lista1
#> [[1]]
#> [1]  TRUE FALSE
#> 
#> [[2]]
#> [1]  5 -7
#> 
#> [[3]]
#> [1] 5.3
#> 
#> [[4]]
#> [1] "kot"       "pies"      "nosorożec"
```

<!-- wielopoziomowe listy -->

### Podstawowe funkcje


```r
class(lista1)
#> [1] "list"
```


```r
str(lista1)
#> List of 4
#>  $ : logi [1:2] TRUE FALSE
#>  $ : int [1:2] 5 -7
#>  $ : num 5.3
#>  $ : chr [1:3] "kot" "pies" "nosorożec"
```


```r
length(lista1)
#> [1] 4
```


```r
names(lista1) = c("log", "cal", "zmi", "zna")
lista1
#> $log
#> [1]  TRUE FALSE
#> 
#> $cal
#> [1]  5 -7
#> 
#> $zmi
#> [1] 5.3
#> 
#> $zna
#> [1] "kot"       "pies"      "nosorożec"
names(lista1)
#> [1] "log" "cal" "zmi" "zna"
```

### Łączenie


```r
lista2 = c(lista1, lista1)
lista2
#> $log
#> [1]  TRUE FALSE
#> 
#> $cal
#> [1]  5 -7
#> 
#> $zmi
#> [1] 5.3
#> 
#> $zna
#> [1] "kot"       "pies"      "nosorożec"
#> 
#> $log
#> [1]  TRUE FALSE
#> 
#> $cal
#> [1]  5 -7
#> 
#> $zmi
#> [1] 5.3
#> 
#> $zna
#> [1] "kot"       "pies"      "nosorożec"
```


```r
lista3 = list(lista1, lista1)
lista3
#> [[1]]
#> [[1]]$log
#> [1]  TRUE FALSE
#> 
#> [[1]]$cal
#> [1]  5 -7
#> 
#> [[1]]$zmi
#> [1] 5.3
#> 
#> [[1]]$zna
#> [1] "kot"       "pies"      "nosorożec"
#> 
#> 
#> [[2]]
#> [[2]]$log
#> [1]  TRUE FALSE
#> 
#> [[2]]$cal
#> [1]  5 -7
#> 
#> [[2]]$zmi
#> [1] 5.3
#> 
#> [[2]]$zna
#> [1] "kot"       "pies"      "nosorożec"
```

### Wydzielanie

<!-- `[]` - zawsze lista -->


```r
lista4 = lista1[c(1, 2)]
str(lista4)
#> List of 2
#>  $ log: logi [1:2] TRUE FALSE
#>  $ cal: int [1:2] 5 -7
```

<!-- `[[]]` oraz `$` wyciąganie elementów -->


```r
lista5 = lista1[[c(4)]]
str(lista5)
#>  chr [1:3] "kot" "pies" "nosorożec"
```


```r
lista6 = lista3[[c(2)]]
str(lista6)
#> List of 4
#>  $ log: logi [1:2] TRUE FALSE
#>  $ cal: int [1:2] 5 -7
#>  $ zmi: num 5.3
#>  $ zna: chr [1:3] "kot" "pies" "nosorożec"
```


```r
lista1[c("zmi", "zna")]
#> $zmi
#> [1] 5.3
#> 
#> $zna
#> [1] "kot"       "pies"      "nosorożec"
```


```r
lista1$zna
#> [1] "kot"       "pies"      "nosorożec"
```

<!-- https://adv-r.hadley.nz/subsetting.html#lists-1 -->

## Zamiany klas


```r
macierz1
#>      [,1] [,2] [,3]
#> [1,]    1    5    9
#> [2,]    2    6   10
#> [3,]    3    7   11
#> [4,]    4    8   12
```


```r
ramka_z_m1 = as.data.frame(macierz1)
ramka_z_m1
#>   V1 V2 V3
#> 1  1  5  9
#> 2  2  6 10
#> 3  3  7 11
#> 4  4  8 12
```


```r
class(macierz1)
#> [1] "matrix"
```


```r
class(ramka_z_m1)
#> [1] "data.frame"
```


```r
lista_z_m1 = as.list(macierz1)
lista_z_m1
#> [[1]]
#> [1] 1
#> 
#> [[2]]
#> [1] 2
#> 
#> [[3]]
#> [1] 3
#> 
#> [[4]]
#> [1] 4
#> 
#> [[5]]
#> [1] 5
#> 
#> [[6]]
#> [1] 6
#> 
#> [[7]]
#> [1] 7
#> 
#> [[8]]
#> [1] 8
#> 
#> [[9]]
#> [1] 9
#> 
#> [[10]]
#> [1] 10
#> 
#> [[11]]
#> [1] 11
#> 
#> [[12]]
#> [1] 12
lista_z_r1 = as.list(ramka_z_m1)
lista_z_r1
#> $V1
#> [1] 1 2 3 4
#> 
#> $V2
#> [1] 5 6 7 8
#> 
#> $V3
#> [1]  9 10 11 12
```

`as.vector()`, `as.matrix()`, `as.data.frame()`, `as.list()`

## Inne klasy obiektów


```r
wek_num = c(4, 6, 8)
```


```r
wek_dat = as.Date(c("2019-04-10", "2019-04-12", "2019-04-14"))
```


```r
wek_tkt = c("kot", "pies", "nosorożec")
```


```r
mean(wek_num)
#> [1] 6
```


```r
mean(wek_dat)
#> [1] "2019-04-12"
```


```r
mean(wek_tkt)
#> Warning in mean.default(wek_tkt): argument is not numeric or logical:
#> returning NA
#> [1] NA
```


```r
methods(mean)
#> [1] mean.Date     mean.default  mean.difftime mean.POSIXct  mean.POSIXlt 
#> see '?methods' for accessing help and source code
```

<!-- https://www.njtierney.com/post/2016/11/06/simple-s3-post/ -->
<!-- ... -->
<!-- Istnieje ogromna liczba klas obiektów w R -->
<!-- Każdy może stworzyć swoją własną klasę! -->
<!-- Różne funkcje wymagają różnych klas obiektów -->
<!-- reference?? -->

## Zadania

1) Stwórz trzy nowe macierze - `ma1`, `ma2`, `ma3` - składające się z trzech wierszy i czterech kolumn.
Macierz `ma1` powinna zawierać wartości od 0 do 11, cała macierz `ma2` powinna składać się tylko z wartości 2, a macierz `ma3` powinna zawierać losowe wartości od 1 do 3 (w stworzeniu losowych wartości może pomóc funkcja `sample()`).
2) Wykonaj podstawowe operacje, takie jak dodawanie, odejmowanie, mnożenie i dzielenie używając macierzy `ma1` oraz `ma2`, a następnie macierzy `ma1` i `ma3`.
Co jest efektem tych obliczeń? 
W jaki sposób działania arytmetyczne są wykonywane na macierzach w R?
3) Wydziel tylko pierwszy wiersz i ostatnią kolumnę macierzy `ma1`.
4) Znajdź wartości macierzy `ma3`, które są większe niż 2.
5) Połącz kolumnami macierz `ma1` i macierz `ma3` tworząc nowy obiekt `ma4`
6) Stwórz nową ramkę danych, `ra1`, która składa się z dwóch kolumn i trzech wierszy.
Pierwsza kolumna `data` zawiera datę z dziś, wczoraj i przedwczoraj, a kolumna `miasto` zawiera nazwę miasta w którym się właśnie znajdujesz.
7) Stwórz nową ramkę danych, `ra2`, która również składa się z dwóch kolumn i trzech wierszy.
Kolumna `tmin` zawiera wartości `5.3`, `4.6`, `2.9`, a kolumna `tmax` zawiera wartości `11.1`, `14.6`, `9`.
8) Połącz dwie stworzone ramki danych `ra1` i `ra2` tworząc obiekt `ra3`. 
Używając obiektu `ra3` wylicz średnią temperaturę dla każdego wiersza i wpisz ją w nową kolumnę `tmean`.
9) Zmień nazwę drugiej kolumny w obiekcie `ra3` na `"tmaks"`, a trzeciej na `"tsr"`.
10) Wyświetl tylko te daty dla których średnia temperatura była wyższa niż 8.
11) Stwórz nową listę, `li1`, która zawiera trzy elementy.
Pierwszy element to wektor liczb od 10 do 0, drugi element to obiekt `ma4`, a trzeci element to obiekt `ra3`.
12) Wydziel z tej listy pierwszy element i nazwij go `wektor_l`.
13) Wylicz średnią wartość z kolumny `"tsr"` z trzeciego elementu listy.
14) Zamień obiekt `ramka1` utworzony w tym rozdziale na macierz. 
Co jest efektem zamiany klasy?
