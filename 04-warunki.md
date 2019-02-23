
# Wyrażenia warunkowe {#warunki}

Języki programowania opierają się o dwa podstawowe narzędzia pozwalające na sterowanie przepływem operacji.
Są to wyrażenia warunkowe oraz pętle.
Wyrażenia warunkowe są głównym tematem tego rozdziału, natomiast pętle są omówione w rozdziale \@ref(petle).

<!-- `switch` https://adv-r.hadley.nz/control-flow.html#loops -->

Celem wyrażeń warunkowych jest wykonywanie różnego kodu w zależności od danych wejściowych.

## Warunki

Wyrażenie `if` opiera się o spełnienie (lub niespełnienie) danego warunku.


```r
if (warunek){
  jeżeli warunek spełniony to wykonaj operację
}
```



```r
temperatura = 5.4
if (temperatura > 0) {
  "Dodatnia"
}
#> [1] "Dodatnia"
```


```r
temperatura = -11
if (temperatura > 0) {
  "Dodatnia"
}
```

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">Warunek `if` można też tworzyć w uproszczonej formie:

`if (warunek) spelniony else niespelniony`</div>\EndKnitrBlock{rmdinfo}

## Warunki zagnieżdzone

Działanie wyrażenia `if` może być połączone z dodatkowymi wyrażeniami `else if` oraz `else`.


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

<!-- explain -->

## Operatory porównania


Table: (\#tab:operators)Operatory porównania

Operator   Wyjaśnienie                    
---------  -------------------------------
==         Równy                          
!=         Nie równy                      
%in%       Zawiera się w                  
>, <       Większy/Mniejszy niż           
>=, <=     Większy/Mniejszy niż lub równy 


Table: (\#tab:operators2)Operatory porównania

Operator   Wyjaśnienie       
---------  ------------------
!          Negacja (nie)     
&&         Koniunkcja (i)    
||         Alternatywa (lub) 

<!-- block about & and | -->
<!-- https://stackoverflow.com/questions/6558921/boolean-operators-and -->

## Wyrażenia warunkowe w funkcjach


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
pogoda(NA)
```


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
pogoda(NA)
#> Dzisiaj nie mamy pomiarów temperatury.
```


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
pogoda(NA)
#> Dzisiaj nie mamy pomiarów temperatury.
```

## Zadania