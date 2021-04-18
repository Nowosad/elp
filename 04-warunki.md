# Wyrażenia warunkowe {#warunki}

Języki programowania opierają się o dwa podstawowe narzędzia pozwalające na sterowanie przepływem operacji.
Są to wyrażenia warunkowe oraz pętle.
Wyrażenia warunkowe są głównym tematem tego rozdziału, natomiast pętle oraz ich alternatywy są omówione w rozdziale \@ref(petle).
<!-- `switch` https://adv-r.hadley.nz/control-flow.html#loops -->
Celem wyrażeń warunkowych jest wykonywanie różnego zadania w zależności od danych wejściowych.

## Warunki

Wyrażenie `if` opiera się o spełnienie (lub niespełnienie) danego warunku.
Jeżeli dany warunek jest spełniony, kod wewnątrz wyrażenia `if()` jest wykonywany.
W przeciwnym razie cały blok kodu jest pomijany.


```r
if (warunek){
  jeżeli warunek spełniony to wykonaj operację
}
```

Wyrażenie `if` oczekuje, że warunek jest wektorem logicznym o długości jeden, tj. takim który przyjmuje wartość `TRUE` lub `FALSE`.
Istnieje szereg sposób uzyskania wektora logicznego w R, jednym z nich jest zastosowanie porównania wartości.

W poniższym przykładzie wyrażenie `if()` sprawdza czy wartość obiektu `temperatura` jest wyższa niż 0.
W przypadku, gdy ten warunek jest spełniony (czyli przyjmuje `TRUE`), wyświetlany jest tekst `"Dodatnia"`.


```r
temperatura = 5.4
if (temperatura > 0) {
  "Dodatnia"
}
#> [1] "Dodatnia"
```

W przeciwnym razie, gdy warunek nie jest spełniony (czyli ma wartość `FALSE`), kod wewnątrz warunku nie jest wykonywany.


```r
temperatura = -11
if (temperatura > 0) {
  "Dodatnia"
}
```

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">Warunek `if` można też tworzyć w uproszczonej formie:

`if (warunek) spelniony else niespelniony`</div>\EndKnitrBlock{rmdinfo}

## Warunki zagnieżdżone

Działanie wyrażenia `if` może być połączone z dodatkowymi wyrażeniami `else if` oraz `else`.
Te dwa wyrażenia wymagają najpierw wywołania wyrażenia `if()`. 
Jeżeli warunek w wyrażeniu `if()` jest równy `TRUE` to wykonywany jest kod w nim zawarty, a następnie obliczenie jest kończone.
W przypadku, gdy wyrażenie `if()` otrzyma wartość `FALSE`, to kod w nim zawarty nie jest wykonywany, a następuje przejście do kolejnego wyrażenia, np. `else if()` w poniższym przypadku.


```r
temperatura = 8.8
if (temperatura > 0) {
  "Dodatnia"
} else if (temperatura < 0) {
  "Ujemna"
} else {
  "Zero"
}
#> [1] "Dodatnia"
```

Wyrażenie `else if()` różni się od `else` tym, że wymaga ono określenia jaki warunek ma być spełniony.
W przypadku `else` wyliczane są wszystkie przypadki, które nie spełniają wcześniejszych warunków.

## Operatory porównania

W tabeli \@ref(tab:operators) można znaleźć listę podstawowych operatorów porównania.
Ich celem jest sprawdzanie pewnego warunku i zwrócenie wartości `TRUE` lub `FALSE`.


