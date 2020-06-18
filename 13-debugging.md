# Debugowanie {#debugging}

Używając pakietów i funkcji stworzonych przez inne osoby możemy czasem znaleźć się w sytuacji, gdy zamiast wyniku otrzymujemy komunikat błędu.
Warto wówczas upewnić się czy nie napisaliśmy żadnej literówki i podaliśmy odpowiednie argumenty funkcji.
Konieczne kolejne kroki mogą obejmować sprawdzenie pliku pomocy danej funkcji, czy też skopiowanie najważniejszego fragmentu błędu i wklejenie go do wyszukiwarki internetowej. 
Isnieje szansa, że ktoś już wcześniej napotkał ten problem, zadał pytanie i otrzymał na nie odpowiedź w internecie (np, na https://stackoverflow.com/).

Czasem się może jednak okazać, że odkryliśmy nowy problem - warto go wtedy zgłosić do twórców pakietu.
Wiele pakietów na platformie CRAN zawiera sekcję *BugReports*, gdzie można znaleźć link do zgłaszania błędów.
Przykładowo, pakiet **stringr** jest opisany pod adresem https://cran.r-project.org/package=stringr i w jego sekcji *BugReports* znajduje się odnośnik do https://github.com/tidyverse/stringr/issues.
W przypadku zgłaszania błędów zazwyczaj nie należy pisać bardzo długich opisów czy wklejać cały kod, który został napisany.
Konieczne jest natomiast przygotowanie powtarzalnego przykładu (ang. *reproducible example*), czyli minimalnego kodu możliwego do odtworzenia problemu na innym komputerze (sekcja \@ref(reprex)).
Warto jednak pamiętać, że sekcja *Issue* na platformie Github służy głównie do zgłaszania problemów, a nie do zadawania pytań.
W przypadku potrzeby zadania pytania, lepszym pomysłem jest opublikowanie go na https://stackoverflow.com/,

<!-- https://en.wikipedia.org/wiki/Debugging#/media/File:H96566k.jpg -->

Tworzenie kodu możliwego do odtworzenia problemu (powtarzalnych przykładów) jest też pomocne w przypadku, gdy my piszemy nowe skrypty i funkcje i napotkamy na błędy.
Jest to często część debugowania (ang. *debugging*) - procesu rozwiązywania problemów i błędów w oprogramowaniu.
Istnieje wiele potencjalnych taktyk debugowania kodu, w tym debugowanie używając funkcji takich jak `print()` (sekcja \@ref(debuging-print)), czy też debuggera (sekcja \@ref(debugger)).

Więcej na temat debugowania kodu w R można dowiedzieć się więcej z prezentacji Jenny Bryan pt. [Object of type 'closure' is not subsettable](https://github.com/jennybc/debugging), [rozdziału Debugging R code] książki @rstatswtf, oraz [rozdziału Debugging] książki @wickham2016r.
Dodatkowo, na stronach [Debugging an R Package with C++](https://blog.davisvaughan.com/2019/04/05/debug-r-package-with-cpp/), [Debugging C/C++ code that interfaces with R](https://github.com/wch/r-debug/blob/master/debugging-r.md), oraz [Debugging with LLDB](http://kevinushey.github.io/blog/2015/04/13/debugging-with-lldb/) można przeczytać na temat debugowania kodu C++ łączącego się z R.

## Powtarzalne przykłady {#reprex}

Powtarzalny przykład oznacza fragment kodu, który może być odtworzony przez inną osobę na innym komputerze lub przez siebie samego w przyszłości.
Może on służyć pokazaniu poprawnego rozwiązania, wskazaniu na błędy w funkcjach, lub też jako załącznik do prośby o pomoc z kodem.
Powtarzalny przykład powinien składać się przynajmniej z:

- Z małego zbioru danych lub obiektu zawierającego dane wystarczającego do odtworzenia obliczeń
- Krótkiego kodu, który może być uruchomiony na powyższym zbiorze danych

Czasem ważne są też dodatkowe informacje o używanej wersji R, posiadanym systemie operacyjnym, wersjach używanych pakietów, etc. 
Można do tego użyć funkcji `sessionInfo()` 

### Pakiet **reprex**

Stworzenie powtarzalnego przykładu w R może zostać ułatwione używając pakietu **reprex** [@R-reprex]. 
Ten pakiet uruchamia wybraną część kodu w nowej sesji R uruchomionej w tle, wykonuje kolejne operacje, a następnie zapisuje uzyskany wynik do schowka.

Główną funkcją w tym pakiecie jest `reprex()`.
Funkcję `reprex()` można użyć poprzez wpisanie kodu wewnątrz tej funkcji lub też poprzez wybranie opcji `Reprex selection` z menu Addins w RStudio.
Możliwe jest również stworzenie powtarzalnego przykładu na podstawie skryptu R:


```r
reprex(input = "moj_skrypt.R")
```

Więcej informacji na temat powtarzalnych przykładów oraz pakietu **reprex** można znaleźć na [oficjalnej stronie pakietu reprex](https://reprex.tidyverse.org/index.html), oraz stronach [So you’ve been asked to make a reprex](https://www.jessemaegan.com/post/so-you-ve-been-asked-to-make-a-reprex/), [How to make a great R reproducible example](https://stackoverflow.com/questions/5963269/how-to-make-a-great-r-reproducible-example), [Magic reprex](https://www.njtierney.com/post/2017/01/11/magic-reprex/), [reprex: help me help you!](https://speakerdeck.com/jennybc/reprex-help-me-help-you), oraz [Get help!](https://www.tidyverse.org/help/#reprex).

### Tworzenie powtarzalnego przykładu

Działanie pakietu **reprex**  można zobaczyć poniżej.
Tworzymy dwa obiekty `x` i `y`, przypisujemy im wartości, a następnie je mnożymy przez siebie.


```r
x = 1
y = 5
x * y
#> [1] 5
```

Ten sam kod umieszczony w funkcji `reprex()` wygląda w ten sposób:


```r
library(reprex)
reprex({
  x = 1
  y = 5
  x * y
})
```

Wynik działania powyższego kodu zapisywany jest w schowku jako Markdown oraz w postaci wyświetlonego pliku HTML:

<img src="figures/reprex1.png" width="\textwidth" style="display: block; margin: auto;" />

Kolejny powtarzalny przykład pochodzi z rozdziału \@ref(tekst), gdzie naszym celem było określenie które elementy wektora `tekst3` rozpoczynają się od dużej litery `L`.


```r
reprex({
  teskt3 = c("Magdalena", "Lena", "1Lena.csv", "LLena", "Helena", "Anna", "99")
  str_detect(tekst3, pattern = "^L")
})
```

Niestety zwraca on błąd.
Powyższy kod ma dwa problemy - czy jesteś w stanie je wskazać?

<img src="figures/reprex2.png" width="\textwidth" style="display: block; margin: auto;" />

Odpowiedź - ten kod nie jest w pełni samowystarczalny - brakuje tam dołączenia pakietu **stringr**, który zawiera funkcję `str_detect()`.
Drugi problem to literówka w obiekcie `teskt3`.
Naprawiona wersja tego kodu znajduje się poniżej:


```r
reprex({
  library(stringr)
  tekst3 = c("Magdalena", "Lena", "1Lena.csv", "LLena", "Helena", "Anna", "99")
  str_detect(tekst3, pattern = "^L")
})
```

<img src="figures/reprex3.png" width="\textwidth" style="display: block; margin: auto;" />

## Proces debugowania

Nie ma uniwersalnego procesu debugowania, który działa dla każdego napotkanego problemu programistycznego. 
Można jednak określić kilka kroków, które mogą znacząco ułatwić debugowanie:

1. Powtarzalność błędu
2. Identyfikacja przyczyny błędu
3. Usunięcie błędu
4. Weryfikacja naprawy błędu i jej konsekwencji

W pierwszym kroku warto się upewnić, że napotkany błąd nie jest spowodowany przez inne obiekty w środowisku R. 
Należy wyczyścić środowisko R używając `rm(list = ls())` a następnie zresetować sesję R (CTRL+SHIFT+F10 w RStudio).
Warto też wydzielić z kodu najmniejszy fragment, który pozwala na odtworzenie błędu (*powtarzalny przykład*). 
Teraz należy jeszcze raz spróbować użyć kodu zwracającego błąd, aby się upewnić, że dalej istnieje.

Drugi krok obejmuje zlokalizowanie dokładnego miejsca w którym błąd powstaje. 
Może to być konkretna linia kodu, miejsce w pętli, a czasem nawet wywołanie innej zewnętrznej funkcji.
Ten krok można wykonać na wiele sposobów. 
Dwa z nich, debugowanie używając funkcji takich jak print (sekcja \@ref(debuging-print)) i debugowanie interaktywne (sekcja \@ref(debugger)), są opisane w tym rozdziale.

W trzecim kroku należy usunąć wcześniej zlokalizowany błąd.
Nie powinien to być jednak ostatni krok.

Należy jeszcze upewnić się, że nowa wersja kodu nie tylko przestaje zwracać błędy, ale też daje poprawne wyniki.
Często odbywa się to poprzez wykonanie wcześniej stworzony testów jednostkowych (sekcja \@ref(testy-jednostkowe)).

## Podstawowe podejście do debugowania {#debuging-print}

Klasycznym podejściem do debugowania jest dodanie funkcji `print()` pokazującej wartości obiektów w okolicy potencjalnego źródła błędu.
Dalej warto zaplanować jakie testy kodu wykonać, aby wyłapać dokładne miejsce wystąpnienia błędu.
Trzeba też zapisywać potencjalne wyniki.
Takie systematyczne podejście może zaoszczędzić dużo czasu w porównaniu do losowego testowania różnych wartości w kodzie.

Oprócz funkcji `print()` można też wykorzystać funkcję `cat()` w przypadku małych obiektów lub funkcję `str()` w przypadku większych obiektów.

<!-- `traceback()` - bottom to top -->

## Debugger {#debugger}

R posiada także wbudowany debugger - program analizujący kod w celu odnalezienia zawartych w nim błędów.
Pozwala on na wejście do środka wykonywanych funkcji, śledzenie i edycję wartości poszczególnych obiektów oraz wykonywanie kodu linia po linii.


```r
inch_to_mm = function(x) {
  if (x < 0){
    stop("Wartość poniżej 0 nie jest możliwa")
  }
  x * 25.4
}
```



```r
fun1 = function(x){
  fun2(x)
}
fun2 = function(x){
  fun3(x)
}
fun3 = function(x){
  inch_to_mm(x)
}
```


```r
fun1(1)
#> [1] 25.4
```


```r
fun1(-1)
#> Error in inch_to_mm(x): Wartość poniżej 0 nie jest możliwa
```


```r
traceback()
#> No traceback available
```

Debug -> On Error -> Error Inspector

<img src="figures/debugger1.png" width="\textwidth" style="display: block; margin: auto;" />

Interaktywny debugger w RStudio można uruchomić klikając na "Rerun with Debug".
W tym momencie cały kod jest ponownie uruchamiany i zatrzymywanyw miejscu gdzie błąd powstał. 
Teraz w oknie Environment można znaleźć dwie grupy informacji: istniejące obiekty oraz Traceback zawierający ... . <!-- add later-->

Dodatkowo konsola R wygląda inaczej niż zwykle. 
Pod informacją o błędzie wyświetił się tekst `Browse[1]>`, a nad oknem konsoli pojawił się szereg ikon.

<img src="figures/debugger2.png" width="\textwidth" style="display: block; margin: auto;" />

- Pierwsza ikona "Next", skrót klawiaturowy `n`, wykonuje kolejny krok obliczeń
- Druga ikona, `s`, działa podobnie do "Next", z tym wyjątkiem, że gdy kolejny krok obliczeń jest funkcją to wtedy pozwala ona na wejście do tej funkcji i sprawdzenie jej interaktywnie
- Trzecia ikona, `f`, kończy działanie obecnej funkcji lub pętli
- Czwarta ikona, `c`, wyłącza interaktywny debugger ale pozwala na dalsze wykonywanie działań wewnątrz funkcji
- Ostatnia ikona, `Q`, kończy działanie debuggera
<!-- ## inside R -->

<!-- `browser()` -->

<!-- `n` - next statement -->
<!-- `c` - continue -->
<!-- `s` step into function call -->
<!-- `f` finish loop/funciton -->
<!-- `where` previous calls -->
<!-- `Q` quit debugger -->

<!-- + RStudio gui -->
<!-- + brakepoints -->

<!-- ## inside R 2-->

<!-- `debug()`, `trace()`, `recover()` -->

## Zadania

<!-- create debugging examples - .R files -->
<!-- https://github.com/jimhester/wtf-debugging -->
