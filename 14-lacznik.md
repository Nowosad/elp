# Łącznik {#lacznik}

<!-- intro o r jako jezyku laczacym inne -->
<!-- intro o innych łącznikach -->
R ma bezpośrednio wbudowane mechanizmy łączenia kodu R z kodem napisanym w językach C i Fortan.
W tym rozdziale skupimy się jednak na przykładach łączenia R z innymi, popularnymi współcześnie językami programowania C++ i Pythonem (sekcje \@ref(cpp) i \@ref(python)) oraz z systemową linią komend (sekcja \@ref(powloka-systemowa)).
Inne możliwe połączenia R to z językami takimi jak [Rust](https://github.com/r-rust/hellorust), [JavaScript](https://jeroen.cran.dev/V8/), czy [Java](http://www.rforge.net/rJava/).

## C++ {#cpp}

C++ jest jednym z najczęściej używanych kompilowanych języków programowania.
Jest to spowodowane kilkoma zaletami tego języka, w tym jego wysoką wydajnością, niezależnością od konkretnej platformy systemowej, czy uniwersalnością.

Język C++ posiada zarówno wiele podobnych do R konstrukcji i koncepcji, ale też różni się w pewnych kluczowych koncepcjach. 
Najważniejsze cechy C++, które wyróżniają go od R i które warto znać na początku:

- Jest językiem kompilowanym
- Pozwala na używanie tylko `=` jako operatora przypisania
- Zakłada głównie statyczną kontrolę typów 
- Posiada typ skalarny
- Domyślnie nie używa wektoryzacji
- Większość linii kodu należy kończyć znakiem średnika `;`
- Konieczne jest zwracanie wartości używając `return`

Przykładowy kod R do przeliczania temperatury ze stopni Fahrenheita na Celsjusza wygląda w poniższy sposób (sekcja \@ref(budowanie-funkcji)):


```r
konwersja_temp = function(temperatura_f){
    (temperatura_f - 32) / 1.8
}
```

To samo obliczenie wykonane w języku C++ może wyglądać w ten sposób:


```cpp
double konwersja_temp_cpp(double temperatura_f){
  double temperatura_c = (temperatura_f - 32) / 1.8;
  return temperatura_c;
}
```

Odnosząc się do punktów z wcześniej wymienionej listy:

- Jest językiem kompilowanym - gdybyśmy chcieli użyć powyższą funkcję jako program C++ musielibyśmy stworzyć kolejną funkcję `main()`, a następnie skompilować kod. 
Nie jest możliwe wykonywanie tego kodu linia po linii
- Pozwala na używanie tylko `=` jako operatora przypisania - nie możemy w nim użyć operatora `<-` czy `->`
- Zakłada głównie statyczną kontrolę typów - w powyższym przykładzie musieliśmy zadeklarować, że nasza funkcja `konwersja_temp_cpp`, nasz argument `temperatura_f` oraz zmienna `temperatura_c` będzie typu `double`. Zrobiliśmy to poprzez dodanie nazwy typu przed nazwą funkcji/argumentu/zmiennej. 
Co ważne, w tym języku też typy (zazwyczaj) nie są automatycznie konwertowane do innych typów jak ma to miejsce w R (sekcja \@ref(lpto-vector)). 
- Posiada typ skalarny - `double` może przechowywać tylko jedną wartość. 
- Domyślnie nie używa wektoryzacji - powyższa funkcja `konwersja_temp_cpp()` zwróci błąd `Expecting a single value` w przypadku podania wektora numerycznego jako obiekt wejściowy.
Aby użyć wektor wartości na wejściu konieczne jest napisane pętli lub użycie innych podobnych konstrukcji.
- Większość linii kodu należy kończyć znakiem średnika `;`. 
Nie dotyczy to linii definiujących powstanie funkcji, rozpoczynających i kończących pętle czy wyrażenia warunkowe
- Konieczne jest zwracanie wartości używając `return`. 
W R użycie funkcji `return()` było opcjonalne.

Obecnie ponad dwa tysiące pakietów R łączy się z językiem C++ używając pakietu **Rcpp** [@R-Rcpp].
Dodanie języka C++ do pakietu R często ma na celu przyspieszenie pewnych  wymagających obliczeniowo zadań lub połączenie R z istniejącymi zewnętrznymi bibliotekami napisanymi w C++.


```r
library(Rcpp)
```

<!-- https://cran.r-project.org/web/packages/Rcpp/vignettes/Rcpp-introduction.pdf  -->

Pakiet **Rcpp** pozwala na zarówno wywoływanie kodu C++ wewnątrz skryptów R (sekcja \@ref(cppFunction)), jak używając zewnętrznych plików o rozszerzeniu `.cpp` (sekcja \@ref(sourceCpp)).

Ta część książki ma na celu pokazanie zupełnych podstaw łączenia R z C++.
Więcej informacji na ten temat można znaleść na stronie http://www.rcpp.org/, w [rozdziale Rewriting R code in C++](https://adv-r.hadley.nz/rcpp.html) książki @wickham2014advanced, [sekcji Rcpp](https://csgillespie.github.io/efficientR/rcpp.html) książki @gillespie2016efficient, oraz na stronie [Unofficial Rcpp API Documentation](https://thecoatlessprofessor.com/programming/cpp/unofficial-rcpp-api-documentation).

### Wywoływanie kodu C++ wewnątrz skryptu R {#cppFunction}

W przypadku krótkich fragmentów kodu C++ możliwe jest umieszczenie ich wewnątrz skryptu R jako obiekt tekstowy.
Poniższej stworzono nowy obiekt `rcpp_fun1`, który zawiera wcześniejszą funkcję C++.


```r
rcpp_fun1 = "
double konwersja_temp_cpp(double temperatura_f){
  double temperatura_c = (temperatura_f - 32) / 1.8;
  return temperatura_c;
}
"
```

W kolejnym kroku konieczne jest skompilowanie powyższego kodu i stworzenie połączenia pomiędzy nim a R za pomocą funkcji `cppFunction()`.


```r
cppFunction(rcpp_fun1)
```

Od tego momentu możliwe jest korzystanie z funkcji `konwersja_temp_cpp()`.
Możemy sprawdzić jej działanie poprzez podanie wybranej przez nas wartości, na przykład `75`.


```r
konwersja_temp_cpp(75)
#> [1] 23.9
```

Warto jednak nadal pamiętać, że powyższa funkcja nie jest zwektoryzowana - możliwe jest podanie w niej tylko obiektu o długości 1.
W przypadku zadeklarowania dłuższego obiektu wejściowego otrzymamy błąd:


```r
konwersja_temp_cpp(c(0, 75, 110))
#> Error in konwersja_temp_cpp(c(0, 75, 110)): Expecting a single value: [extent=3].
```

W sekcji \@ref(zastosowanie-w-funkcjach) stworzyliśmy funkcję `mile_na_km()`, która przyjmuje i zwraca obiekt o klasie lista i zamienia wartości elementów tej listy z mil lądowych na kilometry. 


```r
mile_na_km = function(odl_mile) {
  odl_km = vector("list", length = length(odl_mile))
  for (i in seq_along(odl_mile)) {
    odl_km[[i]] = odl_mile[[i]] * 1.609
  }
  odl_km
}
```

Ta sama funkcja w języku C++ może wyglądać w ten sposób:


```cpp
List mile_na_km_cpp(List odl_mile){
  int odl_mile_len = odl_mile.size();
  List result(odl_mile_len);
  for (int i = 0; i < odl_mile_len; i++){
    result[i] = odl_mile[i] * 1.609;
  }
  return result;
}
```

Zawiera ona szereg różnic od kodu R.
Oprócz definicji typów, używania średnika i operatora `return`, widać tutaj także inną metodę wywołania funkcji oraz inny sposób definiowania pętli `for`.

Zadaniem linii `int odl_mile_len = odl_mile.size();` jest stworzenie nowej zmiennej skalarnej (`odl_mile_len`) o typie integer (`int`).
Ta nowa zmienna jest wynikiem działania funkcji `size()`, która jest odpowiednikiem używanej w R `length()`.
W przypadku używania R wywołanie funkcji ma jednak postać, w której podajemy nazwę funkcji, a następnie w nawiasie okrągłym obiekt wejściowy.
C++ pozwala też na inny sposób wywoływania funkcji - używając wbudowanych metod.
Odbywa się to poprzez podanie nazwy obiektu (`odl_mile`), a następnie po kropce (`.`) podania nazwy funkcji (`size()`).

W C++ pętle można definiować używając poniższej składni:


```cpp
for (inicjalizacja zmiennej; warunek zakończenia; aktualizacja zmiennej) {
  // Kod do wykonania
}
```

Po pierwsze należy przekazać w miejscu `inicjalizacja zmiennej` stworzenie zmiennej, na podstawie której będzie oparta pętla.
`int i = 0` oznacza, że tworzymy zmienną o typie integer `i`, która przyjmuje wartość 0.
Jest to spowodowane ważną różnicą między C++ a R - w tym pierwszym języku liczenie rozpoczynamy od 0.
Przykładowo w C++, `a[0]` pozwoli na wybranie pierwszego elementu z wektora `a`.
Drugim elementem jest `warunek trwania`, czyli określenie do kiedy pęlta trwa.
`i < odl_mile_len` oznacza, że pętla będzie działała tak długo aż `i` będzie mniejsze niż `odl_mile_len`.
Ostatni element, `aktualizacja zmiennej`, mówi co ma się stać ze stworzoną zmienną po każdym przebiegu pętli.
`i++` to skrót w języku C++ mówiący, że z każdą pętlą wartość `i` będzie rosła o 1.
Jest to odpowiednik kodu `i = i + 1`.

W powyższej składni też widać sposób definiowania komentarzy w języku C++, gdzie używa się operatora `//`.

Zainicjujmy funkcję C++ `mile_na_km_cpp()` używając `cppFunction()`.


```r
rcpp_fun2 = "List mile_na_km_cpp(List odl_mile){
  int odl_mile_len = odl_mile.size();
  List result(odl_mile_len);
  for (int i = 0; i < odl_mile_len; i++){
    result[i] = odl_mile[i] * 1.609;
  }
  return result;
}"
cppFunction(rcpp_fun2)
```

Możemy sprawdzić jej działanie na przykładowym wektore `odl_mile` używając kodu poniżej.


```r
odl_mile = list(142, 63, 121)
mile_na_km_cpp(odl_mile)
#> [[1]]
#> [1] 228
#> 
#> [[2]]
#> [1] 101
#> 
#> [[3]]
#> [1] 195
```

Dodatkowo warto porównać prędkość rozwiązania w R z C++ używająć listy o długości 10001 i funkcji `mark()` z pakietu **bench**.


```r
odl_mile2 = as.list(0:10000)
wynik = bench::mark(
  mile_na_km(odl_mile2),
  mile_na_km_cpp(odl_mile2)
)
wynik
#> # A tibble: 2 x 6
#>   expression                     min   median `itr/sec`
#>   <bch:expr>                <bch:tm> <bch:tm>     <dbl>
#> 1 mile_na_km(odl_mile2)        801µs    822µs     1172.
#> 2 mile_na_km_cpp(odl_mile2)    417µs    441µs     2231.
#> # … with 2 more variables: mem_alloc <bch:byt>,
#> #   gc/sec <dbl>
```

Mimo otrzymania tego samego wyniku, czas wykonania funkcji napisanej w C++ był około 1.86 raza mniejszy.

### Wywoływanie kodu z plików .cpp {#sourceCpp}

Powyższy przykład sprawdza się w przypadku małych fragmentów kodu C++.
W momencie jednak, gdy kod staje się bardziej złożony, znacznie lepsze jest umieszczenie go w oddzielnym pliku o rozszerzeniu `.cpp`.
Taki plik może też być umieszczony wewnątrz pakietu R (rozdział  \@ref(tworzenie-pakietow)).

Używanie kod C++ z pliku z poziomu R wymaga jednak pewnych dodatkowych działań.
Konieczne jest dodane do tego pliku kilku linii nagłówków, które umożliwią interakcję pomiędzy C++ a R.

Pierwsza z nich ma na celu umożliwienie dostępu do funkcji z pakietu **Rcpp**, poprzez podanie nazwy pliku `Rcpp.h` w linii `#include`.


```cpp
#include <Rcpp.h>
```

Dalej, opcjonalnie można dodać również linię `using namespace Rcpp;`. 
W przeciwnym razie każde wywołanie funkcji z pakietu **Rcpp** (np., `List`) musielibyśmy poprzedzać `Rcpp::` (np., `Rcpp::List`).


```cpp
using namespace Rcpp;
```

Ostatnią kwestią przed dodaniem kodu funkcji C++ jest zdecydowanie czy konkretną funkcję chcemy udostępnić i używać w R.
Gdybyśmy nie dodali poniższego kodu, funkcja nie byłaby widoczna z poziomu R.


```cpp
// [[Rcpp::export]]
```

Kompletny kod funkcji można zobaczyć poniżej.


```cpp
#include <Rcpp.h>
using namespace Rcpp;
// [[Rcpp::export]]
List mile_na_km_cpp(List odl_mile){
  int odl_mile_len = odl_mile.size();
  List result(odl_mile_len);
  for (int i = 0; i < odl_mile_len; i++){
    result[i] = odl_mile[i] * 1.609;
  }
  return(result);
}
```

Można go zapisać do pliku `.cpp`, np. `mile_na_km_cpp.cpp`, a następnie skompilować i udostępnić dla R z użyciem funkcji `sourceCpp()`.


```r
sourceCpp("mile_na_km_cpp.cpp")
```

Teraz też możliwe jest jego sprawdzenie na przykładowym obiekcie:


```r
odl_mile = list(142, 63, 121)
mile_na_km_cpp(odl_mile)
#> [[1]]
#> [1] 228
#> 
#> [[2]]
#> [1] 101
#> 
#> [[3]]
#> [1] 195
```

## Python

Python jest współcześnie najpopularniejszym językiem programowania.<!--REF-->
Podobnie jak R, ten język jest interpretowalny, otwarty, i można uruchomić na różnych systemach operacyjnych (Windows, Mac OS i Linux).
Jest to uniwersalny język programowania znajdujący zastosowanie od aplikacji internetowych, poprzez pisanie skryptów sterujących innym oprogramowaniem (jak np. QGIS), aż do projektów związanych ze sztuczną inteligencją i uczeniem maszynowym. 

Różni się on od R szeregiem cech, wśród których na samym początku można zauważyć, że Python:

- Ma inne wbudowane typy danych. 
Przykładowo, wektor atomowy w R odpowiada podobnemu typowi - liście w Pythonie.
- Obowiązkowe jest stosowanie wcięć jako elementu języka.
W R stosowanie wcięć jest rekomendowane, ale nie wymagane.
W Pythonie kod bez odpowiednich wcięć nie zadziała.
- Ma inny sposób pracy na obiektach. 
<!-- Przykładowo,  -->
- Stosuje indeksowanie zaczynające się od 0.
W Pythonie wybranie pierwszego i trzeciego elementu z listy wymaga podania wartości indeksu 0 i 2.

Python także pozwala na tworzenie i udostępnianie modułów i pakietów rozszerzających możliwości tego języka.
Czasem podczas pracy nad jakimś projektem w R może okazać się, że konieczne jest zastosowanie rozwiązania, którego w R nie ma, a jego implementacja wymagałaby znaczącego wkładu czasowego.
Pomocny w takiej chwili może okazać się jeden z wielu pakietów Pythona. 
Aby go użyć, nie musimy jednak opuszczać R i przenosić wszystkich elementów programu do innego języka.
Polecenia Pythona można wywołać z poziomu R używając pakietu o nazwie **reticulate** [@R-reticulate].
Może to mieć miejsce w czterech trybach: (1) stosowania poleceń [Pythona w R Markdown](https://rstudio.github.io/reticulate/#python-in-r-markdown), (2) importowania modułów Pythona do R, (3) uruchomiania skryptów Pythona w R, oraz (4) interaktywnego korzystania z konsoli Pythona wewnątrz R wraz z dostępem do tworzonych obiektów.
Pełną dokumentację tego pakietu wraz z szeregiem przykładów można znaleźć pod adresem https://rstudio.github.io/reticulate/. 
Istnieje także możliwość połączenia tych języków w drugą stronę, przykładowo używając [modułu **rpy2**](https://rpy2.github.io/).

## Powłoka systemowa {#powloka-systemowa}

Współcześnie kontaktujemy się z komputerami najczęściej używając przeróżnych  interfejsów graficznych poprzez kliknięcia myszką czy naciśnięcia klawiatury. 
Jednocześnie większość systemów operacyjnych posiada swoje powłoki systemowe (ang. *shell*).
Pełnią one rolę pośrednika pomiędzy systemem operacyjnym a użytkownikiem i pozwalają one uruchamiać programy, sterować nimi poprzez wprowadzanie poleceń, czy zwracać wyniki ich działania.

R pozwala na łączenie się z powłoką systemową używając funkcji `system2()`.^[W R istnieje również funkcja `system()`, która jest mniej uniwersalna niż `system2()` i różni się od niej składnią]
W ten sposób możliwe jest zarówno wywoływanie poleceń wbudowanych w powłokę systemową, uruchomianie skryptów powłoki systemowej (np. `system2("moj_bash_skrypt.sh")`), czy też zewnętrznych aplikacji (w taki sposób pakiet **rgrass7** [@R-rgrass7] łączy się z programem [GRASS GIS](https://grass.osgeo.org/)).

Przykładowo, w systemach opartych o UNIX polecenie `wc` pozwoli na określenie liczby wyrazów w wybranym pliku.
Używając `system2()` oraz polecenia `wc` możemy sprawdzić ile wyrazów znajduje się w tym rozdziale książki.


```r
system2("wc", args = "-l 14-lacznik.Rmd")
```

<!-- https://stackoverflow.com/questions/48605776/difference-between-system-and-system2-in-r-capture-file-names-in-variable -->
<!-- https://stackoverflow.com/questions/5745886/r-and-system-calls -->
<!-- https://tomaztsql.wordpress.com/2020/01/06/working-with-system-commands-in-r/ -->
<!-- https://joongsup.rbind.io/post/2018/02/05/run-system-commands-or-shell-sripts-from-an-interactive-r-session/ -->
<!-- https://missing.csail.mit.edu/ -->

## Zadania {#zad14}

1. Napisz funkcję `f_to_c_r()` w języku R do przeliczania wartości ze stopni Fahrenheita na stopnie Celsjusza.
Funkcja ta powinna przyjmować wektor wartości, np. `c(0, 75, 110)` i także zwracać wektor na wyjściu.
2. Stwórz nowy plik `f_to_c_c.cpp` zawierający funkcję C++ do przeliczania wartości ze stopni Fahrenheita na stopnie Celsjusza.
W przeciwieństwie do kodu przedstawionego w funkcji `konwersja_temp_cpp()` powyżej, nowa funkcja powinna pozwalać na przeliczanie wektorów numerycznych składających się z wielu wartości.
Sprawdź działanie tej funkcji z poziomu R.
3. (Dodatkowo) Stwórz moduł Pythona `f_to_c_p.py` również przeliczający wartości ze stopni Fahrenheita na stopnie Celsjusza.
Sprawdź działanie tego modułu z poziomu R.
4. Stwórz wektor numeryczny od -1000 do 1000 co 0.5. 
Sprawdź prędkość działania funkcji stworzonych we wcześniejszych zadaniach używając funkcji `mark()` z pakietu **bench**.
