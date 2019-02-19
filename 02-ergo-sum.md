
# R ergo sum {#ergosum}

<!-- kod nie przyjmuje literówek -->

## Wyrażenia

<!-- - wyrażenia (e.g. 2 + 2) -->


```r
2 + 2
#> [1] 4
```


```r
1 - 3
#> [1] -2
```


```r
5 * 5
#> [1] 25
```


```r
42 / 5
#> [1] 8.4
```

## Obiekty

<!-- - obiekty (zmienne) -->
<img src="images/obiekty.png" width="100%" style="display: block; margin: auto;" />

### Operator przypisania

Operator przypisania służy do nadania wartości do obiektu<!--^[uproszczenie - https://adv-r.hadley.nz/names-values.html#binding-basics]-->.
R posiada trzy operatory przypisania, które mają niemal identyczne działanie^[footnote]: `=`, `<-`, `->`.


```r
x = 7
```


```r
x
#> [1] 7
```


```r
y = x
```


```r
y
#> [1] 7
```

<!-- - operator przypisania + działanie w pamięci -->

<!-- block - nazywanie obiektów -->
<!-- nie może się zaczynać numerem -->
<!-- nie może używać specjalnych symbolii ^, !, $, @, +, -, /, lub * -->

### Działania na obiektach

<!-- - działania na obiektach -->


```r
z1 = x + 3
z1
#> [1] 10
```


```r
z2 = x - 5
z2
#> [1] 2
```


```r
z3 = x * 2
z3
#> [1] 14
```


```r
z4 = x / 4.4
z4
#> [1] 1.59
```


```r
z5 = x %% 3
z5
#> [1] 1
```


```r
z6 = x %/% 3
z6
#> [1] 2
```


```r
z7 = x ^ 2
z7
#> [1] 49
```


```r
z8 = sqrt(x)
z8
#> [1] 2.65
```


```r
z9 = c(z2, z4, z8)
z9
#> [1] 2.00 1.59 2.65
```

<!-- integer division block -->
<!-- floating-point errors, -->
<!-- floating-point arithmetic.  -->
<!-- Floating-point arithmetic is a feature of computer programming.  -->

## IDE

Rstudio to zintegorwane środowsko programistyczne (ang. *Integrated Development Environment*, IDE) dla R.
<!-- wyjaśnienie -->
Zawiera ono bardzo wiele użytecznych funkcjonalności, tj. wbudowany edytor, podświetlanie składni, automatyczne uzupełnianie kodu i wiele innych.

<img src="images/rstudio.png" width="100%" style="display: block; margin: auto;" />

<!-- block - RStudio to nie R!! -->


Table: (\#tab:rstudiosk)Podstawowe skróty klawiaturowe w RStudio

Skrót                                 Wyjaśnienie                                                   
------------------------------------  --------------------------------------------------------------
Ctrl+Enter                            wykonuje wybraną linię kodu w skrypcie R                      
Tab                                   uzupełnia kod (podaje pasujące mozliwości)                    
F1                                    wyświetla plik pomocy dla wybranej funkcji                    
Ctrl+Shift+C                          ustawia wybrane linie jako komentarz/odkomentuj fragment kodu 
strzałka Góra/Dół (w oknie konsoli)   wybiera wcześniej wpisany kod                                 
Esc                                   przerwya niedokończoną operację                               

## Pomoc

Polskie książki:

- http://www.biecek.pl/R/ [@biecekPrzewodnikPoPakiecie2014]
- http://www.gagolewski.com/publications/programowanier/ [@gagolewski2016programowanie]
- https://helion.pl/ksiazki/jezyk-r-kompletny-zestaw-narzedzi-dla-analitykow-danych-hadley-wickham-garrett-grolemund,jezrko.htm#format/d [@wickham2016r]
- https://helion.pl/ksiazki/wydajne-programowanie-w-r-praktyczny-przewodnik-po-lepszym-programowaniu-gillespie-colin-lovelace-robin,a_0491.htm#format/d [@gillespie2016efficient]
- https://bookdown.org/nowosad/Geostatystyka/ [@nowosadjakubGeostatystyka2019]

Angielskie książki:

- https://rstudio-education.github.io/hopr/ [@grolemund2014hands]
- https://r4ds.had.co.nz/ [@wickham2016r]
- https://csgillespie.github.io/efficientR/ [@gillespie2016efficient]
- https://adv-r.hadley.nz [@wickham2014advanced]
- https://geocompr.robinlovelace.net/ [@lovelace_geocomputation_2019]

Blogi:

- Agregator blogów dotyczących R - https://www.r-bloggers.com/
- Polski blog opisujący kwestie analizy danych w R, wizualizacji, oraz edukacji - http://smarterpoland.pl/
- Polski blog pokazujący zastosowanie R do analizy i wizualizacji danych - http://szychtawdanych.pl/

Kursy:

- Lista kursów dotyczących R na platformie DataCamp (część z nich jest dostępna bezpłatnie) - https://www.datacamp.com/search?q=r
- Polskie tłumaczenie pakietu R służącego do nauki tego języka - https://github.com/dabrze/swirl
- Lista kursów dotyczących R na platformie Coursera - https://www.coursera.org/courses?query=r
- Lista kursów dotyczących R na platformie edX - https://www.edx.org/course?search_query=r

Serwisy internetowe:

- Wyszukiwarki internetowe są nieocenionym narzędziem wspierającym programowanie - https://rseek.org/, https://duckduckgo.com/, https://www.google.com/, https://www.bing.com/, itd.
- Serwis społecznościowy zawierający pytania i odpowiedzi dotyczące różnych języków programowania w tym R - https://stackoverflow.com.
Pytania dotyczące R można znaleźć pod adresem https://stackoverflow.com/questions/tagged/r. 
Przed zadaniem nowego pytania warto wyszukać czy nie zostało ono zadane wcześniej a następnie przeczytać wątek dotyczący tworzenia nowych pytań - https://stackoverflow.com/questions/5963269/how-to-make-a-great-r-reproducible-example
- Twitter jest miejscem, w którym można znaleźć zarówno nowości z języka R, jak również odpowiedzi na pytania dotyczące tego języka - https://twitter.com/. 
Kwestie związane z R są opatrzone hasztagiem `#rstats`, natomiast kwestie przestrzenne w R są opisywane hasztagami `#rspatial` oraz `#geocompr`
- Lista emailowa dotycząca R - https://stat.ethz.ch/mailman/listinfo/r-help
- Lista emailowa dotycząca kwestii przestrzennych w R - https://stat.ethz.ch/mailman/listinfo/r-sig-geo
- Forum dotyczące kwestii R i RStudio - https://community.rstudio.com/

Meetups (spotkania początkujących i zaawansowanych użytkowników R):

- Poznań - https://www.meetup.com/pl-PL/Poznan-R-User-Group-PAZUR/
- Warszawa - https://www.meetup.com/pl-PL/Spotkania-Entuzjastow-R-Warsaw-R-Users-Group-Meetup/
- Wrocław - https://www.meetup.com/Wroclaw-R-Users-Group/
- Kraków - https://www.meetup.com/erkakrakow/
- Trójmiasto - https://www.meetup.com/Trojmiejska-Grupa-Entuzjastow-R/

## Styl

Poniżej znajdują się podstawowe porady dotyczące stylu pisania kodu. 
Więcej wskazówek można znaleźć na w [poradniku stylu RStudio](https://style.tidyverse.org/) oraz [poradniku stylu Google](https://google.github.io/styleguide/Rguide.xml).
Oba te poradniki nie są identyczne i czasami zawierają sprzeczne porady. 
Najważniejsze jest, aby wybrać jeden odpowiadający piszącemu kod styl i się go konsekwentnie trzymać. 

### Nazwy obiektów

Istnieje wiele konwencji nazywania obiektów^[https://en.wikipedia.org/wiki/Naming_convention_(programming)]. 
Najczęściej używaną konwencją w R jest tzw. ["snake case"](https://en.wikipedia.org/wiki/Snake_case).
Polega ona na tworzeniu nazw obiektów składających się ze słów połączonych znakiem podkreślenia (`_`), np.
<!-- obiekty rzeczowniki, funkcje czasowniki -->
Ważne, żeby nazwy obiektów ułatwiały zrozumienie ich zawartości.


```r
# obiekt
bok_a
bok_b

# funkcja
pole_prostokata
```

Dodatkowo należy uważać, żeby nowa nazwa obiektu nie nadpisała istniejącego obiektu lub funkcji.
Nie powinno nazywać się obiektów, np. `c`, `t`, `table`, itd.

### Odstępy

Odstępy pełnią bardzo ważną funkcję przy pisaniu kodu, podobnie jak odstępy przy pisaniu tekstu.
Wyobraź sobie czytanie powieści, w której nie ma żadnych odstępów między słowami czy rozdziałami.
<!-- indentation python -->
Często mówi się, że "kod musi oddychać" - odstępy zwiększają czytelność kodu i pozwalają na jego szybsze zrozumienie oraz ułatwiają naprawienie występujących błędów.

Odstępy można uzyskać poprzez użycie spacji.
Spacje powinny być użyte po przecinkach, ale nigdy przed nimi. Dodatkowo, większość operatorów (np. `=`, `+`, `-`, `==`) powinna być otoczona przez spacje.


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

Podobnie jak nazwy obiektów, również nazwy plików powinny mieć nazwy opisujące ich zawartość.


```r
# Zalecane
obliczanie-sredniej.R
pomiary-temperatury.csv

# Niewskazane
kod.R
dane.csv
```

Dodatkowo nazwy plików nie powinny zawierać spacji, znaków specjalnych (np. !, %, *), znaków diakrytycznych (np. ć, Ł, ź).
Warto też aby nazwy plików składały się tylko z małych liter.
<!--^[kodowanie znaków]-->

## Zadania

<!-- może użycie podstawowych funkcji na wektorach i co to znaczy - length, paste, etc.? -->
