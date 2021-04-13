# Proste obiekty {#proste-obiekty}

Obiekty w R można podzielić na proste (homogeniczne) i złożone (heterogeniczne). 
Do podstawowych prostych obiektów należą wektory atomowe (ang. *vector*) i macierze (ang. *matrix*), natomiast listy (ang. *list*) i ramki danych (ang. *data frame*) to obiekty złożone.

W tym rozdziale skupimy się na wektorach atomowych, dla uproszczenia nazywanych dalej po prostu wektorami.
Pozostałe podstawowe typy obiektów są omówione w rozdziale \@ref(zlozone-obiekty).
Więcej informacji na temat podstawowych typów obiektów można znaleźć w rozdziale ["Vectors"](https://adv-r.hadley.nz/vectors-chap.html) książki Advanced R [@wickham2014advanced].

## Wektory 

Wektory są podstawowymi elementami, które pozwalają na budowanie bardziej złożonych rodzajów obiektów.
Wektor może przyjmować jeden z czterech podstawowych typów^[Istnieją też dwa kolejne podstawowe typy wektorów, złożone (ang. *complex*) oraz surowe (ang. *raw*) ale są one bardzo rzadko używane.]:

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

Wektory przedstawiające liczby stałoprzecinkowe i zmiennoprzecinkowe są często łączone i wspólnie określane jako wektory numeryczne (ang. *numeric*).

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">Wiele języków programowania posiada zmienne skalarne (tzw. skalary), czyli takie które mogą przyjmować tylko jedną wartość.
W R one nie występują, zamiast nich stosowane są wektory o długości jeden.</div>\EndKnitrBlock{rmdinfo}

Dodatkowo, istnieje wiele dodatkowych, rzadziej spotykanych typów wektorów - czynnikowy (ang. *factor*), dat (ang. *date*) i czasu (ang. *date-time*) (sekcje \@ref(fac), \@ref(ate) i \@ref(ime)).

## Właściwości wektorów

Każdy wektor ma trzy właściwości - typ, długość i atrybuty.
Typ może być sprawdzony używając funkcji `typeof()`.


```r
# typ
typeof(wek_zmi)
#> [1] "double"
```

Celem funkcji `length()` jest sprawdzenie długości wektora, czyli tego z ilu wartości (elementów) się on składa.


```r
# długość
length(wek_zmi)
#> [1] 2
```

Atrybuty pozwalają na dodawanie nowych informacji do wektorów atomowych, a w efekcie dają też możliwość tworzenia bardziej złożonych struktur (rozdział \@ref(zlozone-obiekty)).


```r
# atrybuty
attributes(wek_zmi)
#> NULL
```

## Podstawowe funkcje {#pf-vector}

Z racji bycia podstawowym typem obiektu w R, wektory są używane w bardzo dużej liczbie funkcji.
Kilka z podstawowych, często przydatnych funkcji jest podana i wyjaśniona poniżej.

Funkcja `str()` ma na celu wyświetlenie **str**uktury danych.
W przypadku wektorów oznacza to skrót od nazwy typu danych (`logi` - logiczny, `int` - stałoprzecinkowy, `num` - zmiennoprzecinkowy (numeryczny), `chr` - tekstowy), jego długość (np. `[1:2]` oznacza, że wektor ma dwa elementy), oraz kilka przykładowych wartości tego wektora.
<!-- metody -->


```r
str(wek_cal)
#>  int [1:2] 5 -7
```

Funkcja `names()` wyświetla nazwy przypisane kolejnym elementom wektora.


```r
names(wek_zna)
#> NULL
```

W powyższym przypadku wektor `wek_zna` nie miał żadnych nazw, w efekcie funkcja `names()` zwróciła `NULL` (więcej informacji na temat `NULL` można znaleźć w sekcji \@ref(na)).
Oprócz wyświetlania nazw, funkcja `names()` daje też możliwość ich nadania.


```r
names(wek_zna) = c("a", "b")
wek_zna
#>      a      b 
#>  "kot" "pies"
names(wek_zna)
#> [1] "a" "b"
```

Funkcja `seq` ma na celu generowanie ciągów liczbowych^[Uproszczeniem funkcji `seq` jest operator `:` (np. `1:10`). W jego przypadku wartości zawsze zmieniają się o jeden.].
Pierwszym jego argumentem jest `from` czyli początkowa liczba w ciągu a drugi argument `to` oznacza maksymalną możliwą liczbę w ciągu.
Obie te liczby mogą być wektorami o długości jeden.
Dodatkowo ta funkcja wymaga zdefiniowania jeszcze jednego argumentu, np. `by` lub `length.out`.
Argument `by` określa co ile wartości w ciągu mają rosnąć od wartości początkowej.


```r
seq(1, 365, by = 7)
#>  [1]   1   8  15  22  29  36  43  50  57  64  71  78  85
#> [14]  92  99 106 113 120 127 134 141 148 155 162 169 176
#> [27] 183 190 197 204 211 218 225 232 239 246 253 260 267
#> [40] 274 281 288 295 302 309 316 323 330 337 344 351 358
#> [53] 365
```

Alternatywnie, argument `length.out` ustala jakiej długości ma być wynikowy ciąg, a na podstawie tego tworzone są wartości w równych odstępach.


```r
seq(1, 365, length.out = 10)
#>  [1]   1.0  41.4  81.9 122.3 162.8 203.2 243.7 284.1
#>  [9] 324.6 365.0
```

Funkcja `rep` służy powielaniu zadanej wartości podaną liczbę razy.
W poniższym przykładzie, wartość 11 jest powielona 4 razy.


```r
rep(11, 4)
#> [1] 11 11 11 11
```

Ta funkcja działa też na różnego typu wektorach - logicznych, numerycznych, czy tekstowych.


```r
rep(wek_zna, 4)
#>      a      b      a      b      a      b      a      b 
#>  "kot" "pies"  "kot" "pies"  "kot" "pies"  "kot" "pies"
```

<!-- operatory statytyczne -->

## Działania na wektorach {#dzialania-na-wektorach}

Wiele podstawowych operacji w R jest zwektoryzowana. 
Przykładowo, możliwe jest pomnożenie kolejnych elementów jednego wektora przez kolejne elementy drugiego wektora.


```r
a = c(1, 2, 3)
b = c(3, 5, 10)
a * b
#> [1]  3 10 30
```

Kod zapisany w powyższy sposób zajmuje niewiele miejsca i jest łatwy do odczytania.
Alternatywnie można by ten problem rozbić na podelementy i je wymnożyć.


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
Jest jeszcze trzecia możliwość -- użycie pętli (rozdział \@ref(petle)).


```r
y = numeric(length = 3)
for (i in 1:3){
  y[i] = a[i] * b[i]
}
y
#> [1]  3 10 30
```

Stworzony tak kod zajmuje mniej miejsca, ale nadal nie jest on bardzo łatwy do szybkiego zrozumienia.

Wektoryzacja ma też inną zaletę - obliczenia wykonywane w ten sposób są szybkie.
W przypadku stosowania niektórych operacji, np. mnożenia czy dodawania, R wykorzystuje w tle (bez wiedzy użytkownika) zoptymalizowane funkcje zapisane w języku C lub Fortran.

W przypadku, gdy dwa wektory mają różną długość, wówczas następuje proces nazwany recyklingiem (ang. *recycling*) - elementy krótszego wektora są powtarzane aż do momentu gdy osiągnie on taką samą długość jak ten dłuższy, a dopiero później następuje wykonanie wybranego działania.
W takiej sytuacji pojawi się też poniższy komunikat ostrzeżenia.


```r
a = c(1, 2, 3)
d = c(3, 5)
a * d
#> Warning in a * d: longer object length is not a multiple
#> of shorter object length
#> [1]  3 10  9
```

Więcej informacji na temat wektoryzowania kodu można znaleźć w rozdziale \@ref(petle).

## Brakujące wartości {#na}

Wyobraź sobie, że wykonujesz codziennie o 12:00 pomiar temperatury.


```r
temperatura = c(8.2, 10.3, 12.0)
```

Czwartego dnia twój termometr się popsuł i nie można było wykonać pomiaru.
Co należałoby w takim razie zrobić?
Można by pominąć ten pomiar, naprawić termometr i wykonać pomiar kolejnego dnia. 
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

Zachowanie wartości `NA` (ang. *Not Available*) jest bardzo intuicyjne.
Przykładowo, jeżeli nie znamy jakiejś wartości to jeżeli dodamy do niej 2 to również nie wiemy jaki mamy wynik.


```r
NA + 2
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
`NaN` (ang. *Not a Number*) oznacza wartość, która nie jest zdefiniowaną lub nie może być reprezentowana w inny sposób, przykładowo `0/0`.
`Inf` i `-Inf` (ang. *Infinity*) jest wynikiem obliczeń, które dały bardzo dużą wartość dodatnią lub ujemną, przykładowo `9^999`.</div>\EndKnitrBlock{rmdinfo}

## Wydzielanie 

R posiada trzy podstawowe operatory wydzielania (ang. *subsetting*) - `[]`, `[[]]` oraz `$`, które działają w różny sposób w zależności od tego czy wydzielamy wektory, macierze, ramki danych czy listy.
W tym rozdziale skupimy się na wydzielaniu elementów z wektora przy użyciu operatora `[]`.
Więcej na temat wydzielania innych obiektów można znaleźć w rozdziale \@ref(zlozone-obiekty).

Wydzielanie wektorów używając operatora `[]` może odbywać się używając jednego z poniższych zapytań:

1. Na podstawie pozycji.
2. Na podstawie wektora logicznego.
3. Na podstawie nazwy.
4. Używając elementu pustego.
5. Używając zera.

<!-- na podstawie pozycji -->
W przypadku wydzielania na podstawie pozycji konieczne jest podanie wektora, który wskazuje numer elementów, które mają zostać wybrane.


```r
temperatura[c(1, 3)]
#> [1]  8.2 12.0
```

Alternatywnie, możliwe jest też użycie znaku minus (`-`) przed definicją pozycji. 
Wówczas wybrane zostaną wszystkie elementy wektora oprócz tych w podanych pozycjach.


```r
temperatura[-c(2, 4)]
#> [1]  8.2 12.0
```

<!-- na podstawie wektora logicznego -->
Drugim sposobem jest użycie wektora logicznego.
W takim przypadku elementy określone jako prawda (`TRUE`) zostają wybrane.


```r
temperatura[c(TRUE, FALSE, TRUE, FALSE)]
#> [1]  8.2 12.0
```

Możliwe jest też stworzenie wektora logicznego poprzez wykonanie prostego zapytania.
Poniżej wybrano tylko te elementy wektora `temperatura`, gdzie wartość w wektorze `temperatura` była wyższa niż 10.


```r
temperatura[temperatura > 10]
#> [1] 10.3 12.0   NA
```

<!-- na podstawie nazwy -->
Wydzielanie na podstawie nazwy wymaga aby elementy w wektorze były nazwane.


```r
names(temperatura) = c("Poniedziałek", "Wtorek", "Środa", "Czwartek")
temperatura
#> Poniedziałek       Wtorek        Środa     Czwartek 
#>          8.2         10.3         12.0           NA
```

Następnie wybór elementów odbywa się poprzez podanie nazw wybranych elementów.


```r
temperatura[c("Wtorek", "Czwartek")]
#>   Wtorek Czwartek 
#>     10.3       NA
```

<!-- nic -->
Czwartą metodą jest zapytanie w oparciu o pusty element.
W przypadku prostych obiektów, efektem takiego wydzielania jest oryginalny wektor.
Ta metoda jest jednak bardzo użyteczna dla obiektów złożonych, takich jak macierze czy ramki danych (rozdział \@ref(zlozone-obiekty)).


```r
temperatura[]
#> Poniedziałek       Wtorek        Środa     Czwartek 
#>          8.2         10.3         12.0           NA
```

<!-- zero -->
Ostatnią metodą jest użycie zera. 
W efekcie zostanie zwrócony wektor o długości zero, ale zachowujący oryginalne właściwości, jak np. bycie wektorem numerycznym (`numeric`) poniżej.
Takie zachowanie może być przydatne podczas tworzenia nowych obiektów w oparciu o już istniejące.


```r
temperatura[0]
#> named numeric(0)
```

## Wydzielanie i przypisanie {#wip-vector}

Wydzielanie elementów może mieć kilka dodatkowych zastosowań oprócz wyświetlania wybranych wartości.
Kolejną możliwością jest tworzenie nowych obiektów na podstawie wydzieleń.
W takich sytuacjach działa każda z metod wyjaśnionych w powyższej sekcji, np. wydzielenie przez nazwę.


```r
temperatura_pon = temperatura["Poniedziałek"]
temperatura_pon
#> Poniedziałek 
#>          8.2
```

Dodatkowo, wydzielanie może przyjmować bardziej złożoną postać.
Poniżej nastąpiło stworzenie nowego obiektu `temperatura_10` składającego się z wszystkich elementów wektora `temperatura`, których wartość jest wyższa od 10 i nie jest `NA`.


```r
temperatura_10 = temperatura[temperatura > 10 & !is.na(temperatura)]
temperatura_10
#> Wtorek  Środa 
#>   10.3   12.0
```

## Modyfikowanie obiektów {#mo-vector}

Trzecim zastosowaniem wydzielania jest modyfikowanie obiektów.
Poprzez wydzielenie możliwe jest wskazanie, które elementy wektora mają być zamienione i na jakie wartości.
Przykładowo, wektor `temperatura` zawiera cztery wartości nazwane kolejnymi dniami tygodnia.
W tym wektorze `"Czwartek"` posiada wartość brakującą `NA`.


```r
temperatura
#> Poniedziałek       Wtorek        Środa     Czwartek 
#>          8.2         10.3         12.0           NA
temperatura["Czwartek"]
#> Czwartek 
#>       NA
```

Aby zamienić wartość tego elementu należy go wydzielić a następnie przypisać temu elementowi nową wartość.
Efektem jest trwała zmiana obiektu `temperatura`.


```r
temperatura["Czwartek"] = 9.1
temperatura["Czwartek"]
#> Czwartek 
#>      9.1
temperatura
#> Poniedziałek       Wtorek        Środa     Czwartek 
#>          8.2         10.3         12.0          9.1
```

## Łączenie podstawowych typów obiektów {#lpto-vector}

<!-- tekst -->
Właściwością wektora jest to, że może on przyjmować tylko jeden typ.
Przykładowo poniżej wyświetlony jest wektor logiczny przyjmujący wartość `FALSE`.


```r
c(FALSE)
#> [1] FALSE
```

Co stanie się, gdy będziemy chcieli taki wektor połączyć z wektorem innego typu, np. numerycznego czy tekstowego?
Próba stworzenia obiektu składającego się z wielu typów spowoduje wymuszenie (ang. *coercion*) do najbliższego możliwego typu.
Odbywa się to zgodnie z zasadą: logiczny -> liczba całkowita -> liczba zmiennoprzecinkowa -> znakowy.

Łącząc wektor logiczny i liczby całkowitej otrzyma się wektor składający się z liczb całkowitych, gdzie `FALSE` zostanie zamienione na `0`.


```r
c(FALSE, 2L)
#> [1] 0 2
```

Łączenie wektorów logicznego, liczby całkowitej i liczby zmiennoprzecinkowej w efekcie da wektor zmiennoprzecinkowy.


```r
c(FALSE, 2L, 3.1)
#> [1] 0.0 2.0 3.1
```

W sytuacji, gdy którykolwiek element będzie tekstem, cały wektor zostaje zamieniony na tekst.


```r
c(FALSE, 2L, 3.1, "kot")
#> [1] "FALSE" "2"     "3.1"   "kot"
```

## Zmiana typów obiektów

<!--rzutowanie??-->
Do zmiany typu obiektu^[Taka operacja często jest określana jako rzutowanie.] służą funkcje `as.logical()`, `as.integer()`, `as.double()`, oraz `as.character()`.


```r
as.logical(c("FALSE", "TRUE")) # znakowy na logiczny
#> [1] FALSE  TRUE
as.integer(c("3", "2")) # znakowy na liczba całkowita 
#> [1] 3 2
as.double(c(3L, 2L)) # liczba całkowita na liczba zmiennoprzecinkowa
#> [1] 3 2
as.character(c(3L, 2L)) # liczba całkowita na znakowy
#> [1] "3" "2"
```

Do sprawdzenia czy dany obiekt należy do wybranego typu służą funkcje `is.logical()`, `is.integer()`,`is.double()`,  oraz `is.character()`.

## Wektory czynnikowe {#fac}

Wektory czynnikowe służą do przechowywania informacji o pewnych kategoriach. 
Mogą to być, na przykład, wielokrotnie powtórzone nazwy miast czy krajów, czy też określenia płci w danych statystycznych.
Wektory czynnikowe wspomagają określanie wartości dla kolejnych grup o tej samej nazwie.


```r
tekst = c("Poznań", "Kraków", "Warszawa", "Poznań")
```

Zamiana wektora tekstowego na czynnikowy odbywa się z użyciem funkcji `as.factor()`.


```r
czynn = as.factor(tekst)
czynn
#> [1] Poznań   Kraków   Warszawa Poznań  
#> Levels: Kraków Poznań Warszawa
```

Wektory czynnikowe są wewnętrznie w R reprezentowane jako wartości stałoprzecinkowe.
Dodatkowo, posiadają one pewne informacje zaszyte w atrybutach, w tym wartości wszystkich kategorii oraz stwierdzenie posiadanej klasy [^Posiadanie atrybutu `class` zamienia je w tak zwane obiekty S3, które zachowują się inaczej niż normalne wektory atomowe.].


```r
typeof(czynn)
#> [1] "integer"
length(czynn)
#> [1] 4
attributes(czynn)
#> $levels
#> [1] "Kraków"   "Poznań"   "Warszawa"
#> 
#> $class
#> [1] "factor"
```

Możliwa jest również zamiana w drugą stronę - z wektora czynnikowego na wektor tekstowy używając funkcji `as.character()`.


```r
tekst2 = as.character(czynn)
tekst2
#> [1] "Poznań"   "Kraków"   "Warszawa" "Poznań"
```

## Wektory dat {#ate}

R ma wbudowaną reprezentację dat w postaci klasy `Date`.


```r
dzis = Sys.Date()
dzis
#> [1] "2021-04-13"
```

Pomimo tego, że powyżej data jest wyświetlona jako tekst (zwróć uwagę na cudzysłowy), wewnętrznie w R jest ona reprezentowana jako wartość zmiennoprzecinkowa.


```r
typeof(dzis)
#> [1] "double"
length(dzis)
#> [1] 1
attributes(dzis)
#> $class
#> [1] "Date"
```

Sprawdzenie tej wartości możliwe jest poprzez użycie funkcji `unclass()`.


```r
unclass(dzis)
#> [1] 18730
```

Wynik, 18730, oznacza liczbę dni od 1970-01-01.^[https://en.wikipedia.org/wiki/Unix_time]
W tej reprezentacji dni przed 1970-01-01 określane wewnętrznie są poprzez wartości ujemne.


```r
stara_data = as.Date("1912-04-13")
unclass(stara_data)
#> [1] -21082
```

Tworzenie wektora dat odbywa się używając funkcji `as.Date()`.


```r
daty = as.Date(c("2011-02-02", "2011-02-03"))
daty
#> [1] "2011-02-02" "2011-02-03"
```

Funkcja `as.Date()` oczekuje podanych wartość w postaci *YYYY-MM-DD* (wyjaśnienie można znaleźć w sekcji \@ref(daty)), ale możliwe jest również wymuszenie innej postaci danych wejściowych poprzez użycie argumentu `format`.

## Wektory czasu {#ime} 

W R istnieją również wbudowane reprezentacje dat i godzin (inaczej zwane data-czas, ang. *date-times*).
Najczęściej używaną jest klasa `POSIXct`, która jest wektorem przedstawiającym liczbę sekund of 1970-01-01.^[Wyświetlenie aktualnego czasu jest możliwe używając funkcji `Sys.time()`.]


```r
czas = as.POSIXct("2011-02-02 10:33", tz = "CET")
czas
#> [1] "2011-02-02 10:33:00 CET"
```

Wewnętrznie w R jest ona również reprezentowana jako wartość zmiennoprzecinkowa.


```r
typeof(czas)
#> [1] "double"
length(czas)
#> [1] 1
attributes(czas)
#> $class
#> [1] "POSIXct" "POSIXt" 
#> 
#> $tzone
#> [1] "CET"
```

Przykładowo, `"2011-02-02 10:33"` miało miejsce 1296639180 sekund od 1970-01-01.


```r
unclass(czas)
#> [1] 1.3e+09
#> attr(,"tzone")
#> [1] "CET"
```

Ważnym elementem reprezentacji czasu jest określenie strefy czasowej. 
Można ją zdefiniować w funkcji `as.POSIXct()` używając argumentu `tz`, ale też można zmienić strefę czasową istniejącego wektora poprzez modyfikację jego atrybutów.
W poniższym przykładzie nastąpiła zmiana strefy czasowej z czasu środkowoeuropejskiego (`"CET"`) na czas pacyficzny ^[https://en.wikipedia.org/wiki/List_of_tz_database_time_zones].


```r
attributes(czas)$tzone = "America/Los_Angeles"
czas
#> [1] "2011-02-02 01:33:00 PST"
```

Więcej informacji na temat stref czasowych używanych w R można znaleźć w pliku pomocy `?timezones`.

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">R posiada też dodatkowe klasy specjalne, np `POSIXlt` przechowująca informacje o dacie w postaci listy oraz `difftime` reprezentująca czas trwania.</div>\EndKnitrBlock{rmdinfo}

## Zadania {#zad5}

1) Wykonujesz trzy razy dziennie (o godzinie 7:00, 15:00 i 23:00) pomiar temperatury.
W ostatnich dwóch dniach (2019-03-11 i 2019-03-12) pomierzone wartości to 0, 5,2, 3,9, 4,1, 8,7, 5,3 stopni Celsjusza.
Stwórz nowy wektor `pomiary` zawierający te wartości.
2) Nazwij kolejne elementy tego wektora używając kolejnych liter alfabetu.
3) Pomyśl jakie właściwości ma wektor `pomiary` - jaki ma typ, jaką ma długość, jakie ma atrybuty?
Jeżeli jesteś przekonany co do odpowiedzi to sprawdź to pisząc odpowiedni kod.
4) Znajdź i wyświetl wartość `4.1` w wektorze `pomiary` używając kilku różnych sposobów wydzielania.
Ile możliwości udało się Tobie znaleźć?
5) Znajdź automatycznie położenie najwyższej wartości wektora `pomiary` i na jej podstawie stwórz nowy obiekt `pomiary_max`.
6) Wydziel wszystkie pomiary równe i niższe niż 5 stopni Celsjusza. Na ich podstawie stwórz nowy obiekt `pomiary_n5`.
<!-- 7) przeskaluj wartosci -->
7) Inna osoba również wykonywała pomiary temperatury w tym samym czasie.
Jej pomierzone wartości to -1.1, 4,2, 2,4, 3,1, 7,1, 4,2 stopni Celsjusza.
Dołącz te wartości do obiektu `pomiary`.
8) Stwórz nowy wektor `nazwy_stacji` zawierający nazwę Twojej stacji pomiarowej (`"Punkt 31"`) oraz stacji drugiej osoby (`"Stacja Thule"`), którego długość ma być równa długości wektora `pomiary`. 
Wektor `nazwy_stacji` powinien być klasy czynnikowej.
9) Stwórz nowy wektor `daty_pomiarow` zawierający rok, miesiąc i dzień pomiarów w wektorze `pomiary`.
10) Stwórz nowy wektor `czas_pomiarow` zawierający datę i czas pomiarów w wektorze `pomiary`.
Zdefiniuj też odpowiednią strefę czasową.
11) Stwórz nowy wektor `id_pomiarow` zawierający kolejne liczby całkowite od 1 do liczby pomiarów w wektorze `pomiary`.
12) Zastanów się (bez wykonywania) co jest efektem działania poniższego kodu.
Kiedy taka operacja mogłaby być konieczna?

```r
pomiary[3] = 3.3
```
13) Zastanów się (bez wykonywania) co jest efektem działania poniższego kodu.
Kiedy taka operacja mogłaby być konieczna?

```r
pomiary[pomiary <= 0] = NA
```
14) Zastanów się (bez wykonywania) co jest efektem działania poniższego kodu.

```r
wartosci1 = as.character(c(1, 3, 5))
mean(wartosci1)
```
15) Zastanów się (bez wykonywania) co jest efektem działania poniższego kodu.

```r
wartosci2 = as.numeric(c(1, "trzy", 5))
wartosci2
mean(wartosci2)
```
16) Wykonaj poniższą funkcję. 
Następnie wydziel nowy wektor `pomiary2`, który nie zawiera wartości `NA`.

```r
pomiary[pomiary <= 0] = NA
```
17) Trzecia osoba również wykonywała pomiary temperatury w tym samym czasie.
Przesłała ona Tobie taki wektor - `c(-5.2, 3.0, 1.1, "zaspałem", 6.4, 2.2)`.
Jakiej klasy jest ten wektor a jaka powinna być jego klasa, aby możliwe było wykonywanie na niej obliczeń, np. wyliczanie średniej?
Jak to można uzyskać?




