# (PART) Podstawy {-}

# Start R {#ergosum}

Wykonywanie kodu w języku interpretowalnym, jakim jest R, może odbywać się poprzez wpisanie polecenia w oknie konsoli (zwanej też terminalem) i jego uruchomienie^[To jest tzw. tryb interaktywny. 
Istnieje również tryb skryptowy, o którym więcej informacji można znaleźć w kolejnym rozdziale.].
Komendy są najpierw sprawdzanie pod kontekstem ich poprawności.
Polega to na określeniu, np. czy podana funkcja lub inny obiekt istnieje, czy nie zostały użyte niedozwolone znaki, lub czy wszystkie nawiasy czy cudzysłowy zostały zamknięte.
Języki programowania są w tym aspekcie bardziej bezwzględne niż języki naturalne - nie potrafią one zrozumieć wyrażeń zawierających nawet niewielkie błędy takie jak, np. użycie dużej litery zamiast małej.

## Wyrażenia

Podstawowe działania arytmetyczne, dodawanie, odejmowane, mnożenie i dzielenie, są również często używane w wielu językach programowania.
Dla każdej z tych operacji istnieje odpowiedni operator w R.
Operatorem dodawania jest `+`.


```r
2 + 2
#> [1] 4
```

Operatorem odejmowania jest `-`.


```r
1 - 3
#> [1] -2
```

Operatorem mnożenia jest `*`.


```r
5 * 5
#> [1] 25
```

Operatorem dzielenia jest `/`.


```r
42 / 5
#> [1] 8.4
```

Wszystkie powyższe operacje można wykonać poprzez ich wpisanie w oknie konsoli R i naciśnięcie klawisza Enter.

## Obiekty

> "Dwa slogany są pomocne w zrozumieniu obliczeń w R: 1. Wszystko co istnieje jest obiektem. 2. Wszystko co się dzieje jest wywołaniem funkcji." John Chambers

<!-- - obiekty (zmienne) -->


Powyższy cytat sugeruje dwa najważniejsze elementy języka R: obiekty i funkcje.
Zrozumienie w jaki sposób się je tworzy i zmienia będzie w związku z tym, konieczną wiedzą osób piszących w tym języku.

### Operator przypisania

