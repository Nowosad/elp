
# (PART) Narzędzia {-}

# Złożone funkcje {#zlozone-funkcje}

<!-- intro -->
<!-- solve a single problem -->
<!-- type stability -->

<!-- 07-oo https://blog.rstudio.com/2019/02/06/rstudio-conf-2019-workshops/ -->

<!-- https://arxiv.org/pdf/1409.3531.pdf -->

## API

Interfejs programistyczny aplikacji (ang. *application programming interface*, API) to zbiór sposobów komunikacji pomiędzy różnymi komponentami oprogramowania.
Inaczej mówiąc API określa w jaki sposób następuje interakcja z kodem.
Dobrze zaprojektowane API uławia zarówno rozwijanie oprogramowania, jak i jego używanie.
Podstawowe elementy przemyślanego API w R obejmują nazwy funkcji, ich argumenty, oraz tzw. stabilność typu (ang. *type stability*.

Funkcje wewnątrz pojedynczego pakietu powinny być nazywane konsekwentnie używając tylko jednej konwencji nazywania (sekcja \@ref(nazwy-obiektow)).
Sama nazwa powinna w zwięzły sposób przekazywać jakie jest działanie funkcji. 
Dodatkową możliwością jest używanie w jednym pakiecie funkcji rozpoczynających się od takiego samego prefiksu. 
Przykładowo, większość nazw funkcji w pakiecie **landscapemetrics** rozpoczyna się od liter `lsm_`, np. `lsm_l_ent()` [@R-landscapemetrics].

Podobnie należy stosować tylko jedną konwencję przy nazywaniu argumentów funkcji, a nazwy argumentów powinny być informacyjne, ale jednocześnie zwięzłe.
W przypadku, gdy taki sam rodzaj danych wejściowych jest oczekiwany w różnych funkcjach, koniecznie jest aby zawsze ten argument był tak samo nazwany.
Podobnie należy zadbać o spójną kolejność podobnych argumentów w funkcjach jednego pakietu.

Stabilność typu oznacza, że używając jednej klasy danych wejściowych funkcja zawsze zwróci obiekt jednej klasy. 
<!-- Przykładowo... -->

Dodatkowym elementem API może być określenie domyślnych parametrów funkcji.


```r
potegowanie = function(x, w = 2){
  x ^ w
}
```


```r
potegowanie(2)
#> [1] 4
```


```r
potegowanie(2, w = 2)
#> [1] 4
```


```r
potegowanie(2, w = 3)
#> [1] 8
```
<!-- elipsis -->

## Obsługa błędów

Obsługa błędów w funkcjach ma na celu ochronę użytkownika przed nieodpowiednim zachowaniem funkcji.
Komunikat błędu powinien ułatwiać użytkownikowi zrozumienie problemu oraz jego rozwiązanie. 
Zazwyczaj komunikat błędu przyjmuje jedną z trzech form: (1) określenie problemu, np. "Argument `x` musi być zmienną numeryczną, a nie znakową.", (2) lokalizacja błędu, np. "Kolumna `abc` nie istnieje w obiekcie `y`.", (3) porada, np. "Did you mean `Species == "setosa"`?". 
Oczywiście te wymienione formy można łączyć.

Ważne jest też, aby funkcja kończyła swoje działanie jak najszybciej po napotkaniu, np. błędnych wartości wejściowych.
Żadnej użytkownik nie chce czekać na zakończenie wykonywania długiej funkcji zanim dostanie komunikat błędu.


<!-- stop() + if() -->
<!-- warning() -->
<!-- message -->
<!-- + examples -->
<!-- tworzenie wiadomości, warnings, errors -->
<!-- http://jarekj.home.amu.edu.pl/wp-content/uploads/2018/10/006_wyjatki.html --> 

Więcej informacji o strukturze komunikatów błędów można znaleźć na https://style.tidyverse.org/error-messages.html.

## Programowanie obiektowe

Programowanie obiektowe (ang. *object-oriented programming*, OOP) to jeden z najpopulariniejszych paradygmatów programowania (sekcja \@ref(jezyki-programowania)). 
Polega on na definiowaniu obiektów danej klasy posiadających pewną określoną strukturę oraz zachowania.

<!-- s3 s4 etc -->

<!-- W S3 zachowanie działania obiektu powiązane jest  \@ref(inne-klasy)-->

<!-- methods -->
<!-- scope - http://jarekj.home.amu.edu.pl/wp-content/uploads/2018/11/005_funkcje.html -->
<!-- lexical scoping https://adv-r.hadley.nz/functions.html -->

## Testy jednostkowe

<!-- Unit testing -->
<!-- usethis::use_test() -->
<!-- devtools::test() -->
<!-- devtools::test_coverage() -->

## Zadania
