# Złożone obiekty {#zlozone-obiekty}

W rozdziale \@ref(proste-obiekty) omówiono wektory atomowe, które są obiektami jednowymiarowymi zawierającymi tylko jeden typ danych.
Ten rozdział jest poświęcony pozostałymi trzema podstawowymi klasami obiektów w R - macierzami, ramkami danych i listami (sekcje \@ref(macierze), \@ref(df), i \@ref(listy)).

## Macierze

Macierze (ang. *matrix*), podobnie jak wektory, są obiektami homogenicznymi - jedna macierz może przyjmować dane tylko jednego typu.
Od wektorów różnią się jednak tym, że są dwuwymiarowe - wartości ułożone są w kolejnych wierszach i kolumnach.
Macierze są używane do różnorodnych obliczeń matematycznych i statystycznych.
W uproszczeniu można o nich myśleć jako o reprezentacji komputerowej zdjęcia lub mapy.

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">W R istnieją też wielowymiarowe obiekty podobne do macierzy zwane matrycami (ang. *array*).</div>\EndKnitrBlock{rmdinfo}

### Tworzenie

Tworzenie macierzy odbywa się poprzez użycie funkcji `matrix()`, która przyjmuje wartości wektora jako pierwszy argument, a następnie informacje o wymiarach w postaci liczby wierszy (`nrow`) i liczby kolumn (`ncol`).


```r
macierz1 = matrix(1:12, nrow = 4, ncol = 3)
macierz1
#>      [,1] [,2] [,3]
#> [1,]    1    5    9
#> [2,]    2    6   10
#> [3,]    3    7   11
#> [4,]    4    8   12
```

Domyślnie w R wartości wpisywane są do macierzy do kolejnych kolumn startując od lewej strony.
Możliwe jest jednak ustawienie argumentu `byrow = TRUE` co powoduje wpisywanie podanych wartości dla kolejnych wierszy zamiast kolejnych kolumn.


```r
macierz2 = matrix(1:12, nrow = 4, ncol = 3, byrow = TRUE)
macierz2
#>      [,1] [,2] [,3]
#> [1,]    1    2    3
#> [2,]    4    5    6
#> [3,]    7    8    9
#> [4,]   10   11   12
```

### Podstawowe funkcje

Sprawdzenie jakiej klasy jest podany obiekt odbywa się używając funkcji `class()`.


```r
class(macierz2)
#> [1] "matrix" "array"
```

Więcej informacji na temat obiektu można poznać używając funkcji `str()`. 
Jej działanie na macierzy jest bardzo podobne do wyniku na wektorach (zobacz sekcję \@ref(pf-vector)) - wyświetlony zostaje typ obiektu (np. `int`), jego wymiary (np. `[1:4, 1:3]`) i kilka przykładowych wartości (np. `1 4 7 10 2 5 8 11 3 6`).


```r
str(macierz2)
#>  int [1:4, 1:3] 1 4 7 10 2 5 8 11 3 6 ...
```

Macierz może przyjmować tylko jeden typ obiektów, co można sprawdzić używając funkcji `typeof()`.


```r
typeof(macierz2)
#> [1] "integer"
```

Wektory atomowe mają tylko jeden wymiar więc ich długość oznacza liczbę elementów i może być sprawdzona używając funkcji `length()`.
W przypadku macierzy możliwe jest dodatkowo sprawdzenie liczby występujących wierszy (`nrow`) i kolumn (`ncol`).


```r
nrow(macierz2)
#> [1] 4
ncol(macierz2)
#> [1] 3
```

Domyślnie macierze nie zawierają nazw kolumn ani wierszy.


```r
colnames(macierz2)
#> NULL
```

Sprawdzenie czy dodanie nazw kolumn jest jednak możliwe używając funkcji `colnames()`.
Może to pozwolić w przyszłości na wydzielanie konkretnych wartości na podstawie nazw kolumn.


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

Przykładowo, poniżej zostaną wybrane tylko wartości znajdujące się w pierwszy i drugim wierszy oraz pierwszej i trzeciej kolumnie.


```r
macierz2[c(1, 2), c(1, 3)]
#>      a c
#> [1,] 1 3
#> [2,] 4 6
```

Do wydzielania macierzy czy ramek danych też często przydatne jest używanie elementu pustego.
Pozwala on na wybór wszystkich wartości w danym wymiarze.
Na poniższy przykładzie zostały wybrane wiersze jeden i dwa oraz, z uwagi na element pusty, wszystkie kolumny.


