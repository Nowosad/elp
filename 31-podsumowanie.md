# Podsumowanie {#podsumowanie}

Nie jest możliwe, aby jedna książka wyczerpująco pokazywała wszystkie elementy języka programowania i podawała wszelkie jego możliwości i zastosowania. 
Jest to szczególnie nieosiągalne w przypadku takiego języka jak R, który posiada ogromny zbiór pakietów, oraz społeczność, która używa ten język na wiele sposobów<!--, co wpływa na jego ewolucję-->.
Celem tego rozdziału jest wskazanie co można zrobić dalej na podstawie uzyskanej wiedzy i umiejętność z tej książki. 

<!--co było-->
<!-- W jaki sposób można najbardziej efektywnie użyć wiedzę z tej książki?  -->
<!-- Stosując uzyskane umiejętności w praktyce.  -->
<!-- Może to być... -->

## Grafika

Jedną z najczęściej wymienianych zalet R są jego rozbudowane narzędzia do tworzenia wykresów.
Możemy to zobaczyć na poniższym przykładzie danych meteorologicznych dla Poznania i Zakopanego z roku 2017.


```r
met = read.csv("https://github.com/Nowosad/elp/raw/master/pliki/dane_meteo.csv")
head(met)
#>   kod_stacji nazwa_stacji  rok miesiac dzien tavg
#> 1  352160330       POZNAŃ 2017       1     1  1.4
#> 2  352160330       POZNAŃ 2017       1     2  0.1
#> 3  352160330       POZNAŃ 2017       1     3  0.5
#> 4  352160330       POZNAŃ 2017       1     4  1.5
#> 5  352160330       POZNAŃ 2017       1     5 -3.5
#> 6  352160330       POZNAŃ 2017       1     6 -8.4
#>   precip
#> 1    0.0
#> 2    0.0
#> 3    4.8
#> 4    2.3
#> 5    0.0
#> 6    0.0
```

Wewnątrz obiektu `met` znajdują się kolumny `tavg` (określająca średnią dobową temperaturę powietrza w stopniach Celsjusza) oraz `nazwa_stacji` ("POZNAŃ" lub "ZAKOPANE").
Do porównania wartości temperatury pomiędzy stacjami może posłużyć wykres pudełkowy, stworzony przy pomocy funkcji `boxplot()`  (rycina \@ref(fig:plotex)).
Poniżej zdefiniowano, która zmienna ma zostać zwizualizowana (`tavg`) w podziale na jakie grupy (`nazwa_stacji`) z jakiego zbioru danych (`met`)^[Kod `tavg ~ nazwa_stacji` można inaczej odczytać jako `tavg` w zależności od `nazwa_stacji`.].


```r
boxplot(tavg ~ nazwa_stacji, data = met)
```

