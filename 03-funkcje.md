
# Funkcje {#funkcje}

<!-- intro (co to) -->

## Algorytmy

Algorytm to opis procedery prowadzącej do uzyskania określonego celu.
<!-- przepis kucharski -->

## Struktura funkcji

<img src="images/funkcje.png" width="100%" style="display: block; margin: auto;" />

## Wbudowane funkcje


```r
x = c(8.2, 10.3, 12.0)
```


```r
(8.2 + 10.3 + 12.0) / 3
#> [1] 10.2
```


```r
sum(x) / length(x)
#> [1] 10.2
```


```r
mean(x)
#> [1] 10.2
```


```r
y = mean(x)
```

## Dokumentacja funkcji

Każda wbudowana funkcja w R posiada swoją dokumentację^[Niektóre zbiory danych również posiadają swoje pliki pomocy.].
Można ją wyświetlić poprzez dodanie znaku zapytania przed nazwą funkcji, a następnie wykonanie tej linii kodu.


```r
?mean
```

Alternatywnie, w RStudio możliwe jest użycie skrótu F1 gdy kursor znajduje się na nazwie funkcji.

Dokumentacja każdej funkcji, zwana inaczej plikiem pomocy, ma zazwyczaj podobną strukturę.

- W lewym górnym rogu znajduje się nazwa funkcji (`mean`) oraz nazwa pakietu z którego dana funkcja pochodzi (`base`)
- Poniżej znajduje się tytuł funkcji oraz jej krótki opis
- Kolejnym elementem jest budowa funkcji (*Usage*), która skrótowo opisuje z jakich argumentów składa się dana funkcja.
Np. funkcja `mean()` przyjmuje argument `x`, `trim`, oraz `na.rm`. 
Dla argumentów `trim` oraz `na.rm` są także ustalone ich domyślne wartości.
Dodatkowo, widoczny jest argument w postaci wielokropka (`...`). 
<!--!?-->
- Argumenty funkcji są również wypisane oraz skrótowo wyjaśnione. 
Przykładowo, `x` musi być obiektem R o typie numerycznym (który łączy typ liczb całkowitych i zmiennoprzecinkowych<!--ref-->), logicznym, `date`, `date-time`, lub `time interval`.
- Część *Value* (lub *Details*) opisuje szczegóły wykonywanej funkcji
- Inne możliwe elementy to np. *References* odnoszący się do artykułu czy książki opisującej daną funkcję lub metodę, czy też *See also* zawierający odnośniki do innych, podobnych funkcji
- Jeden z najważniejszych elementów pliku pomocy znajduje się na samym końcu - są to przykłady (*Examples*).
Jeżeli nie jesteśmy pewni jak dana funkcja działa warto zacząć od skopiowania przykładów a następnie ich wykonania.

Czytanie dokumentacji wymaga pewnej wprawy i doświadczenia. 
Nie bój się używać innych źródeł pomocy (zobacz sekcję \@ref(resources)), jeżli potrzebujesz zrozumieć działanie danej funkcji.

## Pakiety

Pakiet to zorganizowany zbiór funkcji, który rozszerza możliwości R.
<!-- przykłady -->
Pakiety oprócz kodu zawierają szereg dodatkowych istotnych elementów, takich jak:

- Informacja o wersji pakietu, jego twórcach, zależnościach, czy licencji
- Dokumentacja
- Przykładowe dane
- Testy kodu