```r
macierz2[c(1, 2), ]
#>      a b c
#> [1,] 1 2 3
#> [2,] 4 5 6
```

Element pusty można też zastosować do wybrania wszystkich wierszy.


```r
macierz2[, c(1, 3)]
#>       a  c
#> [1,]  1  3
#> [2,]  4  6
#> [3,]  7  9
#> [4,] 10 12
```

Wszystkie pozostałe sposoby wydzielania opisane dla wektorów w sekcji \@ref(wydzielanie) działają również na macierzach.
Możliwe jest więc używanie wektora logicznego czy nazw kolumn.


```r
macierz2[, c(TRUE, FALSE, TRUE)]
#>       a  c
#> [1,]  1  3
#> [2,]  4  6
#> [3,]  7  9
#> [4,] 10 12
macierz2[, c("a", "c")]
#>       a  c
#> [1,]  1  3
#> [2,]  4  6
#> [3,]  7  9
#> [4,] 10 12
```

### Łączenie

Łączenie wektorów odbywa się używając jednej funkcji `c()`. 
W przypadku macierzy występują jednak dwa wymiary - możliwe jest połączenie macierzy wierszami lub kolumnami.
W efekcie istnieją do tego dwie oddzielne funkcje `rbind()` i `cbind()`.

Pierwsza z nich łączy macierze wierszami, a liczba kolumn pozostaje niezmieniona.


```r
macierz3 = rbind(macierz1, macierz2)
macierz3
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

Druga dokleja obiekty kolumnami bez zmiany liczby wierszy.


```r
macierz4 = cbind(macierz1, macierz2)
macierz4
#>              a  b  c
#> [1,] 1 5  9  1  2  3
#> [2,] 2 6 10  4  5  6
#> [3,] 3 7 11  7  8  9
#> [4,] 4 8 12 10 11 12
```

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">W przypadku, gdy chcemy połączyć kilka wektorów różnych typów działają dokładnie takie same reguły jak w przypadku wektorów atomowych (sekcja \@ref(lpto-vector)).</div>\EndKnitrBlock{rmdinfo}

## Ramki danych {#df}

Ramki danych (ang. *data frame*) mają dużo podobieństw z macierzami. 
Są to obiekty dwuwymiarowe, składające się z kolumn i wierszy. 
Główną różnicą pomiędzy macierzą a ramką danych jest to, że pierwsza z nich przyjmuje tylko dane jednego typu, podczas gdy druga może się składać z danych rożnych typów.

Ramka danych jest zbudowana z kolumn (wektorów) o równej długości.
<!-- a data frame is a list of equal-length vectors -->
Ten typ obiektu jest głównie wykorzystywany do różnorodnej analizy danych. 
Ramki danych przypominają w swojej strukturze arkusze kalkulacyjne czy bazy danych.
<!-- nested data frames footnote -->

### Tworzenie

Stworzenie nowej ramki danych możliwe jest używając funkcji `data.frame()`, w której podawane są nazwy kolejnych kolumn (np. `wek_log`) oraz ich wartości (np. `c(TRUE, FALSE, FALSE)`).


```r
ramka1 = data.frame(wek_log = c(TRUE, FALSE, FALSE),
                    wek_cal = c(5L, -7L, 12L), 
                    wek_zmi = c(5.3, -7.1, 1.1), 
                    wek_zna = c("kot", "pies", "nosorożec"))
