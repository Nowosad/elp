
# Podsumowanie {#podsumowanie}

Nie jest możliwe, aby jedna książka wyczerpująco pokazywała wszystkie elementy języka programowania i podawała wszelkie jego możliwości i zastosowania. 
Jest to szczególnie nieosiągalne w przypadku takiego języka jak R, który posiada ogromny zbiór pakietów, oraz społeczność, która używa ten język na wiele sposobów, co wpływa na jego ewolucję.
Celem tego rozdziału jest z jednej strony podsumowanie zawartych w niej informacji, ale co ważniejsze wskazanie co można zrobić dalej na podstawie uzyskanej wiedzy i umiejętność z tej książki. 

<!--co było-->

W jaki sposób można najbardziej efektywnie użyć wiedzę z tej książki? 
Stosując uzyskane umiejętności w praktyce. 
<!-- Może to być... -->

## Grafika

Jedną z najczęściej wymienianych zalet R są jego rozbudowane narzędzia do tworzenia wykresów.
Możemy to zobaczyć na poniższym przykładzie danych meteorologicznych dla Poznania i Zakopanego z roku 2017.


```r
met = read.csv("https://github.com/Nowosad/elp/raw/master/pliki/dane_meteo.csv",
             stringsAsFactors = FALSE)
head(met)
#>   kod_stacji nazwa_stacji  rok miesiac dzien tavg precip
#> 1  352160330       POZNAŃ 2017       1     1  1.4    0.0
#> 2  352160330       POZNAŃ 2017       1     2  0.1    0.0
#> 3  352160330       POZNAŃ 2017       1     3  0.5    4.8
#> 4  352160330       POZNAŃ 2017       1     4  1.5    2.3
#> 5  352160330       POZNAŃ 2017       1     5 -3.5    0.0
#> 6  352160330       POZNAŃ 2017       1     6 -8.4    0.0
```

Wewnątrz obiektu `met` znajdują się kolumny `tavg` (określająca średnią dobową temperaturę powietrza w stopniach Celsjusza) oraz `nazwa_stacji` ("POZNAŃ" lub "ZAKOPANE").
Do porównania wartości temperatury pomiędzy stacjami może posłużyć wykres pudełkowy, stworzony przy pomocy funkcji `boxplot()`.
Poniżej zdefiniowano, która zmienna ma zostać zwizualizowana (`tavg`) w podziale na jakie grupy (`nazwa_stacji`) z jakiego zbioru danych (`met`)^[Kod `tavg ~ nazwa_stacji` można inaczej odczytać jako `tavg` w zależności od `nazwa_stacji`.].


```r
boxplot(tavg ~ nazwa_stacji, data = met)
```

<img src="figures/unnamed-chunk-3-1.png" width="100%" style="display: block; margin: auto;" />

Powyższy wykres może być zmodyfikowany używając dodatkowych argumentów (np. `main` dodający tytuł czy `col` zmieniający kolor pudełek) czy też dodatkowych funkcji pozwalających na dodanie legendy (funkcja `legend`) czy też tekstu (funkcja `text`).
Inne dostępne wbudowane funkcje do tworzenia wykresów to, między innymi, `hist()` czy `barplot()` budujące histogramy oraz wykresy słupkowe.

Najbardziej elastyczną funkcją do tworzenia wykresów w R jest `plot()`.
<!-- Domyślnie  -->
<!-- explain -->

Oprócz wbudowanych <!--uproszczenie--> w R funkcji graficznych, istnieje też szereg dodatkowych pakietów służących do wizualizacji danych.
Wśród nich najpopularniejszym jest **ggplot2** [@R-ggplot2].
Ten pakiet jest implementacją założeń zawartych w książce Grammar of Graphics [REF???]<!--moremoremore-->.
Główną funkcją tego pakietu jest `ggplot()`, która przyjmuje dane wejściowe w postaci ramki danych.
Wewnątrz tej funkcji następuje wywołanie kolejnej funkcji `aes`, gdzie definiowane są kolejne kolumny, które mają być wyświetlone na osiach wykresów oraz określają kolor, kształt, wielkość i inne elementy.
Kolejnym krokiem jest określenie typu wykresu poprzez połączenie poprzedniej funkcji (używając operatora `+`) z jedną z wielu funkcji rozpoczynających się od `geom_`.
Przykładowo, do stworzenia wykresu pudełkowego służy `geom_boxplot()`.


```r
library(ggplot2)
ggplot(met, aes(nazwa_stacji, tavg)) + geom_boxplot()
```

<img src="figures/unnamed-chunk-4-1.png" width="100%" style="display: block; margin: auto;" />

Pełna dokumentacja pakietu **ggplot2** znajduje się na stronie http://docs.ggplot2.org.

## Analiza danych

R jest jednym z języków programowania najczęściej używanych w analizie danych<!--datascience--><!--REF???-->.
Jest to wynikiem szeregu przyczyn, w tym dużej liczby wbudowanych w R funkcji statystycznych oraz graficznych.
Dodatkowo, ramka danych, jeden z podstawowych obiektów w R, może być utożsamiany z arkuszem kalkulacyjnym czy tabelą z bazy danych - najpopuarniejszych form przechowywania różnorakich danych.
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
Działanie tego operatora polega na tym, że wynik jednej działania jednej funkcji staje się automatycznie pierwszym argumentem w kolejnej funkcji.
<!-- footnote o wywołaniu funkcji -->
<!-- KOD? -->



