
# Tekst {#tekst}


Więcej na temat przetwarzania tekstu można znaleźć w rozdziale ["Strings"](https://r4ds.had.co.nz/strings.html) książki R for Data Science [@wickham2016r].

Typ znakowy jest określany poprzez użycie cudzysłowia `"` lub `'`.
Ważne tutaj jest, aby rozpoczynać i kończyć tekst tym samym cudzysłowiem.


```r
t1 = "kot"
t2 = 'pies'
t3 = '"W teorii, teoria i praktyka są tym samym. W praktyce, nie są." - Yogi Berra'
```

W momencie, gdy tekst nie będzie kończył się cudzysłowiem, wykonanie kodu jest niemożliwe.
Wówczas zamiast znaku `>`, oznaczającego nową linię wykonywanego kodu, pojawi się znak `+`.
Oznacza on, że wykonanie kodu nie może zostać zakończone.


```r
> "Mój pierwszy alfabet
+
+
```

W takiej sytuacji należy nacisnąć klawisz Esc, aby przerwać wykonywanie operacji, a następnie poprawić wpisany kod.

## Podstawowe operacje na tekście

Jedną z podstawowych operacji na wektorach znakowych jest ich łączenie.
Do tego celu służy funkcja `paste()`^[Odpowiednikiem funkcji `paste()` w pakiecie **stringr** jest funkcja `str_c()`].


```r
paste("t", "o", " ", "k", "o", "t")
#> [1] "t o   k o t"
```

Efekt działania funkcji `paste()` jest jeden wektor tekstowy, który składa się z wejściowych wektorów oddzielonych domyślnie spacjami. 
Funkcja `paste()` ma jednak również dodatkowy argument `sep`, który pozwala na dowolne określanie separatora.
Ostatnim argumentem tej funkcji jest `collapse`, który łączy elementy jednego wektora tekstowego.

R oferuje też uproszczoną postać tej funkcji o nazwie `paste0()`, w której nie ma znaku seperatora.


```r
paste0("t", "o", " ", "k", "o", "t")
#> [1] "to kot"
```

Te funkcje są używane w sytuacjach, gdy chcemy połączyć stały, znany tekst, wraz z tekstem wprowadzanym przez użytkownika lub pochodzącym z innego źródła.
Poniżej stworzono dwie nowe zmienne `imie` i `wiek`, których treść złączono ze słowami `"ma"` i `"lat."`.


```r
imie = "Olek"
wiek = 77
tekst1 = paste(imie, "ma", wiek, "lat.")
tekst1
#> [1] "Olek ma 77 lat."
```

Takie konstrukcje są często używane w funkcjach. 
Powyższy przykład możnaby przepisać jako:


```r
lata = function(imie, wiek){
  paste(imie, "ma", wiek, "lat.")
}
lata("Asia", 61)
#> [1] "Asia ma 61 lat."
```

Dodatkowo w R istnieje alternatywa dla `paste()` i `paste0()` w postaci funkcji `sprintf()`.

Kolejne podstawowe funkcje, `toupper()` i `tolower()` zamieniają cały istniejący tekst na taki który posiada tylko duże lub małe litery.


```r
toupper(tekst1)
#> [1] "OLEK MA 77 LAT."
tolower(tekst1)
#> [1] "olek ma 77 lat."
```

Są one używane w sytuacjach, gdy posiadamy dane, w których jeden tekst jest podany w kilku formach i chcemy je ujednolicić.

R posiada też wiele innych wbudowanych funkcji do obsługi tekstu (np. `grep()`)<!--API issues-->, ale istnieją też specjalne pakiety poświęcone temu zagadnieniu, w tym pakiet **stringr** [@R-stringr].


```r
library(stringr)
```

Większość funkcji tego pakietu zaczyna się od prefiksu `str_` co ułatwia znajdowanie funkcji w tym pakiecie i zmniejsza szansę na nałożenie się funkcji o takiej samej nazwie z innego pakietu.

Przykładową operacją na tekście jest jego sortowanie (czyli układanie alfabetycznie), do którego służy funkcja `str_sort()`.


```r
tekst2 = c("czosnek", " hałas", "ćma ")
tekst2
#> [1] "czosnek" " hałas"  "ćma "
str_sort(tekst2)
#> [1] " hałas"  "ćma "    "czosnek"
```

W powyższym przykładzie oczkiwalibyśmy ułożenia, w których `"hałas"` byłby na ostatnim miejscu. 
Nie jest tak z powodu istnienia z przodu tego wyrazu znaku niedrukowalnego - spacji.
Aby usunąć spacje z przodu i tyłu tekstu można użyć funkcji `str_trim()`.


```r
tekst2 = str_trim(tekst2)
tekst2
#> [1] "czosnek" "hałas"   "ćma"
```

W tej chwili możmy użyć funkcji `str_sort()` jeszcze raz.


```r
str_sort(tekst2)
#> [1] "ćma"     "czosnek" "hałas"
```

Teraz `"hałas"` jest poprawnie na ostanim miejscu, ale na pierwszej pozycji jest `"ćma"` zamiast `"czosnek"`.
Różne alfabety na świecie mają inne znaki oraz ich kolejność. 
Domyślnie funkcja  `str_sort()` używa alfabetu angielskiego, co w efekcie powoduje niepoprawne ułożenie polskich znaków.
Do rozwiązania tego problemu służy argument `locale`, w którym można określić jaki alfabet ma być używany.


```r
str_sort(tekst2, locale = "pl")
#> [1] "czosnek" "ćma"     "hałas"
str_sort(tekst2, locale = "cs")
#> [1] "ćma"     "czosnek" "hałas"
```

Powyżej można zobaczyć dwa przykłady - ułożenia tekstu według polskiego i czeskiego alfabetu^[https://en.wikipedia.org/wiki/Czech_orthography].

## Wydzielanie tekstu

Częstym przypadkiem jest potrzeba wydzielenia tylko fragmentu tekstu.
W tej sekcji zostanie pokazane jak wydzielać tekst na podstawie pozycji, ale możliwe jest również wydzielanie tekstu na podstawie wzorca (zobacz sekcję \@ref(wtregex)).
Wydzielanie na podstawie pozycji jest używane w sytuacjach, gdy struktura wejściowego tekstu jest nam znana i stabilna, np. gdy interesuje nas wybranie fragmentu tekstu z automatycznie generowanych raportów.


```r
tekst1 = "Olek ma 77 lat."
```

W przypadku wydzielania tekstu na podstawie pozycji należy określić pozycję pierwszego i ostatniego znaku, który nas interesuje.
Można to zrobić na kilka sposobów.
Pierwszy z nich polega na określeniu położenia znaków od lewej strony, np. poniższy kod wybiera tekst rozpoczynający się od 9 znaku i kończący się na znaku 15 włącznie.


```r
str_sub(tekst1, start = 9, end = 15)
#> [1] "77 lat."
```

Definiowanie pozycji może się też odbywać od prawej strony tekstu używając znaku `-`. 


```r
str_sub(tekst1, start = 9, end = -1)
#> [1] "77 lat."
```

W powyższym przykładzie wybierany jest tekst zaczynający się na 9 znaku a kończący na pierwszym znaku od końca włącznie.
Natomiat poniżej wybrany jest tekst zaczynający się na siódmym znaku od końca i kończący na pierwszym od kónca włącznie.


```r
str_sub(tekst1, start = -7, end = -1)
#> [1] "77 lat."
```

## Wyrażenia regularne 

<!-- https://github.com/VerbalExpressions/JSVerbalExpressions -->
<!-- https://github.com/richierocks/rebus/blob/master/README.md -->
<!-- https://www.garrickadenbuie.com/project/regexplain/ -->
<!-- https://github.com/kevinushey/rex -->



Wyrażenia regularne (ang. *regular expressions*), często określane jako *regex* to sposób opisywanie wzorców tekstu. 
Używając wyrażeń regularnych możliwe jest, między innymi, znajdowanie tekstu lub zamienienie, który spełnia wymagane warunki.
Wyrażenia regularne są powszechnie używane w wyszukiwarkach internetowych, edytorach tekstu, oraz wielu językach programowania.

<!-- basic stuff -->


```r
tekst4 = c("Magdalena", "Lena", "1Lena.csv", "LLena", "Helena", "Anna", 99)
```


```r
str_detect(tekst4, "Lena")
#> [1] FALSE  TRUE  TRUE  TRUE FALSE FALSE FALSE
```


```r
str_detect(tekst4, "lena")
#> [1]  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE
```


Table: (\#tab:regexoperators)Metaznaki w wyrażeniach regularnych

Operator   Wyjaśnienie                                           
---------  ------------------------------------------------------
^          Określa początek tekstu/linii                         
$          Określa koniec testu/linii                            
()         Grupowanie                                            
|          Alternatywa (lub)                                     
[]         Wymienia dozwolone znaki                              
[^]        Wymienia niedozwolone znaki                           
*          Poprzedni znak zostanie wybrany zero lub więcej razy  
+          Poprzedni znak zostanie wybrany jeden lub więcej razy 
?          Poprzedni znak zostanie wybrany zero lub jeden raz    
{n}        Poprzedni znak zostanie wybrany n razy                
.          Jakikolwiek znak oprócz nowej linii (\n)              
\\         Pozwala na użycie specjalnych znaków                  

Wymienione powyżej znaki (np. `^`<!--Kareta--> czy `.`) określane są jako metaznaki (ang. *metacharacters*) i mają one specjalne znaczenie.
W związku z tym, jeżeli chcemy wyszukać tekstu zawierającego specjalny znak, musimy użyć ukośnik wsteczny (`\`, ang. *backslash*).
Istnieje wiele dodatkowych znaków specjalnych, np. `\n` - nowa linia, `\t` - tabulator, `\d` - każdy znak numeryczny (stałoprzecinkowy), `\s` - znak niedrukowalny, np. spacja, tabulator, nowa linia.


```r
str_detect(tekst4, pattern = "^L")
#> [1] FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE
```


```r
str_detect(tekst4, pattern = "ena$")
#> [1]  TRUE  TRUE FALSE  TRUE  TRUE FALSE FALSE
```


```r
str_detect(tekst4, pattern = "(ena|nna)$")
#> [1]  TRUE  TRUE FALSE  TRUE  TRUE  TRUE FALSE
```


```r
str_detect(tekst4, pattern = "[a-zA-Z]")
#> [1]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE
```


```r
str_detect(tekst4, pattern = "[0-9]")
#> [1] FALSE FALSE  TRUE FALSE FALSE FALSE  TRUE
```


```r
str_detect(tekst4, pattern = "L+")
#> [1] FALSE  TRUE  TRUE  TRUE FALSE FALSE FALSE
```


```r
str_detect(tekst4, pattern = "^[^L]+")
#> [1]  TRUE FALSE  TRUE FALSE  TRUE  TRUE  TRUE
```


```r
str_detect(tekst4, pattern = "\.")
#> Error: '\.' is an unrecognized escape in character string starting ""\."
```


```r
str_detect(tekst4, pattern = "\\.")
#> [1] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
```

<!-- block z popularnymi regex -->


```r
y = c("kołdra", "kordła", "pościel")
str_detect(y, pattern = "ko(łdr|rdł)a")
```

<!-- https://stringr.tidyverse.org/articles/regular-expressions.html -->
Umiejętności używania wyrażeń regularnych można trenować używając różnych zasobów internetowych, np. strony https://regexr.com/, https://regex101.com/, czy https://regexcrossword.com/.
Pomocne w zrozumieniu bardziej zaawansowanych elementów wyrażeń regularncych może być też prezentacja [Best of Fluent 2012: /Reg(exp){2}lained/: Demystifying Regular Expressions](https://www.youtube.com/watch?v=EkluES9Rvak) oraz książka Mastering Regular Expressions [@friedl2006mastering].
<!-- https://www.amazon.com/Mastering-Regular-Expressions-Jeffrey-Friedl/dp/0596528124/ref=sr_1_1?ie=UTF8&qid=1464113797&sr=8-1&keywords=mastering+regular+expressions -->
<!-- https://www.rstudio.com/resources/cheatsheets/#stringr -->

## Wydzielanie tekstu - regex {#wtregex}

<!-- https://r4ds.had.co.nz/strings.html#extract-matches -->


```r
tekst_pomiary = "Wrocław: 23, Bydgoszcz: 12, Toruń: 11, Lublin: 14"
```


```r
str_extract(tekst_pomiary, pattern = "[a-zA-Z]*")
#> [1] "Wroc"
```


```r
str_extract(tekst_pomiary, pattern = "[a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ]*")
#> [1] "Wrocław"
```


```r
str_extract_all(tekst_pomiary, pattern = "[a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ]*")
#> [[1]]
#>  [1] "Wrocław"   ""          ""          ""          ""         
#>  [6] ""          ""          "Bydgoszcz" ""          ""         
#> [11] ""          ""          ""          ""          "Toruń"    
#> [16] ""          ""          ""          ""          ""         
#> [21] ""          "Lublin"    ""          ""          ""         
#> [26] ""          ""
```


```r
str_extract_all(tekst_pomiary, pattern = "[a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ]+")
#> [[1]]
#> [1] "Wrocław"   "Bydgoszcz" "Toruń"     "Lublin"
```


```r
tekst_pomiary2 = "Wrocław: 23, Bydgoszcz: 12, Toruń: 11, Lublin: 14, Gorzów Wielkopolski: 20, Zielona Góra: 19"
```


```r
str_extract_all(tekst_pomiary2, pattern = "[a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ]+")
#> [[1]]
#> [1] "Wrocław"      "Bydgoszcz"    "Toruń"        "Lublin"      
#> [5] "Gorzów"       "Wielkopolski" "Zielona"      "Góra"
```


```r
str_extract_all(tekst_pomiary2, pattern = "[a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ]+[\\s]?[a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ]*")
#> [[1]]
#> [1] "Wrocław"             "Bydgoszcz"           "Toruń"              
#> [4] "Lublin"              "Gorzów Wielkopolski" "Zielona Góra"
```


```r
miasta_pomiary2 = str_extract_all(tekst_pomiary2,
                                  pattern = "[a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ]+[\\s]?[a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ]*")
miasta_pomiary2
#> [[1]]
#> [1] "Wrocław"             "Bydgoszcz"           "Toruń"              
#> [4] "Lublin"              "Gorzów Wielkopolski" "Zielona Góra"
```

## Zamiana tekstu - regex

<!-- https://r4ds.had.co.nz/strings.html#replacing-matches -->


```r
tekst_pomiary3 = "Wrocław: 23.5, Bydgoszcz: 12.7, Toruń: 11.1, Lublin: 14.3"
```


```r
str_replace(tekst_pomiary3, 
            pattern = ".", 
            replacement = ",")
#> [1] ",rocław: 23.5, Bydgoszcz: 12.7, Toruń: 11.1, Lublin: 14.3"
```


```r
str_replace(tekst_pomiary3, 
            pattern = "\\.", 
            replacement = "\\,")
#> [1] "Wrocław: 23,5, Bydgoszcz: 12.7, Toruń: 11.1, Lublin: 14.3"
```


```r
str_replace_all(tekst_pomiary3, 
                pattern = "\\.", 
                replacement = "\\,")
#> [1] "Wrocław: 23,5, Bydgoszcz: 12,7, Toruń: 11,1, Lublin: 14,3"
```


```r
tekst_pomiary4 = str_replace_all(tekst_pomiary3,
                                 pattern = "\\,",
                                 replacement = "\\;")
```


```r
str_replace_all(tekst_pomiary4, 
                pattern = "\\.", 
                replacement = "\\,")
#> [1] "Wrocław: 23,5; Bydgoszcz: 12,7; Toruń: 11,1; Lublin: 14,3"
```


```r
str_replace_all(tekst_pomiary4, 
                pattern = "[a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ]+",
                replacement = "")
#> [1] ": 23.5; : 12.7; : 11.1; : 14.3"
```

## Wyszukiwanie plików


```r
dir("pliki")
#> [1] "dane_meteo.csv"  "dane_meteo.rds"  "dane_meteo.xlsx" "dokument.docx"  
#> [5] "kod.R"           "mapa.png"        "obrazek.png"     "zdjęcie.jpg"
```


```r
dir("pliki", pattern = "*\\.png$")
#> [1] "mapa.png"    "obrazek.png"
```


```r
dir("pliki", pattern = "*\\.(png|jpg)$")
#> [1] "mapa.png"    "obrazek.png" "zdjęcie.jpg"
```


```r
dir("pliki", pattern = "*\\.(png|jpg)$", full.names = TRUE)
#> [1] "pliki/mapa.png"    "pliki/obrazek.png" "pliki/zdjęcie.jpg"
```


```r
moje_pliki = dir("pliki", pattern = "*\\.(png|jpg)$", full.names = TRUE)
```

## Zadania

1) Plik tekstowy zawiera listę pomiarów, w której piąty i czwarty znak od końca oznacza symbol chemiczny pomierzonego pierwiastka, przykładowo:

```r
"TERYT 18; podkarpackie; Rzeszów; 0.2 He; A"
"TERYT 22; pomorskie;	Gdańsk; 12 C ; B"
```
Napisz kod, który będzie wydzielał symbole chemiczne pomierzonych pierwiastków.

2) Napisz funkcję nazywającą się `horoskop`, która przyjmuje dwa argumenty `imie` (pierwsze imię, tekst) oraz `miesiac` (miesiąc urodzin, liczba).
Funkcja ma zwrócić tekst "Osoba o imieniu 'imie' będzie miała jutro szczęście." w przypadku, gdy argument `miesiac` jest liczbą parzystą oraz "Osoba o imieniu 'imie' będzie miała jutro nieszczęście." jeżeli argument `miesiac` jest liczbą nieparzystą.
3) Rozbuduj funkcję `horoskop` poprzez sprawdzenie pierwszej litery podanego imienia. Jeżeli pierwsza litera imienia to `K`, `M`, lub `Z` wówczas wyświetli się zawsze tekst "Osoba o imieniu 'imie' będzie miała jutro szczęście.", bez względu na podany miesiąc.
4) Efektem zbierania pomiarów temperatury okazał być się plik tekstowy, który zawiera datę pomiaru oraz wartość.
W jaki sposób możliwe jest wydzielenie tylko dat w takiej sytuacji?
Poniżej znajduje się fragment przykładowych danych wejściowych.

```r
"2019-03-11: 23.5, 19/03/12: 12.7, 2019.03.13: 11.1, 2019-marzec-14: 14.3"
```

5) Co należałoby zrobić, aby wydzielić tylko wartości pomiarów w powyższym przypadku?
Stwórz nowy obiekt `wartosci` zawierający te pomiary.
Jakiej klasy powinien być wyjściowy obiekt?
6) Posiadasz wektor `wsp` zawierający współrzedne geograficzne szeregu miast w formacie DMS (Stopnie, Minuty, Sekundy).
Wydziel tylko wartości stopnii z tej reprezentacji.
Poniżej znajduje się fragment przykładowych danych wejściowych.

```r
wsp = c("52°24′N 16°55′E", "53°08′07″N 23°08′44″E", "39°6′N 84°31′W")
```

7) Stwórz funkcję, która przyjmując przykładowe dane z poprzedniego zadania zamieni współrzędne na format w postaci stopni dziesiętnych (np. `52°24′N` w formacie DMS to `52.4` w stopniach dziesiętnych). 
<!-- match hex colors, examples :#abs, #f0, #BADA55, #COFFEE https://www.youtube.com/watch?v=EkluES9Rvak -->