ramka1
#>   wek_log wek_cal wek_zmi   wek_zna
#> 1    TRUE       5     5.3       kot
#> 2   FALSE      -7    -7.1      pies
#> 3   FALSE      12     1.1 nosorożec
```

W powyższym przykładzie, `ramka1` składa się z czterech kolumn o długości trzy. 
Każda z tych kolumn ma inny typ - logiczny, liczby całkowitej, liczby zmiennoprzecinkowej oraz znakowy.

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">Obiekty klasy ramka danych są też zazwyczaj wynikiem wczytywania zewnętrznych plików do R, np. w formacie `.csv` czy `.xlsx`.
Więcej informacji na ten temat można znaleźć w rozdziale \@ref(io).</div>\EndKnitrBlock{rmdinfo}

### Podstawowe funkcje

Oficjalnie klasa ramki danych jest określana jako `data.frame`.


```r
class(ramka1)
#> [1] "data.frame"
```

Sprawdzenie struktury ramki danych pozwala na szybkie poznanie kilku rożnych cech wejściowego obiektu.
Pierwszą informacją jest klasa obiektu (`data.frame`), liczba wierszy (`3 obs.` - trzy obserwacje) i liczba kolumn (`4 variables` - cztery zmienne).
Następnie, dla kolejnych kolumn są określane ich nazwy, typy danych oraz przykładowe wartości.


```r
str(ramka1)
#> 'data.frame':	3 obs. of  4 variables:
#>  $ wek_log: logi  TRUE FALSE FALSE
#>  $ wek_cal: int  5 -7 12
#>  $ wek_zmi: num  5.3 -7.1 1.1
#>  $ wek_zna: chr  "kot" "pies" "nosorożec"
```

Podobnie jak w przypadku macierzy, ramki danych mają dwa wymiary, których długość można sprawdzić używając funkcji `nrow` i `ncol`.


```r
nrow(ramka1)
#> [1] 3
ncol(ramka1)
#> [1] 4
```

W przeciwieństwie jednak do macierzy, ramki danych zawsze posiadają nazwy kolumn.


```r
colnames(ramka1)
#> [1] "wek_log" "wek_cal" "wek_zmi" "wek_zna"
```

Ich zmiana również jest możliwa używając funkcji `colnames()`.


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

### Wydzielanie {#wydzielanie-df}

Do wydzielania elementów z ramki danych może służyć kilka narzędzi, między innymi, operator `$`, operator `[]`  oraz funkcja `subset()`.

Operator `$` pozwala na wybranie zmiennej (kolumny) na podstawie jej nazwy.


```r
ramka1$zmi
#> [1]  5.3 -7.1  1.1
ramka1$zna
#> [1] "kot"       "pies"      "nosorożec"
```

W efekcie otrzymywany jest jednak inna klasa - w powyższych przykładach są to wektory.

W przypadku ramek danych operator `[]` wymaga podania dwóch argumentów - jednego dla wierszy (obserwacji) oraz jednego dla kolumn (zmiennych) - `[wiersze, kolumny]`.


```r
ramka1[c(1, 3), c(1, 2)]
#>     log cal
#> 1  TRUE   5
#> 3 FALSE  12
```

Do wydzielania można też wykorzystać operatory logiczne: `==`, `%in%`, `!=`, `>`, `>=`, `<`, `<=`, `&`, `|`.


```r
ramka1[ramka1$zmi > 0, c(1, 3)]
#>     log zmi
#> 1  TRUE 5.3
#> 3 FALSE 1.1
```

Powyżej wybrano tylko pierwszą i trzecią kolumnę oraz wiersze, dla których kolumna `zmi` miała wartość wyższą niż 0.

Zapytania też można łączyć, np. wybierając tylko te wiersze gdzie wartość `cal` jest wyższa niż 6 lub niższa niż -6.


```r
ramka1[ramka1$cal > 6 | ramka1$cal < -6, ]
#>     log cal  zmi       zna
#> 2 FALSE  -7 -7.1      pies
#> 3 FALSE  12  1.1 nosorożec
```

Poniżej wybrano natomiast wszystkie kolumny, ale tylko wiersz gdzie zmienna `zna` przyjęła wartość `"kot"`.


```r
ramka1[ramka1$zna == "kot", ]
#>    log cal zmi zna
#> 1 TRUE   5 5.3 kot
```

Aby wybrać więcej niż jedną zmienną należy użyć funkcji `%in%`.


```r
ramka1[ramka1$zna %in% c("kot", "pies"), ]
#>     log cal  zmi  zna
#> 1  TRUE   5  5.3  kot
#> 2 FALSE  -7 -7.1 pies
```

Alternatywą do wydzielania ramek danych na podstawie zapytania logicznego jest użycie funkcji `subset()`.
Używając tej funkcji powyższe zapytanie można przestawić jako:


```r
subset(ramka1, zna %in% c("kot", "pies"))
#>     log cal  zmi  zna
#> 1  TRUE   5  5.3  kot
#> 2 FALSE  -7 -7.1 pies
```

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">Podobnie jak w przypadku wektorów (sekcje \@ref(wip-vector) i \@ref(mo-vector)), wydzielanie ramek danych może służyć do wyświetlenia wybranych wartości, ale też ich wydzielenia i przypisania oraz modyfikowania.</div>\EndKnitrBlock{rmdinfo}

### Łączenie

Łączenie ramek danych przypomina łączenie macierzy używając funkcji `rbind()` i `cbind()`.
Jednocześnie należy pamiętać, że łączenie wierszy (`rbind()`) wymaga posiadania kolumn o tych samych nazwach w obu obiektach.


```r
ramka2 = data.frame(log = TRUE, cal = 2L, zmi = 2.3, zna = "żółw")
ramka2
#>    log cal zmi  zna
#> 1 TRUE   2 2.3 żółw