Pełne wprowadzenie do koncepcji *tidyverse* można znaleźć w książce [R for Data Science](https://r4ds.had.co.nz/) [@wickham2016r].

<!-- rmarkdown -->
Zrozumienie zależności czy zjawisk bardzo rzadko jest ostatnim etapem - równie istotne jest przekazanie tych wyników właściwej grupie odbiorców<!--communicate-->.
<!-- ... -->
<!-- rmarkdown co to -->
<!-- markdown co to -->

## Inne zastosowania

Wcześniejsze dwie sekcje pokazywały bardzo szerokie zastosowania R - analizować czy wizualizować można zarówno dane o temperaturze powietrza jak i wyniki wyborów prezydenckich.
<!-- ... -->
W związku z czym, w R istnieje także znacząca liczba pakietów stworzonych do bardziej specjalistycznych i szczegółowych celów.
Można to zobaczyć przeglądając tzw. *task views* - listy pakietów zaagregowane według podobnej tematyki znajdujące się pod adresem  https://cran.r-project.org/web/views/.
<!-- co tam jest -->
<!-- bioinformatyka -->
<!-- https://www.bioconductor.org/ -->
<!-- https://en.wikipedia.org/wiki/Bioconductor -->
<!-- może footnote tylko -->

<!-- maps -->
Wsród tych list znajduje się także jedna poświęcona analizie danych przestrzennych.
Opisuje ona, między innymi, takie pakiety jak **sf**, pozwalający na wczytywanie, przetwarzanie i zapisywanie danych wektorowych czy **tmap** ułatwiający tworzenie map.
Na poniższym przykładzie następuje dołączenie tych pakietów oraz wczytanie zbioru danych `World` zawierającego poligony krajów na świecie i podstawowe informacje o nich.
Dalej następuje dodanie tych danych do wyświetlenia i wybór odwzorowania przestrzennego<!--footnote--> używając funkcji `tm_shape()`, po czym te dane są wyświetlone w postaci poligonów (funkcja `tm_polygons()`), gdzie kolory poligonów wynikają z ich wartości w kolumnie `life_exp` a tytuł legendy jest wybrany przez nas.


```r
library(sf)
library(tmap)
data(World)
tm_shape(World, projection = "robin") + 
    tm_polygons(col = "life_exp", 
                title = "Oczekiwana dalsza \ndługość życia")
```

<!-- geocompr -->

## Programowanie

Wcześniejsze sekcje opisywały różne obszary zastosowań R, ale nie pokazywały w jaki sposób rozwijać umiejętności programowania w tym języku.
Najprostszym sposobem jest używanie R jak najczęściej.
Nauka języka programowania przebiega wówczas naturalnie - wraz ze znaleziskiem rozwiązania kolejnego problemu czy rozwiązaniem kolejnego zadania. 

Często jednak, nie jesteśmy w stanie stwierdzić czy ten sposób rozwiązania jest optymalny, lub też napotykamy sytuacje w których nie wiemy jak się do nich odnieść.
Wówczas szczególnie istotna jest inna umiejętność - czytania kodu innych osób^[Read the Source, Luke.].
Większość pakietów R jest otwartoźródłowych - ich kod jest dostępny online i każda chętna osoba ma do niego dostęp^[Dostępny jest także kod źródłowy samego języka R. 
Można go znaleźć pod adresem https://github.com/wch/r-source].
Kod pakietów R można, między innymi, znaleźć w serwisie GitHub.
Wszystkie pakiety znajdujące się w repozytorium CRAN można znaleźć pod adresem https://github.com/cran.
Inną możliwością jest samodzielne wyszukanie kodu pakietu używając wyszukiwarki GitHub - https://github.com/search.

Przykładowo, pod adresem https://github.com/karthik/wesanderson znajduje się kod źródłowy pakietu **wesanderson** [@R-wesanderson]. 
Ten pakiet zawiera funkcje tworzące palety kolorystyczne inspirowane filmami reżysera [Wesa Andersona](https://en.wikipedia.org/wiki/Wes_Anderson).
Kod R będący podstawą działania tego pakietu znajduje się w folderze `R/`^[Szczególnie `R/colors.R`.].
Dodatkowo, niektóre pakietu zawierają kod z innych języków programowania (np. C lub C++), który wymaga wcześniejszej kompilacji.
Taki kod znajduje się w folderze `src/`.

<!-- functional programming - 05 -->
<!-- tidy eval -->
<!-- how to keep up-to-date-->

## Co dalej?

Programowanie to nie tylko pisanie kodu. 
Obejmuje to też wiele innych czynności, takich jak stosowanie optymalnych algorytmów czy narzędzi programistycznych.
<!--alogrytmy-->
<!--narzędzia programistyczne-->
<!--współpraca z innymi, e.g. code review-->

Innym kierunkiem działań może być nauka kolejnego języka programowania - najlepiej takiego, którego zastosowanie różni się od R.
<!-- C/C++/Go/Rust -->
<!-- javascript, what else -->
<!-- łącznik -->

Pomimo już znaczącej historii, języki programowania nadal mają wiele nowego do zaoferowania.
<!-- nowe metody -->
<!-- nowe stosowanie -->

Powodzenia w dalszej przygodzie z programowaniem!