Table: (\#tab:operators)Operatory porównania.

|Operator |Wyjaśnienie                    |
|:--------|:------------------------------|
|==       |Równy                          |
|!=       |Nie równy                      |
|%in%     |Zawiera się w                  |
|>, <     |Większy/Mniejszy niż           |
|>=, <=   |Większy/Mniejszy niż lub równy |

Wyrażenie `if()` oczekuje wektora logicznego o długości jeden. 
Często jednak efektem porównania może być wektor o większej długości.
Przykładowo, porównanie operatorem `==` daje w wyniku wektor o długości trzy, a porównanie z użyciem `%in%` skutkuje wektorem o długości jeden.


```r
x = 1
y = c(1, 2, 3)
x == y
#> [1]  TRUE FALSE FALSE
x %in% y
#> [1] TRUE
```

Sterowanie tym, żeby uzyskany wynik miał oczekiwaną długość jeden może się odbywać też z pomocą operatorów logicznych i funkcji pomocniczych (tabela \@ref(tab:operators2)).


Table: (\#tab:operators2)Operatory logiczne i funkcje pomocniczne.

|Operator     |Wyjaśnienie       |
|:------------|:-----------------|
|!            |Negacja (nie)     |
|&&           |Koniunkcja (i)    |
|&#124;&#124; |Alternatywa (lub) |
|all          |Wszystkie         |
|any          |Którykolwiek      |

Pozwalają one na sprawdzenie czy wszystkie (`all()`) lub którykolwiek (`any()`) z elementów obiektu przyjmuje wartość `TRUE`.


```r
x = 1
y = c(1, 2, 3)
all(x == y)
#> [1] FALSE
any(x == y)
#> [1] TRUE
```

Możliwe jest też łączenie bardziej złożonych zapytań używając operatora "i" (`&&`) oraz operatora "lub" (`||`).


```r
x = 1
y = c(1, 2, 3)
z = 4
(x %in% y) || !(z %in% y)
#> [1] TRUE
```

Powyżej nastąpiło sprawdzenie czy element z obiektu `x` znajduje się w obiekcie `y`, a następnie czy element z obiektu `z` nie znajduje się w obiekcie `y`.
Po wykonaniu ich sprawdzeń nastąpiło ich połączenie używając operatora `||`, który daje wartość `TRUE`, gdy chociaż jedno z zapytań jest prawdziwe.

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">W R istnieją dwa dodatkowe operatory logiczne `&` i `|`, które są zwektoryzowaną wersją operatorów `&&` i `||`.
Pierwsze dwa porównują wszystkie elementy zadanych wektorów i ich wynikiem może być wektor o długości większej niż 1.
Operatory `&&` i `||` porównują tylko pierwszy element każdego wektora, a w efekcie zawsze zwracają tylko jedną wartość.
Dodatkowo, to one są zazwyczaj używane w wyrażeniach warunkowych.</div>\EndKnitrBlock{rmdinfo}

## Wyrażenia warunkowe w funkcjach {#wwwf}

Wyrażenia warunkowe są często używanym elementem przy tworzeniu funkcji.
Pozwalają one na nie tylko na określanie tego w jaki sposób dana funkcja zadziała, ale też pełnią rolę w sprawdzaniu czy do funkcji zostały wprowadzone poprawne argumenty.

Celem poniższej funkcji `pogoda()` jest wyświetlenie pewnego tekstu w zależności od podanej wartości argumentu `temperatura`.
Pierwszym warunkiem, który można sprawdzić jest określenie czy użytkownik wprowadził do funkcji w postaci argumentu oczekiwany typ danych (więcej o typach danych można dowiedzieć się w rozdziale \@ref(proste-obiekty)).
W tym przypadku typ numeryczny jest oczekiwany, co można sprawdzić używając funkcji `is.numeric()`, która zwraca `TRUE` dla danych numerycznych i `FALSE` dla każdych innych.


```r
pogoda = function(temperatura){
  if (is.numeric(temperatura)){
    cat(paste("Dzisiaj jest", temperatura, "stopni Celsjusza."))
  }
}
pogoda(10)
#> Dzisiaj jest 10 stopni Celsjusza.
pogoda(-20)
#> Dzisiaj jest -20 stopni Celsjusza.
pogoda("nie wiem")
```

Efekt działania powyższej funkcji jest teraz zależy od wejściowego typu danych - jeżeli podana jest wartość numeryczna zwracany jest tekst, a jeżeli ten warunek nie jest spełniony to nic się nie dzieje.

Warto, aby tworzona funkcja obsługiwała najczęściej potencjalnie używane rodzaje danych wejściowych.
W tym przypadku, warto dodać wyrażenie `else`, którego efektem jest kolejny tekst sugerujący, że funkcja została wykonana, ale w inny sposób.


```r
pogoda = function(temperatura){
  if (is.numeric(temperatura)){
    cat(paste("Dzisiaj jest", temperatura, "stopni Celsjusza."))
  } else {
    cat("Dzisiaj nie mamy pomiarów temperatury.")
  }
}
pogoda(10)
#> Dzisiaj jest 10 stopni Celsjusza.
pogoda(-20)
#> Dzisiaj jest -20 stopni Celsjusza.
pogoda("nie wiem")
#> Dzisiaj nie mamy pomiarów temperatury.
```

Wyrażenia warunkowe można też wielokrotnie zagnieżdżać wewnątrz zdefiniowanej funkcji.


```r
pogoda = function(temperatura){
  if (is.numeric(temperatura)){
    cat(paste("Dzisiaj jest", temperatura, "stopni Celsjusza.\n"))
    if (temperatura < 5){
      cat("Ubierz się ciepło!")
    }
  } else {
    cat("Dzisiaj nie mamy pomiarów temperatury.")
  }
}
pogoda(10)
#> Dzisiaj jest 10 stopni Celsjusza.
pogoda(-20)
#> Dzisiaj jest -20 stopni Celsjusza.
#> Ubierz się ciepło!
pogoda("nie wiem")
#> Dzisiaj nie mamy pomiarów temperatury.
```

Przykładowo, powyżej komunikat `"Ubierz się ciepło!"` jest wyświetlany w momencie, gdy spełnione zostaną dwa warunki - najpierw wejściowy obiekt `temperatura` musi być typu numerycznego, a następnie wartość tego obiektu musi być niższa niż 5.

## Zadania {#zad4}

1) Spójrz na poniższe przykłady, ale ich nie wykonuj.
Co będzie wynikiem działania każdego z tych przykładów?


```r
liczby = c(1, 2)
liczby == 1          #1
liczby != 1          #2
liczby %in% 1        #3
all(liczby %in% 1)   #4
any(liczby %in% 1)   #5
```

2) Spójrz na cztery poniższe przykłady, ale ich nie wykonuj.
Co będzie wynikiem działania każdego z tych przykładów?