<div class="figure" style="text-align: center">
<img src="31-podsumowanie_files/figure-html/plotex-1.png" alt="Przykład wykresu utworzonego przy pomocy funkcji boxplot()." width="\textwidth" />
<p class="caption">(\#fig:plotex)Przykład wykresu utworzonego przy pomocy funkcji boxplot().</p>
</div>

Powyższy wykres może być zmodyfikowany używając dodatkowych argumentów (np. `main` dodający tytuł czy `col` zmieniający kolor pudełek) czy też dodatkowych funkcji pozwalających na dodanie legendy (funkcja `legend`) czy też tekstu (funkcja `text`).
Inne dostępne wbudowane funkcje do tworzenia wykresów to, między innymi, `hist()` czy `barplot()` budujące histogramy oraz wykresy słupkowe.

Najbardziej elastyczną funkcją do tworzenia wykresów w R jest `plot()`.
Domyślnie, gdy użytkownik poda wartości numeryczne dla argumentów `x` i `y` pozwala ona tworzyć wykresy punktowe.
Jej zachowanie i wynik będzie jednak inne w zależności od tego jakiej klasy będzie obiekt wejściowy, przykładowo inaczej wyświetlony zostanie model liniowy, efekt grupowania hierarchicznego, czy też wynik testu statystycznego.
<!-- (więcej na temat metod można przeczytać w sekcji \@ref(inne-klasy) oraz \@ref(oop)) -->

Oprócz wbudowanych <!--uproszczenie--> w R funkcji graficznych, istnieje też szereg dodatkowych pakietów służących do wizualizacji danych.
Wśród nich najpopularniejszym jest **ggplot2** [@R-ggplot2].
Ten pakiet jest implementacją założeń zawartych w książce Grammar of Graphics [@wilkinsonGrammarGraphics2005]<!--moremoremore-->.
Główną funkcją tego pakietu jest `ggplot()`, która przyjmuje dane wejściowe w postaci ramki danych.
Wewnątrz tej funkcji następuje wywołanie kolejnej funkcji `aes`, gdzie definiowane są kolejne kolumny, które mają być wyświetlone na osiach wykresów oraz określają kolor, kształt, wielkość i inne elementy.
Kolejnym krokiem jest określenie typu wykresu poprzez połączenie poprzedniej funkcji (używając operatora `+`) z jedną z wielu funkcji rozpoczynających się od `geom_`.
Przykładowo, do stworzenia wykresu pudełkowego służy `geom_boxplot()` (rycina \@ref(fig:ggplotex)).


```r
library(ggplot2)
ggplot(met, aes(nazwa_stacji, tavg)) + geom_boxplot()
```

<div class="figure" style="text-align: center">
<img src="31-podsumowanie_files/figure-html/ggplotex-1.png" alt="Przykład wykresu utworzonego z użyciem pakietu ggplot2." width="\textwidth" />
<p class="caption">(\#fig:ggplotex)Przykład wykresu utworzonego z użyciem pakietu ggplot2.</p>
</div>

Pełna dokumentacja pakietu **ggplot2** znajduje się na stronie https://ggplot2.tidyverse.org/.

## Analiza danych

R jest jednym z języków programowania najczęściej używanych w analizie danych^[Analiza danych często jest określana również jako [data science](https://en.wikipedia.org/wiki/Data_science).].
Jest to wynikiem szeregu przyczyn, w tym dużej liczby wbudowanych w R funkcji statystycznych oraz graficznych.
Dodatkowo, ramka danych, jeden z podstawowych obiektów w R, może być utożsamiany z arkuszem kalkulacyjnym czy tabelą z bazy danych - najpopularniejszych form przechowywania różnorakich danych.
Ta forma obiektu, złożonego z kolumn (zmienne) i wierszy (obserwacje), jest reprezentacją, która uławia czyszczenie, przetwarzanie i analizowanie danych.

Inną przyczyną popularności R do analizy danych jest grupa pakietów zbiorczo określana jako *tidyverse*.
Jest to spójny zbiór pakietów pozwalających na wykonywanie kolejnych czynności analizy danych.
Na samym początku obejmuje to pakiety poświęcone wczytywaniu danych w różnych formatach, w tym poznane w rozdziale \@ref(io) pakiety **readr** [@R-readr] oraz **readxl** [@R-readxl].
Kolejnym krokiem jest porządkowanie danych, polegające, na przykład, na zmianie struktury ramki danych gdzie wartości jakiejś zmiennej stają się nazwami kolumn.
W tym etapie można użyć pakiet **tidyr** [@R-tidyr].

Dane w odpowiedniej postaci można następnie przetwarzać, np. tworzyć nowe zmienne na postawie przeliczania już istniejących czy też wyliczać ich podsumowania używając pakietu **dplyr** [@R-dplyr].
Tak przetworzone dane następnie są często wizualizowane używając pakietu **ggplot2** [@R-ggplot2] lub też w ich oparciu budowane są [modele](https://github.com/tidymodels/tidymodels).
Ma to na celu zrozumienie posiadanych danych oraz zależności czy zjawisk które opisują.

<!-- FIG? -->

W ramach grupy pakietów **tidyverse** często stosuje się operator `%>%` (ang. *pipe*) z pakietu **magrittr** [@R-magrittr]. 
Pozwala on na łączenie kilku oddzielnych funkcji w jedno zapytanie.
Działanie tego operatora polega na tym, że wynik jednej działania jednej funkcji staje się automatycznie pierwszym argumentem w kolejnej funkcji (rycina \@ref(fig:tidyverse-example)).
<!-- footnote o wywołaniu funkcji -->
<!-- KOD? -->

```r
library(magrittr)
readxl::read_excel("https://github.com/Nowosad/elp/raw/master/pliki/dane_meteo.xlsx") %>% 
  tidyr::gather(key = "zmienna", value = "wartosc", tavg:precip) %>%
  dplyr::mutate(data = as.Date(paste(rok, miesiac, dzien, sep = "-"))) %>% 
  ggplot2::ggplot(ggplot2::aes(data, wartosc)) +
  ggplot2::geom_line() +
  ggplot2::facet_grid(zmienna~nazwa_stacji, scale = "free_y")
```

<div class="figure" style="text-align: center">
<img src="images/tidyverse-example.png" alt="Przykład wyniku użycia pakietów z grupy tidyverse." width="\textwidth" />
<p class="caption">(\#fig:tidyverse-example)Przykład wyniku użycia pakietów z grupy tidyverse.</p>
</div>

Pełne wprowadzenie do koncepcji *tidyverse* można znaleźć w książce [R for Data Science](https://r4ds.had.co.nz/) [@wickham2016r].

<!-- rmarkdown -->
Zrozumienie zależności czy zjawisk jest bardzo rzadko ostatnim etapem - równie istotne jest przekazanie tych wyników wybranej grupie odbiorców<!--communicate--> w odpowiedni sposób.
Do tego celu może posłużyć R Markdown (jego podstawy zostały opisane w sekcji \@ref(dokumentacja-pakietu))
R Markdown pozwala na tworzenie dokumentów w różnych formatach (html, pdf, docx, itd.), prezentacji, stron internetowych, książek^[Ta książka również powstała używająć R Markdown.] i wiele innych.
Po szczegółowe instrukcje jak używać tego języka warto zajrzeć do książki
[R Markdown: The Definitive Guide](https://bookdown.org/yihui/rmarkdown/) [@xieMarkdownDefinitiveGuide2018].

## Inne zastosowania

Wcześniejsze dwie sekcje pokazywały bardzo szerokie zastosowania R - analizować czy wizualizować można zarówno dane o temperaturze powietrza jak i wyniki wyborów prezydenckich.
<!-- ... -->
W związku z czym, w R istnieje także znacząca liczba pakietów stworzonych do bardziej specjalistycznych i szczegółowych celów.
Można to zobaczyć przeglądając tzw. *task views* - listy pakietów zagregowane według podobnej tematyki znajdujące się pod adresem  https://cran.r-project.org/web/views/.
Obejmuje to bardzo szeroki przekrój tematów - od list poświęconych projektowaniu prób klinicznych, poprzez przetwarzanie języka naturalnego, skończywszy na ekonometrii i analizach finansowych^[Dodatkowo istnieje specjalne repozytorium Bioconductor poświęcone pakietom R dotyczącym zagadnień bioinformatycznych.].

<!-- maps -->
Wśród tych list znajduje się także jedna poświęcona analizie danych przestrzennych.
Opisuje ona, między innymi, takie pakiety jak **sf**, pozwalający na wczytywanie, przetwarzanie i zapisywanie danych wektorowych czy **tmap** ułatwiający tworzenie map.
Na poniższym przykładzie następuje dołączenie tych pakietów oraz wczytanie zbioru danych `World` zawierającego poligony krajów na świecie i podstawowe informacje o nich.
Dalej następuje dodanie tych danych do wyświetlenia i wybór odwzorowania przestrzennego<!--footnote--> używając funkcji `tm_shape()`, po czym te dane są wyświetlone w postaci poligonów (funkcja `tm_polygons()`), gdzie kolory poligonów wynikają z ich wartości w kolumnie `life_exp` a tytuł legendy jest wybrany przez nas (rycina \@ref(fig:tmap-example)).


```r
library(sf)
library(tmap)
data(World)
tm_shape(World, projection = "robin") + 
    tm_polygons(col = "life_exp", 
                title = "Oczekiwana dalsza \ndługość życia")
```

<div class="figure" style="text-align: center">
<img src="images/tmap-example.png" alt="Przykład działania pakietu tmap." width="\textwidth" />
<p class="caption">(\#fig:tmap-example)Przykład działania pakietu tmap.</p>
</div>

Podstawy działania na danych przestrzennych zawiera książka [Geocomputation with R](https://geocompr.robinlovelace.net/) [@lovelace2019geocomputation].

## Programowanie w R

Wcześniejsze sekcje opisywały różne obszary zastosowań R, ale nie pokazywały w jaki sposób rozwijać umiejętności programowania w tym języku.
Najprostszym sposobem jest używanie R jak najczęściej.
Nauka języka programowania przebiega wówczas naturalnie - wraz ze znaleziskiem rozwiązania kolejnego problemu czy rozwiązaniem kolejnego zadania. 
<!-- functional programming - 05 -->
<!-- tidy eval -->
<!-- how to keep up-to-date-->

Często jednak, nie jesteśmy w stanie stwierdzić czy ten sposób rozwiązania jest optymalny, lub też napotykamy sytuacje w których nie wiemy jak się do nich odnieść.
Wówczas szczególnie istotna jest inna umiejętność - czytania kodu innych osób^[Read the Source, Luke.].
Większość pakietów R jest otwartoźródłowych - ich kod jest dostępny online i każda chętna osoba ma do niego dostęp^[Dostępny jest także kod źródłowy samego języka R. 
Można go znaleźć pod adresem https://github.com/wch/r-source.].
Kod pakietów R można, między innymi, znaleźć w serwisie GitHub.
Wszystkie pakiety znajdujące się w repozytorium CRAN można znaleźć pod adresem https://github.com/cran.
Inną możliwością jest samodzielne wyszukanie kodu pakietu używając wyszukiwarki GitHub - https://github.com/search.

Przykładowo, pod adresem https://github.com/karthik/wesanderson znajduje się kod źródłowy pakietu **wesanderson** [@R-wesanderson]. 
Ten pakiet zawiera funkcje tworzące palety kolorystyczne inspirowane filmami reżysera [Wesa Andersona](https://en.wikipedia.org/wiki/Wes_Anderson).
Kod R będący podstawą działania tego pakietu znajduje się w folderze `R/`^[Szczególnie `R/colors.R`.].
Dodatkowo, niektóre pakietu zawierają kod z innych języków programowania (np. C lub C++), który wymaga wcześniejszej kompilacji.
Taki kod znajduje się w folderze `src/`.

## Co dalej?

Programowanie to nie tylko pisanie kodu. 
Obejmuje to też wiele innych czynności, takich jak stosowanie optymalnych algorytmów czy narzędzi programistycznych.
Istnieje wiele książek poświęconych kwestii algorytmów, wśród których najbardziej popularne to Introduction to Algorithms [@cormen2009introduction], The Algorithm Design Manual [@skienaAlgorithmDesignManual2008] czy Algorithms [@032157351X].
Podstawowym narzędziem programistycznym jest program do pisania kodu.
Może to być zarówno prosty edytor tekstu, taki jak [Notepad++](https://notepad-plus-plus.org/), [Sublime Text](https://www.sublimetext.com/), lub [Atom](https://atom.io/) czy też bardziej złożone zintegrowane środowisko programistyczne (IDE). 
O ile narzędzia z tej pierwszej grupy są uniwersalne to w przypadku wyboru IDE warto zdecydować się na zintegrowane środowisko programistyczne odpowiednie dla używanego języka programowania^[https://en.wikipedia.org/wiki/Comparison_of_integrated_development_environments].

Programowanie często obejmuje pracę w zespole.
Wówczas jednym ze sposobów dbania o jakość tworzonego produktu może być inspekcja kodu (ang. *code review*). 
Polega ona na tym, że zmiany naniesione w kodzie są przekazywane innej osobie, która sprawdza go pod kątem błędów, spójności, stylu, zgodności z istniejącymi rozwiązaniami, itd.
Po inspekcji twórca kodu może dostać informację zwrotną, co jest dobre, a co wymaga poprawy.
W efekcie, z jednej strony wyjściowy produkt jest lepszej jakości, a z drugiej strony programista uczy się i polepsza swoje umiejętności.

Niezależnie od używanego języka istnieje również szereg narzędzi, których znajomość ułatwia lub czasem nawet umożliwia pracę.
Wśród nich można wyróżnić znajomość linii komend i jej możliwości [@krossUnixWorkbench2017] oraz języka SQL służącego do tworzenia, edycji i zarządzania relacyjnymi bazami danych [@beighley2007head;@forta2013sams].
<!-- uczenie maszynowe -->
<!-- zrównoleglanie (hcp) -->

Innym kierunkiem działań może być nauka kolejnego języka programowania - najlepiej takiego, którego główne zastosowanie różni się od R.
Może to być przykładowo język kompilowany, taki jak C, C++ lub Rust, którego efektem będzie bardziej wydajny<!--...--> program.
Co ważne, kod napisany w tych językach można łączyć z kodem R.
R posiada wbudowany interfejs do używania kodu napisanego w C (rozdział 5 z dokumentacji [Writing R Extensions](https://cran.r-project.org/doc/manuals/R-exts.html#System-and-foreign-language-interfaces) [@team1999writing]), łączenie kodu napisanego w C++ ułatwia znacząco pakiet **Rcpp** (@R-Rcpp; więcej informacji w rozdziale ["Rewriting R code in C++"](https://adv-r.hadley.nz/rcpp.html) książki Advanced R [@wickham2014advanced]), a wskazówki dotyczące łączenia kodu Rust można znaleźć w repozytorium https://github.com/r-rust/hellorust.
W efekcie użytkownik może korzystać z interaktywności R, wykonując dowolne linie kodu, ale część z nich może używać wydajniejszych funkcji napisanych w językach kompilowanych.
Alternatywną drogą może być nauka języków używanych do tworzenia i rozwijania aplikacji internetowych, w tym JavaScript czy PHP.

Pomimo już znaczącej historii, języki programowania nadal mają wiele nowego do zaoferowania.
Nieustannie następuje ich ewolucja <!--nowe wersje R czy Pythona; nowe standardy c++-->- dodawane są nowe możliwości, zmieniane są istniejące funkcje, czy też następuje poprawa wydajności.
Tworzone są również pakiety, moduły, czy biblioteki implementujące nowe pomysły, czy też ulepszające i rozszerzające dostępne oprogramowanie.
W efekcie typowy kod napisany w danym języku kilka lat temu może się różnić od tego napisanego dziś.
Powstaje też ciągle wiele nowych języków, z których tylko niewielka część zdobywa szersze grono użytkowników.
Te języki często wprowadzają nowe podejścia i koncepcje, które później mają bezpośredni wpływ na zmiany w istniejących językach.
Języki programowania są też stosowane coraz częściej w wielu codzienne używanych sprzętach, w tym samochodach czy lodówkach (ang. *internet of things*, IOT).

<!--PORADY -->
<!-- - Don’t try to learn everything at once. -->
<!-- - Separate problems into achievable chunks.  -->
<!-- - Don’t be afraid to break things. -->
<!-- - Never repeat anything more than once. -->
<!-- - take breaks -->
<!-- - work in team -->

Powodzenia w dalszej przygodzie z programowaniem!