rbind(ramka1, ramka2)
#>     log cal  zmi       zna
#> 1  TRUE   5  5.3       kot
#> 2 FALSE  -7 -7.1      pies
#> 3 FALSE  12  1.1 nosorożec
#> 4  TRUE   2  2.3      żółw
```

Ograniczeniem łącznia kolumn jest posiadanie tej samej długości każdej kolumny.


```r
ramka3 = data.frame(zmi2 = c(4.3, 2.6, 7.4))
ramka3
#>   zmi2
#> 1  4.3
#> 2  2.6
#> 3  7.4

cbind(ramka1, ramka3)
#>     log cal  zmi       zna zmi2
#> 1  TRUE   5  5.3       kot  4.3
#> 2 FALSE  -7 -7.1      pies  2.6
#> 3 FALSE  12  1.1 nosorożec  7.4
```

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">Funkcje `rbind()` i `cbind()` łączą obiekty nie zmieniając kolejności występujących w nich wartości.
Bardziej zaawansowanymi sposobami łączenia ramek danych są różnorodne operacje łączenia (ang. *joins*), np. `left_join()` czy `inner_join()` z pakietu **dplyr**.
Więcej na ten temat można znaleźć w rozdziale ["Relational data"](https://r4ds.had.co.nz/relational-data.html) książki Advanced R [@wickham2014advanced].</div>\EndKnitrBlock{rmdinfo}

## Listy

Ostatnią podstawową klasą obiektów w R są listy (ang. *list*).
Ta klasa pozwala na przechowywanie obiektów o różnych typach i różnej długości.

### Tworzenie

Do tworzenia list służy funkcja `list()`, która przyjmuje jako argumenty kolejne obiekty, które mają się w niej znaleźć.


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

Przykładowa powyższa lista składa się z czterech elementów, o długości jeden, dwa lub trzy,  i o różnorodnych typach danych.

Inną ważną właściwością list jest możliwość ich zagnieżdżania - jedna lista może przechowywać kolejną, która jest w stanie przechowywać następną... Z tego powodu listy są czasami nazywane wektorami rekurencyjnymi.


```r
zlozona_lista1 = list(list(list(lista1)))
str(zlozona_lista1)
#> List of 1
#>  $ :List of 1
#>   ..$ :List of 1
#>   .. ..$ :List of 4
#>   .. .. ..$ : logi [1:2] TRUE FALSE
#>   .. .. ..$ : int [1:2] 5 -7
#>   .. .. ..$ : num 5.3
#>   .. .. ..$ : chr [1:3] "kot" "pies" "nosorożec"
```

### Podstawowe funkcje

Listy są przedstawiane jako klasa `list`.


```r
class(lista1)
#> [1] "list"
```

W ich wypadku funkcja `str()` wyświetla klasę (`List`), liczbę elementów w liście (`4`) oraz wypisuje kolejne elementy listy, ich typy, wymiary i przykładowe wartości.


```r
str(lista1)
#> List of 4
#>  $ : logi [1:2] TRUE FALSE
#>  $ : int [1:2] 5 -7
#>  $ : num 5.3
#>  $ : chr [1:3] "kot" "pies" "nosorożec"
```

Listy nie zawierają wierszy czy kolumn, dlatego do sprawdzenia liczby elementów w liście służy tylko funkcja `length()`.


```r
length(lista1)
#> [1] 4
```

Kolejne elementy znajdujące się w liście mogą przyjmować wybrane nazwy.
Można je sprawdzić czy zmienić używając funkcji `names()`.


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

Łączenie list może odbywać się na dwa podstawowe sposoby.
W pierwszym, używając funkcji `c()` następuje dołączenie elementów jednej listy do drugiej.


```r
lista2 = c(lista1, lista1)
str(lista2)
#> List of 8
#>  $ log: logi [1:2] TRUE FALSE
#>  $ cal: int [1:2] 5 -7
#>  $ zmi: num 5.3
#>  $ zna: chr [1:3] "kot" "pies" "nosorożec"
#>  $ log: logi [1:2] TRUE FALSE
#>  $ cal: int [1:2] 5 -7
#>  $ zmi: num 5.3
#>  $ zna: chr [1:3] "kot" "pies" "nosorożec"
```

Efektem nadal jest jedna lista, ale składająca się z większej liczby elementów.

Drugim sposobem jest użycie funkcji `list()`.
W tym przypadku tworzona jest nowa, nadrzędna lista, która zawiera dwie wcześniejsze listy.


```r
lista3 = list(lista1, lista1)
str(lista3)
#> List of 2
#>  $ :List of 4
#>   ..$ log: logi [1:2] TRUE FALSE
#>   ..$ cal: int [1:2] 5 -7
#>   ..$ zmi: num 5.3
#>   ..$ zna: chr [1:3] "kot" "pies" "nosorożec"
#>  $ :List of 4
#>   ..$ log: logi [1:2] TRUE FALSE
#>   ..$ cal: int [1:2] 5 -7
#>   ..$ zmi: num 5.3
#>   ..$ zna: chr [1:3] "kot" "pies" "nosorożec"
```

### Wydzielanie {#wydzielanie-list}

Wydzielanie list może mieć miejsce używając jednego z trzech operatorów - `[]`, `[[]]`, oraz `$`.

Operator `[]` wydziela wybrane elementy z listy, ale jednocześnie dalej zwraca w wyniku obiekt klasy lista.
Wyobraź sobie, że masz torbę zawierający cztery przedmioty (*listę zawierającą cztery elementy*) i chcesz zostawić w plecaku tylko pierwszy i drugi z nich.


```r
lista4 = lista1[c(1, 2)]
lista4
#> $log
#> [1]  TRUE FALSE
#> 
#> $cal
#> [1]  5 -7
str(lista4)
#> List of 2
#>  $ log: logi [1:2] TRUE FALSE
#>  $ cal: int [1:2] 5 -7
```


W efekcie wynikowy obiekt nadal jest listą, ale z mniejszą liczbą elementów.

Do wydobycia wartości z listy służą operatory `[[]]` oraz `$`.
Pierwszy z nich wydobywa wartości na podstawie ich położenia i w efekcie otrzymywany jest obiekt znajdujący się wewnątrz listy. 
W poniższym przykładzie, wydzielany jest czwarty element z obiektu `lista1`.


```r
lista5 = lista1[[4]]
lista5
#> [1] "kot"       "pies"      "nosorożec"
str(lista5)
#>  chr [1:3] "kot" "pies" "nosorożec"
```

Czwarty element w `lista1` jest wektorem znakowym o długości trzy.
W przypadku, gdy wybrany element listy jest innej klasy to jest on również zwracany.
Poniżej drugi element `listy3` jest również listą - wyobraź to sobie jako wyciągnięcie jednej torby, która znajduje się wewnątrz innej.


```r
lista6 = lista3[[2]]
lista6
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
str(lista6)
#> List of 4
#>  $ log: logi [1:2] TRUE FALSE
#>  $ cal: int [1:2] 5 -7
#>  $ zmi: num 5.3
#>  $ zna: chr [1:3] "kot" "pies" "nosorożec"
```

Ostatni operator, `$`, wydziela wartości na podstawie ich nazw.


```r
lista1$zna
#> [1] "kot"       "pies"      "nosorożec"
```

## Zmiany klas

R ma też szereg pomocniczych służących do zmian istniejących klas. 
Te funkcje rozpoczynają się od `as.` a następnie zawierają nazwę klasy do której chcemy przetworzyć wejściowy obiekt, np. `as.vector()`, `as.matrix()`, `as.data.frame()`, `as.list()`.

Działanie tych funkcji jednak jest bardzo różne w zależności o klasy wejściowego obiektu.
Zobaczmy to na przykładzie obiektu `macierz1`.


```r
macierz1
#>      [,1] [,2] [,3]
#> [1,]    1    5    9
#> [2,]    2    6   10
#> [3,]    3    7   11
#> [4,]    4    8   12
class(macierz1)
#> [1] "matrix" "array"
```

Jego zamiana na ramkę danych odbywa się używając funkcji `as.data.frame()`.
W efekcie nowy obiekt ma takie same wymiary (cztery wiersze i trzy kolumny) oraz te same wartości.
Zauważalną zmianą jest jednak automatyczne dodane nazw wierszy (`1`, `2`, `3`, `4`) i nazw kolumn (`V1`, `V2`, `V3`).


```r
ramka_z_m1 = as.data.frame(macierz1)
ramka_z_m1
#>   V1 V2 V3
#> 1  1  5  9
#> 2  2  6 10
#> 3  3  7 11
#> 4  4  8 12
class(ramka_z_m1)
#> [1] "data.frame"
```

Zupełnie inny efekt będzie miało natomiast zamienienie macierzy i ramki danych na listy.


```r
lista_z_m1 = as.list(macierz1)
lista_z_r1 = as.list(ramka_z_m1)
```

W pierwszym przypadku powstanie lista zawierająca dwanaście elementów.


```r
str(lista_z_m1)
#> List of 12
#>  $ : int 1
#>  $ : int 2
#>  $ : int 3
#>  $ : int 4
#>  $ : int 5
#>  $ : int 6
#>  $ : int 7
#>  $ : int 8
#>  $ : int 9
#>  $ : int 10
#>  $ : int 11
#>  $ : int 12
```

W drugim przypadku efektem będzie lista składająca się z trzech wektorów, które reprezentują kolejne kolumny z poprzedniej ramki danych.


```r
str(lista_z_r1)
#> List of 3
#>  $ V1: int [1:4] 1 2 3 4
#>  $ V2: int [1:4] 5 6 7 8
#>  $ V3: int [1:4] 9 10 11 12
```

## Inne klasy obiektów {#inne-klasy}

W tym oraz \@ref(proste-obiekty) rozdziale zostały wymienione i opisane cztery podstawowe klasy obiektów w R - wektory atomowe, macierze, natomiast listy i ramki danych.
R zawiera jednak znacznie więcej klas obiektów, a co więcej - każda osoba może stworzyć swoją własną klasę obiektów (sekcja \@ref(oop)).

Poniżej zostały stworzone trzy nowe wektory - znakowy (`wek_tkt`), numeryczny (`wek_num`) i dat (`wek_dat`).


```r
wek_tkt = c("kot", "pies", "nosorożec")
wek_num = c(4, 6, 8)
wek_dat = as.Date(c("2019-04-10", "2019-04-12", "2019-04-14"))
```

Czy można na nich wyliczyć średnią w ten sam sposób?
Raczej nie - wyliczenie średniej z tekstu nie jest jednoznacznie możliwe, wyliczenie średniej z wartości numerycznych powinno dać wartość numeryczną, a wyliczenie średniej z dat - również datę.


```r
mean(wek_tkt)
#> Warning in mean.default(wek_tkt): argument is not
#> numeric or logical: returning NA
#> [1] NA
mean(wek_num)
#> [1] 6
mean(wek_dat)
#> [1] "2019-04-12"
```

Powyższe wyniki są poprawne, ale każdy z nich zwraca inny rodzaj wyniku. 
Jest to możliwe dzięki tzw. metodom (ang. *methods*).
Metoda to sposób w jaki zachowuje się funkcja w zależności od tego jakiej klasy będzie obiekt wejściowy.


```r
methods(mean)
#> [1] mean.Date     mean.default  mean.difftime
#> [4] mean.POSIXct  mean.POSIXlt  mean.quosure*
#> see '?methods' for accessing help and source code
```

Przykładowo, funkcja `mean()` ma kilka metod:

- `.Date` - obsługującą daty
- `.difftime` - obsługującą czas trwania
- `.POSIXct` oraz `.POSIXlt` - obsługujące czas
- `.default` - domyślna metoda

W momencie, gdy funkcja otrzyma jakiś obiekt, sprawdzana jest jego klasa i jeżeli istnieje metoda dla tego obiektu to wówczas jest ona używana.
Natomiast w sytuacji, gdy dla danej klasy obiektu nie ma istniejącej metody, używana jest domyślna metoda (`.default`).

Jak widać w powyższym przykładzie, nowe klasy obiektów oraz nowe metody są tworzone, aby ułatwić pracę na innych niż domyślne strukturach danych.

## Zadania {#zad7}

<!-- dodaj zadania data science (aka dataset) -->

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
9) Zmień nazwę kolumny zawierającej wartości temperatury maksymalnej w obiekcie `ra3` na `"tmaks"`, a kolumny zawierającej wartości temperatury średniej na `"tsr"`.
10) Wyświetl tylko te daty dla których średnia temperatura była wyższa niż 8.
11) Stwórz nową listę, `li1`, która zawiera trzy elementy.
Pierwszy element to wektor liczb od 10 do 0, drugi element to obiekt `ma4`, a trzeci element to obiekt `ra3`.
12) Wydziel z tej listy pierwszy element i nazwij go `wektor_l`.
13) Wylicz średnią wartość z kolumny `"tsr"` z trzeciego elementu listy.
14) Zamień obiekt `ramka1` utworzony w tym rozdziale na macierz. 
Co jest efektem zamiany klasy?