```r
(c(1, 2) > 0) &  (c(-1, 2) > 0) #1
(c(1, 2) > 0) && (c(-1, 2) > 0) #2
(c(1, 2) > 0) |  (c(-1, 2) > 0) #3
(c(1, 2) > 0) || (c(-1, 2) > 0) #4
```

3) Napisz funkcję, która przyjmuje trzy zmienne logiczne `x`, `y` i `z`.
Jeżeli tylko jedna lub trzy ze zmiennych ma wartość `TRUE` wyświetl tekst `"Nieparzysta liczba."`, natomiast jeżeli dwie zmienne mają wartość `TRUE` wyświetl tekst `"Parzysta liczba."`
4) Napisz funkcję, która przyjmuje dwie zmienne numeryczne `x` i `y`.
Jeżeli wszystkie wartości zmiennej `x` są większe od `y` wyświetl tekst `"Zwycięstwo."`, a w przeciwnym razie wyświetl tekst `"Porażka."`.
5) Napisz funkcję, która przyjmuje dwie zmienne numeryczne `populacja` i `powierzchnia`.
Jeżeli wartości gęstości zaludnienia (liczba osób na jednostkę powierzchni) jest wyższa niż 123 wyświetl tekst `"Wartość powyżej średniej dla Polski."`.