Pakiety R mogą być przechowywane i instalowane z wielu miejsc w internecie. 
Istnieje jednak jedno centralne repozytorium (CRAN, ang. *the Comprehensive R Archive Network*), które zawiera oficjalne wersje pakietów R. 
Wersje deweloperskie (rozwojowe) często można znaleźć na platformie [GitHub](https://github.com/).

Do instalacji pakietu w R z repozytorium CRAN służy wbudowana funkcja `install.packages()`, np:


```r
install.packages("stringr") #instalacja pakietu stringr
```

Zainstalowanie pakietu w R z platformy GitHub jest możliwe używając, np. funkcji `install_github()` z pakietu **remotes**.


```r
# install.packages("remotes")
remotes::install_github("r-lib/remotes")
```

Podobnie jak instalowanie programów na komputerze - zainstalowanie pakietu odbywa się tylko jeden raz.

Użycie wybranego pakietu wymaga dołączenia go do R za pomocą funkcji `library()`.
Dołączenie wybranych pakietów do R robimy po każdym uruchomieniu R.


```r
library(stringr)
```

<!-- stringr::str_sub() -->


```r
str_sub("chronologia", start = 1, end = 6)
#> Error in str_sub("chronologia", start = 1, end = 6) : 
#>  could not find function "str_sub"
```
<!-- block - inaczej biblioteki, moduły, etc -->

## Tworzenie skryptów

<!--kodowanie tekstu-->
Skrypt w R to plik testowy z rozszerzeniem `.R`, który zawiera szereg linii kodu w celu uzyskania konkretnego efektu.
Może on zawierać zaledwie kilka jak i setki linii kodu w zależności od złożoności postawionego problemu.
Zobaczmy jak wyglądają skrypty na prostym przykładzie - przeliczania wartości ze skali Fahrenheita na skalę Celsjusza.
Otrzymaliśmy informację, że w "mieście A" temperatura w stopniach Fahrenheita wynosi 75.


```r
miasto_a = 75
```

Pierwszym naszym krokiem powinno być dowiedzenie się jaka jest relacja pomiędzy skalą Fahrenheita na skalą Celsjusza.

$$T_{Celsjusz} = \frac{T_{Fahrenheit} - 32}{1.8}$$

Następnie powyższy wzór można przepisać do postaci kodu w języku R oraz podstawić do niego wartość temperatury w stopniach Fahrenheita w mieście A.
Ostatnim etapem jest wyświetlenie uzyskanego wyniku - temperatura w mieście A wynosi ok. 24 stopnie Celsjusza.


```r
miasto_a_c = (miasto_a - 32) / 1.8
miasto_a_c
#> [1] 23.9
```

Powyższe kroki można również zapisać do pliku tekstowego. 


```r
# plik przeliczanie-temp.R
miasto_a = 75
miasto_a_c = (miasto_a - 32) / 1.8
miasto_a_c
#> [1] 23.9
```

Co można zrobić jeżeli mamy więcej podobnych pomiarów, które chcemy wykonać?
Najprostszą opcją jest użycie kopiuj/wklej i powielenie tego samego kodu, a później naniesienie małych zmian, np. nazw obiektów.
<!-- ^[o wekrtoryzacji] -->
<!-- or use data.frame? -->


```r
miasto_a = 75
miasto_b = 110
miasto_c = 0
miasto_a_c = (miasto_a - 32) / 1.8
miasto_b_c = (miasto_b - 32) / 1.8
miasto_c_c = (miasto_c - 32) / 1.8
```

Powyższe podejście jest poprawne, ale ma ono kilka wad:

* Łatwo jest o popełnie jakiegoś prostego błędu lub literówki podczas adaptacji kodu (np. można zapomnieć zmienić nazwę jakiejś zmiennej)
* Jeżeli obliczenia zajmują więcej niż kilka linii kodu - wówczas kopiowanie go znacznie powiększa tworzony skrypt i utrudnia jego czytelność
* Poprawienie kodu w przypadku zauważenia błędu w procedurze obliczeniowej jest czasochłonne

To podejście jest też niezgodne z jedną z najważniejszych reguł w programowaniu - regułą DRY (Nie powtarzaj się, ang. *Don't Repeat Yourself*).
Zamiast tworzenia skryptu w oparciu o kopiuj/wklej lepiej pomyśleć nad zbudowaniem odpowiedniej funkcji^[@grolemund_r_2016 radzą używać funkcje, gdy ten sam kod potwarza się co najmniej trzy razy.].

## Budowanie funkcji

Funkcje pozwalają na automatyzację często używanych obliczeń.
Formalnie funkcje składają się z trzech elementów: listy argumentów (ang. *formals*), ciała funkcji (ang. *body*) oraz środowiska (ang. *environment*).
Pierwsze dwa elementy ustala twórca funkcji, natomiast środowisko jest określane na podstawie tego, gdzie dana funkcja została zdefiniowana<!--^[footnote o environment]https://rstudio-education.github.io/hopr/environments.html-->.
Dodatkowo każda funkcja ma swoją nazwę.


```r
moja_funkcja = function(x, y, z){
  pod = y / z
  wynik = x * pod
  wynik
}
```
<!-- wynik vs return(wynik) -->

Lista argumentów wymienia obiekty wejściowe funkcji.


```r
formals(moja_funkcja)
#> $x
#> 
#> 
#> $y
#> 
#> 
#> $z
```

Ciało zawiera kod danej funkcji.


```r
body(moja_funkcja)
#> {
#>     pod = y/z
#>     wynik = x * pod
#>     wynik
#> }
```

Środowisko określa, gdzie dana funkcja jest zlokalizowana.


```r
environment(moja_funkcja)
#> <environment: R_GlobalEnv>
```

Przykładowa funkcja odpowiadająca problemowi z poprzedniej sekcji może wyglądać w poniższy sposób:


```r
konwersja_temp = function(temperatura_f){
    (temperatura_f - 32) / 1.8
}
```

Nowa funkcja nazywa się `konwersja_temp()` oraz posiada tylko jeden argument `temperatura_f`.
Ciało funkcji zawiera natomiast wzór potrzebny do obliczeń przepisany do R.
Ważne jest to, że obiekt użyty wewnątrz funkcji (`temperatura_f`) jest taki sam jak wejściowy argument.

Po stworzeniu funkcji warto sprawdzić czy jej działanie odpowiada naszym oczekiwaniom.


```r
konwersja_temp(75)
#> [1] 23.9
konwersja_temp(110)
#> [1] 43.3
konwersja_temp(0)
#> [1] -17.8
konwersja_temp(c(0, 75, 110))
#> [1] -17.8  23.9  43.3
```

### Komunikaty

Oprócz wyniku danej operacji R może wyświetlić kilka rodzajów wiadomości.
<!-- with examples-->
<!-- - błędy/ostrzeżenia -->
<!-- rodzaje błędów - http://jarekj.home.amu.edu.pl/wp-content/uploads/2018/10/006_wyjatki.html -->
<!-- - komentarze -->
<!-- - czytelność kodu/ styl -->
<!-- wersje R -->

## Zadania

1. Zobacz jak wygląda plik pomocy funkcji `mean()`.
Wykonaj zawarte w nim przykłady.
Co zostało w nich wykonane?
<!-- zadania w stylu - skąd error? -->
