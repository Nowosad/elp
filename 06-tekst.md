
# Tekst {#tekst}

Więcej na temat przetwarzania tekstu można znaleźć w rozdziale ["Strings"](https://r4ds.had.co.nz/strings.html) książki R for Data Science [@grolemund_r_2016].

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

## Łączenie tekstu


```r
paste("t", "o", " ", "k", "o", "t")
#> [1] "t o   k o t"
```


```r
paste0("t", "o", " ", "k", "o", "t")
#> [1] "to kot"
```

<!-- ^[funkcja `str_c()`] -->


```r
imie = "Olek"
wiek = 7
tekst1 = paste(imie, "ma", wiek, "lat.")
tekst1
#> [1] "Olek ma 7 lat."
```

## Postawowe operacje na tekście


```r
library(stringr)
```


```r
toupper(tekst1)
#> [1] "OLEK MA 7 LAT."
```


```r
tolower(tekst1)
#> [1] "olek ma 7 lat."
```


```r
tekst2 = c("chronologia", "alfabet", "hałas")
```


```r
str_sort(tekst2, locale = "pl")
#> [1] "alfabet"     "chronologia" "hałas"
str_sort(tekst2, locale = "cs")
#> [1] "alfabet"     "hałas"       "chronologia"
```



```r
tekst3 = c("chronologia ", "alfabet", " hałas")
str_sort(tekst3, locale = "pl")
#> [1] " hałas"       "alfabet"      "chronologia "
```


```r
tekst3 = str_trim(tekst3)
tekst3
#> [1] "chronologia" "alfabet"     "hałas"
str_sort(tekst3, locale = "pl")
#> [1] "alfabet"     "chronologia" "hałas"
```

## Wydzielanie tekstu


```r
str_sub(tekst1, start = 1, end = 4)
#> [1] "Olek"
```


```r
str_sub(tekst1, start = 9, end = 14)
#> [1] "7 lat."
```


```r
str_sub(tekst1, start = 9, end = -1)
#> [1] "7 lat."
```


```r
str_sub(tekst1, start = -6, end = -1)
#> [1] "7 lat."
```

## Wyrażenia regularne 




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
<!-- ranges [a-z0-9] -->
<!-- link to the cheetsheet -->


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
>str_detect(tekst4, pattern = "\.")
#> Error: '\.' is an unrecognized escape in character string starting ""\."
```


```r
str_detect(tekst4, pattern = "\\.")
#> [1] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
```


```r
# str_detect(tekst4, pattern = "")
```

<!-- block z popularnymi regex -->


```r
y = c("kołdra", "kordła", "pościel")
str_detect(y, pattern = "ko(łdr|rdł)a")
```


## Wyrażenia regularne (wydzielanie tekstu)


```r
# str_extract()
```

## Wyrażenia regularne (zamiana tekstu)


```r
# str_replace()
```

<!-- https://stringr.tidyverse.org/articles/regular-expressions.html -->
Umiejętności używania wyrażeń regularnych można trenować używając różnych zasobów internetowych, np. strony https://regexr.com/ lub https://regex101.com/.
<!-- https://regexcrossword.com/ -->
<!-- https://www.amazon.com/Mastering-Regular-Expressions-Jeffrey-Friedl/dp/0596528124/ref=sr_1_1?ie=UTF8&qid=1464113797&sr=8-1&keywords=mastering+regular+expressions -->
<!-- Lea Verou [Best of Fluent 2012: /Reg(exp){2}lained/: Demystifying Regular Expressions](https://www.youtube.com/watch?v=EkluES9Rvak) -->

## Wyszukiwanie plików


## Zadania

<!-- match hex colors, examples :#abs, #f0, #BADA55, #COFFEE https://www.youtube.com/watch?v=EkluES9Rvak -->
<!-- match coordinates -->
<!-- match dates -->