Nadanie wartości do obiektu wykonuje się używając operatora przypisania^[Jest to pewne uproszczenie - https://adv-r.hadley.nz/names-values.html#binding-basics.].
R posiada trzy operatory przypisania, które mają niemal identyczne działanie^[Więcej informacji na temat różnic w działaniu tych operatorów można znaleźć na stronie https://stackoverflow.com/questions/1741820/what-are-the-differences-between-and-in-r.]: `=`, `<-`, `->`.
Warto wybrać jeden z tych operatorów i konsekwentnie używać go pisząc kod.
W tej książce jako główny operator przypisania będzie używany znak `=`.

W poniższej linii stworzony jest nowy obiekt, o nazwie `x`, który zawiera wartość `7`.


```r
x = 7
```

Można to sprawdzić wpisując nazwę tego obiektu.


```r
x
#> [1] 7
```

Operatory przypisania może również posłużyć do nadania wartości z jednego obiektu do drugiego.
Poniżej nowy obiekt `y` przyjmuje wartość od obiektu `x`.


```r
y = x
y
#> [1] 7
```

Język R przechowuje i przetwarza wszystkie obiekty w pamięci komputera (RAM).
Wpływa to na zwiększoną wydajność i elastyczność obliczeń, ale jednocześnie powoduje to ograniczenie wielkości obiektów na jakich można pracować.
Istnieje równocześnie [szereg strategii](https://bookdown.org/rdpeng/RProgDA/working-with-large-datasets.html) jak postępować z większymi zbiorami danych, które nie mieszczą się w RAMie [@pengMasteringSoftwareDevelopment2017].

### Działania na obiektach {#dzialania-na-obiektach}

Każdy stworzony obiekt w R może być następnie używany do kolejnych operacji, a w efekcie też tworzenia nowych obiektów. 
W poniższych czterech przypadkach obiekt `x` został przetworzony używając operatorów dodawania, odejmowania, mnożenia oraz dzielenia, a jako wyniki tych obliczeń powstały nowe obiekty.


```r
z1 = x + 3
z1
#> [1] 10
z2 = x - 5
z2
#> [1] 2
z3 = x * 2
z3
#> [1] 14
z4 = x / 4
z4
#> [1] 1.75
```

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">Część języków programowania, np. C, wymaga zadeklarowania zmiennej przed jej użyciem poprzez podanie jej typu i nazwy.
Wybór typu zmiennej w tych językach może mieć widoczne konsekwencje.
Przykładowo, jeżeli obiekt `x` zostanie zadeklarowany jako liczba całkowita (integer), wynikiem dzielenia `x / 4` będzie `1` zamiast `1.75`.</div>\EndKnitrBlock{rmdinfo}

Działania na obiektach mogą też się odbywać używając innych operatorów oraz różnorodnych funkcji.
Przykładowo, operator zapisywany jako `%%` to modulo, którego celem jest określanie reszty z dzielenia.


```r
z5 = x %% 3
z5
#> [1] 1
```

Operator `%/%` przedstawia dzielenie całkowite.


```r
z6 = x %/% 3
z6
#> [1] 2
```

Operator `^` natomiast wykonuje podniesienie wartości obiektu do wybranej potęgi.


```r
z7 = x^2
z7
#> [1] 49
```

Odwrotnością potęgowania jest pierwiastkowanie. 
W R nie istnieje do tego celu specjalny operator, ale zawiera on funkcję `sqrt()`.


```r
z8 = sqrt(x)
z8
#> [1] 2.65
```

Często używaną funkcją w R jest też `c()`.
Ta funkcja łączy krótsze wektory w dłuższe wektory.


```r
z9 = c(z2, z4, z8)
z9
#> [1] 2.00 1.75 2.65
```

<!-- floating-point errors, -->
<!-- floating-point arithmetic.  -->
<!-- Floating-point arithmetic is a feature of computer programming.  -->

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">Operatory użyte w tym rozdziale, np. `+`, `*`, `^`, `%%` to też są funkcje, ale zapisane w skrótowej formie ułatwiającej z nimi pracę.
Te operatory można też użyć jako normalne funkcje poprzez dodanie znaku zwanego grawisem - "`` ` ``", np. `2 + 2` można też zapisać jako ``` `+`(2, 2)```.
</div>\EndKnitrBlock{rmdinfo}

## IDE

Zintegrowane środowisko programistyczne (ang. *Integrated Development Environment*, IDE) to program ułatwiający pisanie kodu. 
Zawiera on wiele użytecznych funkcjonalności, takich jak wbudowany edytor i konsola, podświetlanie składni, automatyczne uzupełnianie kodu, itd.
Bez IDE kod musi być pisany w jednym programie, a następnie kopiowany i uruchamiany w innym.

Do popularnych IDE dla R należą:

- RStudio
- Emacs + ESS
- vim + Nvim-R
- Visual Studio + RTVS

W tej książce będzimy korzystać z pierwszego z nich.
RStudio to zintegrowane środowisko programistyczne pierwotnie stworzone dla R.

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">RStudio to nie jest to samo co R. 
R jest językiem programowania, podczas gdy RStudio to aplikacja ułatwiająca pisanie kodu.
Możliwe jest używanie R bez RStudio, ale RStudio bez R nie pełni już swojej roli.
Częstą analogią jest porównanie samochodowe, w którym R jest opisywany jako silnik a RStudio jako deska rozdzielcza.</div>\EndKnitrBlock{rmdinfo}

<div class="figure" style="text-align: center">
<img src="images/rstudio-ide.png" alt="Okno RStudio z opisaną funkcjonalnością każdej z jego części." width="\textwidth" />
<p class="caption">(\#fig:rstudioimage)Okno RStudio z opisaną funkcjonalnością każdej z jego części.</p>
</div>

Typowa praca w RStudio często polega na wpisywaniu poleceń do pliku tekstowego widocznego w części skryptowej (rycina \@ref(fig:rstudioimage)), a następnie wykonywaniu kolejnych linii kodu w oknie konsoli używając skrótu klawiaturowego CTRL+ENTER (więcej przydatnych skrótów klawiaturowych można znaleźć w tabeli \@ref(tab:rstudiosk)).
Efektem wykonywania funkcji może być powstanie nowych obiektów, które można zobaczyć w oknie "środowiska" lub też wyświetlenie grafik, które można zobaczyć w oknie "wykresu" (rycina \@ref(fig:rstudioimage)).

Dobrą praktyką pracy z R w RStudio jest też używanie projektów RStudio (ang. *RStudio projects*).
Projekt jest to folder zawierający wszystkie skrypty i pozostałe pliki powiązane z jakimś zadaniem (np. analizą danych, czy stworzeniem nowego pakietu R).
Ułatwia on przenoszenie kodu pomiędzy różnymi komputerami, a także daje dostęp do szeregu dodatkowych możliwości w RStudio.

Aby stworzyć pierwszy projekt RStudio, należy:

1. Kliknąć `File -> New Project`.
2. Wybrać `New Directory`.
3. Wybrać `New Project`.
4. Podać nazwę nowego projektu, np. "programowanie1" oraz wybrać miejsce na dysku, gdzie ma się nowy projekt znajdować.
5. Jeżeli możliwe, to wybrać też opcję `Create a git repository`.
6. Kliknąć `Create Project`.

W ten sposób zostanie utworzony nowy folder wraz z plikiem o nazwie projektu z rozszerzeniem `.Rproj`, np. `programowanie1.Rproj`.
Ten folder staje się też od razu folderem roboczym (więcej na ten temat znajdziesz w rozdziale \@ref(io)).
Otwarcie wcześniej stworzonego projektu ma miejsce poprzez uruchomienie pliku z rozszerzeniem `.Rproj` lub też wybór projektu w prawym górnym rogu RStudio.

<table>
<caption>(\#tab:rstudiosk)Podstawowe skróty klawiaturowe w RStudio</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Skrót </th>
   <th style="text-align:left;"> Wyjaśnienie </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;width: 12em; "> Ctrl+Enter </td>
   <td style="text-align:left;width: 18em; "> Wykonuje wybraną linię kodu w skrypcie R </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 12em; "> Tab </td>
   <td style="text-align:left;width: 18em; "> Uzupełnia kod (podaje pasujące możliwości) </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 12em; "> F1 </td>
   <td style="text-align:left;width: 18em; "> Wyświetla plik pomocy dla wybranej funkcji </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 12em; "> Ctrl+Shift+C </td>
   <td style="text-align:left;width: 18em; "> Ustawia wybrane linie jako komentarz/odkomentuj fragment kodu </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 12em; "> strzałka Góra/Dół (w oknie konsoli) </td>
   <td style="text-align:left;width: 18em; "> Wybiera wcześniej wpisany kod </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 12em; "> Esc </td>
   <td style="text-align:left;width: 18em; "> Przerywa niedokończoną operację </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 12em; "> Shift+Alt+K </td>
   <td style="text-align:left;width: 18em; "> Wyświetla listę skrótów klawiaturowych </td>
  </tr>
</tbody>
</table>

## Styl

Języki programowania pozwalają na napisanie dokładnie tego samego kodu na wiele sposobów.
Przykładowo `z1 = x + 3` ma identyczne działanie jak `z1=x+3`.
Styl pisania kodu obejmuje, między innymi, sposoby nazywania obiektów, stosowania odstępów czy wcięć, czy też pisania komentarzy.
Przyjęcie wybranego stylu pozwala na ułatwienie czytania i zrozumienia kodu oraz zmniejszenie szans na powstawanie w nim błędów.

Poniżej znajdują się podstawowe porady dotyczące stylu pisania kodu. 
Więcej wskazówek można znaleźć na w [poradniku stylu RStudio](https://style.tidyverse.org/) oraz [poradniku stylu Google](https://google.github.io/styleguide/Rguide.xml).
Oba te poradniki nie są identyczne i czasami zawierają sprzeczne porady. 
Najważniejsze jest, aby wybrać jeden odpowiadający piszącemu kod styl i się go konsekwentnie trzymać. 

### Nazwy obiektów {#nazwy-obiektow}

Istnieje wiele konwencji nazywania obiektów^[https://en.wikipedia.org/wiki/Naming_convention_(programming)]. 
Najczęściej używaną konwencją w R jest tzw. ["snake case"](https://en.wikipedia.org/wiki/Snake_case).
Polega ona na tworzeniu nazw obiektów składających się ze słów połączonych znakiem podkreślenia (`_`).
<!-- obiekty rzeczowniki, funkcje czasowniki -->
Ważne, żeby nazwy obiektów ułatwiały zrozumienie ich zawartości.


```r
# obiekt
bok_a
bok_b

# funkcja
pole_prostokata()
```

Nazwa obiektu nie może zaczynać się od liczby, ani nie może używać specjalnych symboli, tj. `^`, `!`, `$`, `@`, `+`, `-`, `/`, czy `*`.
Dodatkowo należy uważać, żeby nowa nazwa obiektu nie nadpisała istniejącego obiektu lub funkcji.
Nie powinno nazywać się obiektów tak jak istniejące funkcje, np. `c`, `t`, `table`, itd.

### Odstępy

Odstępy pełnią bardzo ważną funkcję przy pisaniu kodu, podobnie jak odstępy przy pisaniu tekstu.
Wyobraź sobie czytanie powieści, w której nie ma żadnych odstępów między słowami czy rozdziałami.
<!-- indentation python -->
Często mówi się, że "kod musi oddychać" - odstępy zwiększają czytelność kodu i pozwalają na jego szybsze zrozumienie oraz ułatwiają naprawienie występujących błędów.

Odstępy można uzyskać poprzez użycie spacji.
Spacje powinny być użyte po przecinkach, ale nigdy przed nimi. 
Dodatkowo, większość operatorów (np. `=`, `+`, `-`, `==`) powinna być otoczona przez spacje.


```r
# Zalecane
srednia = mean(wartosc, na.rm = TRUE)
pole = bok_a * bok_b

# Niewskazane
srednia=mean ( wartosc,na.rm=TRUE ) 
pole=bok_a*bok_b
```

Spacje należy również używać do tworzenia wcięć - każde z nich powinno się składać z dwóch spacji.
<!-- tab space war -->


```r
# Zalecane
moja_funkcja = function(x, y, z){
  pod = y / z
  wynik = x * pod
  wynik
}

# Niewskazane
moja_funkcja = function(x, y, z){
pod = y / z
wynik = x * pod
wynik
}
```

Warto także ograniczać długość każdej linii kodu, żeby nie przekraczała ona ok. 80 znaków.
Dzięki temu możliwe jest szybkie przeczytanie kodu czy też jego wydrukowanie.


```r
# Zalecane
bardzo_wazny_wynik = moja_bardzo_wazna_funkcja("pierwszy argument",
                                               b = "drugi argument", 
                                               c = "trzeci argument")

# Niewskazane
bardzo_wazny_wynik = moja_bardzo_wazna_funkcja("pierwszy argument", "drugi argument", "trzeci argument")
```

### Komentarze

Komentarze służą do wyjaśniania istotnych elementów kodu.
Do komentowania w języku R służy operator `#`.


```r
# Mój komentarz
```

### Nazwy plików

Nazwy plików powinny spełniać trzy wymagania - być łatwe (i) do odczytania przez komputer, (ii) do odczytania przez człowieka, (iii) do posortowania.

Nazwy plików nie powinny zawierać spacji, znaków specjalnych (np. !, %, *), znaków diakrytycznych (np. ć, Ł, ź).
Warto też aby nazwy plików składały się tylko z małych liter.


```r
# Zalecane
obliczanie-sredniej.R
pomiary-temperatury.csv

# Niewskazane
Obliczanie Średniej.R
pomiaryTemperatury!.csv
```

Podobnie jak nazwy obiektów, również nazwy plików powinny opisywać ich zawartość.


```r
# Zalecane
obliczanie-sredniej.R
pomiary-temperatury.csv

# Niewskazane
kod.R
dane.csv
```

Dodatkowo wskazane jest dodanie wartości numerycznych przed nazwą pliku, jeżeli pliki mają jakąś kolejność.


```r
# Zalecane
01_przygotowanie-danych.R
02_obliczanie-sredniej.R

# Niewskazane
przygotowanie-danych.R
obliczanie-sredniej.R
```

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">Kodowanie znaków (ang. *character encodings*) jest to sposób prezentacji znaków.
Istnieje szereg różnych standardów kodowania znaków.
Standard ASCII przyporządkowuje liczbom z zakresu 0-127 litery alfabetu angielskiego, cyfry, znaki przestankowe i inne symbole oraz polecenia.
Firma Microsoft stworzyła dodatkowo cały szereg standardów dla różnych języków. 
Przykładowo do obsługi języków środkowoeuropejskich istnieje wersja oznaczona jako Windows-1250 (lub CP1250).
Alternatywnie do systemu Microsoftu powstał też zbiór standardów ISO, przykładowo ISO-8859-2 dla języków środkowoeuropejskich.
W efekcie oznacza to, że otworzenie tekstu z innego komputera, na komputerze z "polskim" kodowaniem znaków może spowodować pojawienie się tzw. "krzaczków".
Aby uniknąć takiej sytuacji powstał system kodowania UTF-8, który zawiera w sobie ponad milion różnych znaków.
Jest on obecnie zalecanym standardem na całym świecie.</div>\EndKnitrBlock{rmdinfo}

### Daty

Istnieje wiele sposobów zapisu dat^[https://xkcd.com/1179/], co może powodować różnorodne problemy przy programowaniu oraz analizie danych.
Z ratunkiem w tej kwestii przychodzi norma [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601), która definiuje daty kalendarzowe jako *YYYY-MM-DD*, czyli *ROK-MIESIĄC-DZIEŃ*.


```r
# Zalecane
2019-06-02

# Niewskazane
wszelkie inne
```

## Dodatkowe materiały {#resources}

Polskie książki:

- http://www.biecek.pl/R/ [@biecekPrzewodnikPoPakiecie2014]
- http://www.gagolewski.com/publications/programowanier/ [@gagolewski2016programowanie]
- https://helion.pl/ksiazki/jezyk-r-kompletny-zestaw-narzedzi-dla-analitykow-danych-hadley-wickham-garrett-grolemund,jezrko.htm#format/d [@wickham2016r]
- https://helion.pl/ksiazki/wydajne-programowanie-w-r-praktyczny-przewodnik-po-lepszym-programowaniu-gillespie-colin-lovelace-robin,a_0491.htm#format/d [@gillespie2016efficient]
- https://bookdown.org/nowosad/Geostatystyka/ [@nowosadGeostatystyka2019]
- http://www.enwo.pl/przetwarzanie/index.html [@czerneckiMetodyPrzetwarzaniaDanych2018]

Angielskie książki:

- https://rstudio-education.github.io/hopr/ [@grolemund2014hands]
- https://r4ds.had.co.nz/ [@wickham2016r]
- https://csgillespie.github.io/efficientR/ [@gillespie2016efficient]
- https://rstats.wtf/ [@rstatswtf]
- https://adv-r.hadley.nz [@wickham2014advanced]
- https://geocompr.robinlovelace.net/ [@lovelace2019geocomputation]

Blogi:

- Agregator blogów dotyczących R - https://www.r-bloggers.com/
- Polski blog opisujący kwestie analizy danych w R, wizualizacji, oraz edukacji - http://smarterpoland.pl/
- Polski blog pokazujący zastosowanie R do analizy i wizualizacji danych - http://szychtawdanych.pl/

Kursy:

- Polskie tłumaczenie pakietu R służącego do nauki tego języka - https://github.com/dabrze/swirl
- Lista kursów dotyczących R na platformie Coursera - https://www.coursera.org/courses?query=r
- Lista kursów dotyczących R na platformie edX - https://www.edx.org/course?search_query=r

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">Pisanie kodu oraz jego dokumentowanie opiera się w znacznym stopniu na wprowadzaniu znaków na klawiaturze do komputera.
Warto jest więc aby robić to w sposób [efektywny](https://csgillespie.github.io/efficientR/introduction.html#touch-typing), czyli taki w którym używamy wszystkich palców u rąk a nasz wzrok nie jest skupiony na klawiaturze.
Takie pisanie nazwa się pisaniem bezwzrokowym (ang. *touch typing*).
Pisanie bezwzrokowe ma szereg reguł, które wymagają przestawienia się ze starych nawyków oraz pewnego treningu. 
Na szczęście istnieje wiele internetowych zasobów, które ułatwiają naukę takiego pisania, między innymi strona [TypingClub](https://www.typingclub.com/).</div>\EndKnitrBlock{rmdinfo}

Serwisy internetowe:

- Wyszukiwarki internetowe są nieocenionym narzędziem wspierającym programowanie - https://rseek.org/, https://duckduckgo.com/, https://www.google.com/, https://www.bing.com/, itd.
- Serwis społecznościowy zawierający pytania i odpowiedzi dotyczące różnych języków programowania w tym R - https://stackoverflow.com.
Pytania dotyczące R można znaleźć pod adresem https://stackoverflow.com/questions/tagged/r. 
Przed zadaniem nowego pytania warto wyszukać czy nie zostało ono zadane wcześniej a następnie przeczytać wątek dotyczący tworzenia nowych pytań - https://stackoverflow.com/questions/5963269/how-to-make-a-great-r-reproducible-example
- Twitter jest miejscem, w którym można znaleźć zarówno nowości z języka R, jak również odpowiedzi na pytania dotyczące tego języka - https://twitter.com/. 
Kwestie związane z R są opatrzone hasztagiem `#rstats`, natomiast kwestie przestrzenne w R są opisywane hasztagami `#rspatial` oraz `#geocompr`
- Elektroniczny biuletyn R Weekly zbierający co tydzień nowości związane z r - https://rweekly.org/
- Lista emailowa dotycząca R - https://stat.ethz.ch/mailman/listinfo/r-help
- Lista emailowa dotycząca kwestii przestrzennych w R - https://stat.ethz.ch/mailman/listinfo/r-sig-geo
- Forum dotyczące kwestii R i RStudio - https://community.rstudio.com/

Meetups (spotkania początkujących i zaawansowanych użytkowników R):

- Poznań - https://www.meetup.com/pl-PL/Poznan-R-User-Group-PAZUR/
- Warszawa - https://www.meetup.com/pl-PL/Spotkania-Entuzjastow-R-Warsaw-R-Users-Group-Meetup/
- Wrocław - https://www.meetup.com/Wroclaw-R-Users-Group/
- Kraków - https://www.meetup.com/erkakrakow/
- Trójmiasto - https://www.meetup.com/Trojmiejska-Grupa-Entuzjastow-R/


## Zadania {#zad2}

Rozwiązując poniższe zadania oraz pozostałe zadania z tej książki staraj się stosować do stylu podanego w sekcji \@ref(styl).

1) Przejrzyj poniższą listę poleceń.
Spróbuj określić uzyskane wyniki bez wykonywania kodu w R.

```r
x = 7
y = -2
x + 3
y - 5
x * 2
y / 4
x %% 3
x %/% 3
y ^ 2
y ^ x
```
2) Jedziesz na krótkie wakacje i planujesz na nie zabrać 500 EUR.
Aktualny kurs kupna EUR wynosi 4,31.
Ile PLN musisz wydać?
Wylicz to w R.
3) Masz trapez o długości podstaw `a = 5` i `b = 6` oraz wysokości `h = 3`.
Stwórz nowy obiekt `pole_trapezu`, który zawiera obliczone pole tego trapezu.
4) Wraz z grupą znajomych planujesz zamówić pizzę z dostawą i macie na to przeznaczonych 50 PLN. 
Pizza o średnicy 30 cm kosztuje 23,5 PLN, a pizza o średnicy 50 cm kosztuje 50 PLN.
Wylicz w R, czy bardziej opłaca się kupno dwóch małych pizz czy jednej dużej.
<!--zadanie z poprawą stylu-->



5) Przejrzyj linki zawarte w tym rozdziale, w szczególności R-bloggers i R Weekly.
Znajdź jeden lub dwa przykłady zastosowania R, które uważasz za ciekawe lub interesujące.
