
# Złożone obiekty {#zlozone-obiekty}

## Macierze

Macierze (ang. *matrix*), podobnie jak wektory, są obiektami homogenicznymi - jedna macierz może przyjmować dane tylko jednego typu.
<!-- ref to arrays -->

### Tworzenie


```r
macierz1 = matrix(1:12, ncol = 3, nrow = 4)
macierz1
#>      [,1] [,2] [,3]
#> [1,]    1    5    9
#> [2,]    2    6   10
#> [3,]    3    7   11
#> [4,]    4    8   12
```


```r
macierz2 = matrix(1:12, ncol = 3, nrow = 4, byrow = TRUE)
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

Podobnie jak w przypadku wektorów (\@ref(proste-obiekty)), macierze można wydzielać używając operatora `[]`.
W tym wypadku odbywa się to jednak na w oparciu o dwa indeksy - jeden dla wiersza, drugi dla kolumny - `[wiersz, kolumna]`.


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

## Ramki danych

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

## Własne klasy

<!-- ... -->
<!-- Istnieje ogromna liczba klas obiektów w R -->
<!-- Każdy może stworzyć swoją własną klasę! -->
<!-- Różne funkcje wymagają różnych klas obiektów -->

## Zadania
