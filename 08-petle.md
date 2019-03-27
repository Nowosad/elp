
# Powtarzanie {#petle}



<!-- intro -->
<!-- https://recology.info/2019/03/control-flow-exceptions/ -->

## Pętla for

Pęlta `for` jest jednym z najczęściej używanych wyrażeń w językach programowania^[https://en.wikipedia.org/wiki/For_loop], którego celem jest powtórzenie pewnej operacji o znaną liczbę razy.

### Składnia

Pęlta `for` jest zbudowana z dwóch elementów: nagłówka określającego powtórzenia, oraz ciała zawierającego obliczenia.


```r
for (element in wektor) {
  przetwarzanie elementu
}
```

### Przykład działania

Zobaczmy jak działa pętla `for` na uproszczonym przykładzie zamiany wartości odległości z mil lądowych na kilometry.
Nasze dane wejściowe to lista składająca się z trzech wartości - 142, 63, oraz 121.
Wiemy też, że jedna mila lądowa to 1,609 kilometra.


```r
odl_mile = list(142, 63, 121)
```

Pętla `for` może być użyta w tym przypadku na kilka sposobów. 
Na początku warto zastanowić się w jaki sposób można zamienić tylko jedną wartość z powyższej listy.
Wiemy, że do wybrania jednego elementu z listy służy operator `[[]]` (sekcja \@ref(wydzielanie-list)), więc przeliczenie i wyświetlenie tylko pierwszego elementu można wykonać poprzez:


```r
print(odl_mile[[1]] * 1.609)
#> [1] 228
```

Teraz naszym celem jest potwórzenie tej operacji dla każdego elementu.


```r
print(odl_mile[[1]] * 1.609)
#> [1] 228
print(odl_mile[[2]] * 1.609)
#> [1] 101
print(odl_mile[[3]] * 1.609)
#> [1] 195
```

W powyższym przypadku mamy tylko trzy elementy, ale jeżeli mielibyśmy takich elementów 1000 musielibyśmy powtórzyć niemal tą samą linię kodu tysiąc razy jedynie zamieniając numer elementu.

Jednym z celów programowania jest ułatwienie szybkiej powtarzalności pewnych czynności.
Dlatego w tym przypadku moglibyśmy uniknąć wieloktornego pisania podobnego kodu używając pętli `for`.
Ciałem tej pętli będzie sposób przeliczania i wyświetlania wartości na kilometry, ale zamiast wydzielać kolejne elementy listy (`[[1]]`, `[[2]]`, `[[3]]`), użyjemy nowego obiektu `i`.
W efekcie nowe ciało pętli `for` będzie przedstawiać się jako `print(odl_mile[[i]] * 1.609)`.
Kolejnym krokiem jest odpowiednie ustawienie jakie wartości będzie przyjmować `i` w kolejnych powtórzeniach.


```r
for (i in 1:3) {
  print(odl_mile[[i]] * 1.609)
}
#> [1] 228
#> [1] 101
#> [1] 195
```

Powyższy nagłówek pętli `for`, `for (i in 1:3)`, określa, że nasz obiekt `i` przyjmie najpierw wartość 1, wykona obliczenie wewnątrz pętli, następnie `i` przyjmie wartość 2, znów wykona obliczenie, a na końcu `i` przyjmie wartość 3 i obliczenie zostanie wykonane po raz ostatni.

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">Tradycyjnie zmienna w pętli `for` nazywana jest `i`, a w przypadku zagnieżdzonych pętli druga zmienna nazywana jest `j`.
Nazywanie zmiennych w ten sposób nie jest jednak obowiązkowe.
W powyższym przypadku możliwe byłoby nazwanie zmiennej, np. `pomiar`: `for (pomiar in odl_mile) {...}`.</div>\EndKnitrBlock{rmdinfo}

Użyty wyżej kod wykonuje nasz cel, ale wymaga od nas zawsze deklaracji dotyczącej tego jakie wartości ma przyjąć obiekt `i`. 
W przypadku, gdy obiekt wejściowy `odl_mile` będzie krótszy lub dłuższy niż trzy elementy, będziemy musieli ręcznie zmienić nagłówek pętli `for`.
Aby tego uniknąć możemy automatycznie określić wszystkie pozycje elementów w liście `odl_mile` używając funkcji `seq_along()`.
Ta funkcja zawsze wyświetli numery położenia kolejnych elementów danego wektora lub listy.


```r
seq_along(odl_mile)
#> [1] 1 2 3
```

Poniższy kod nie wymaga już od nas ręcznego wprowadzania kolejnych położeń elementów wejściowej listy.


```r
for (i in seq_along(odl_mile)) {
  print(odl_mile[[i]] * 1.609)
}
#> [1] 228
#> [1] 101
#> [1] 195
```


\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">Często w takich sytuacjach używana jest konstrukcja `1:length()`, np. `1:length(old_mile)`. 
Zadziała ona poprawnie w powyższym przypadku, ale nie jest ona uniwersalna.
Konstrukcja `1:length()` może wywołać problemy w kodzie, gdy wejściowy obiekt jest pusty.
`for (i in 1:length(NULL)){...}` wykona pętlę `for` dwa razy, podczas gdy w rzeczywistości nie powinna ona zostać w ogóle wykonana.
Funkcja `seq_along()` jest odporna na ten problem - `seq_along(NULL)` nie wykona pętli ani razu.</div>\EndKnitrBlock{rmdinfo}




```r
for (i in  seq_along(odl_mile)) {
  odl_mile[[i]] = odl_mile[[i]] * 1.609
}
odl_mile
#> [[1]]
#> [1] 228
#> 
#> [[2]]
#> [1] 101
#> 
#> [[3]]
#> [1] 195
```


```r
odl_mile = c(142, 63, 121)
```


```r
odl_km = vector("numeric", length = 0)
odl_mile_l = seq_along(odl_mile)
for (i in odl_mile_l) {
  odl_km = c(odl_km, odl_mile[i] * 1.609)
}
odl_km
#> [1] 228 101 195
```


```r
odl_mile = c(142, 63, 121)
```


```r
odl_km = vector("numeric", length = length(odl_mile))
odl_mile_l = seq_along(odl_mile)
for (i in odl_mile_l) {
  odl_km[i] = odl_mile[i] * 1.609
}
odl_km
#> [1] 228 101 195
```

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">Wiele funkcji w R jest zwektoryzowanych, w efekcie powyższy przykład możnaby zastąpić kodem `odl_km = odl_mile * 1.609`. 
Taka zamiana jest jednak możliwa w ten sposób, ponieważ mnożenie jest w niewidzialny sposób dla użytkownika rozpisane jako pętla for.</div>\EndKnitrBlock{rmdinfo}

### Zastosowanie w funkcjach


```r
mile_na_km = function(odl_mile){
  odl_km = vector("numeric", length = length(odl_mile))
  odl_mile_l = seq_along(odl_mile)
  for (i in odl_mile_l) {
    odl_km[i] = odl_mile[i] * 1.609
  }
  odl_km
}
```


```r
odleglosci_mile = c(0, 1, 10, 55, 160)
mile_na_km(odleglosci_mile)
#> [1]   0.00   1.61  16.09  88.50 257.44
```



\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">recursive</div>\EndKnitrBlock{rmdinfo}

## Pętla while

W przypadku pętli for znana jest liczba powtórzeń przed rozpoczęciem jej działania.
Inny rodzaj pętli, while, jest natomiast stosowany gdy nie wiadomo ile potwórzeń jest koniecznych.
W efekcie pętla while jest bardziej elastyczna, co jest zarazem jej atutem, ale też wadą.
Bardziej elastyczne metody charakteryzuje również większa liczba potencjalnych sytuacji, a w efekcie problemów.

<!-- https://rstudio-education.github.io/hopr/loops.html#while-loops -->
<!--https://adv-r.hadley.nz/control-flow.html#loops -->


```r
while (warunek){
    wykonuj operację tak długo jak warunek jest spełniony
}
```




```r
budzet = 100
liczba_dni = 0
while(budzet > 0 && budzet < 200){
  budzet = budzet + sample(-10:10, size = 1)
  liczba_dni = liczba_dni + 1
}
liczba_dni
#> [1] 535
```


\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">Inne rodzaje pętli to pętla repeat oraz pętla do.
Pętla repeat powtarza pewnien kod aż do momentu przerwania go przez użytkownika (np. użycie klawisza Esc) lub do pojawienia się komendy `break`.
Działanie pętli do natomiast wygląda w następujący sposób:
`do {wykonuj operację} while (warunek)`.
Pętla do nie występuje w R.</div>\EndKnitrBlock{rmdinfo}

Dodatkowe informacje na temat pętli for and while można znaleźć w sekcji [Loops](https://adv-r.hadley.nz/control-flow.html#loops) książki Advanced R [@wickham2014advanced]

## Programowanie funkcyjne


```r
konwersja_temp = function(temperatura_f){
    (temperatura_f - 32) / 1.8
}
```


```r
pomiary_f_lista = list(
  miastoA = c(61, 14, 21),
  miastoB = c(43, 52, 30),
  miastoC = c(41, 42, 33)
)
pomiary_f_lista
#> $miastoA
#> [1] 61 14 21
#> 
#> $miastoB
#> [1] 43 52 30
#> 
#> $miastoC
#> [1] 41 42 33
```


```r
konwersja_temp(pomiary_f_lista)
#> Error in temperatura_f - 32: non-numeric argument to binary operator
```


```r
pomiary_c_lista = lapply(pomiary_f_lista, FUN = konwersja_temp)
pomiary_c_lista
#> $miastoA
#> [1]  16.11 -10.00  -6.11
#> 
#> $miastoB
#> [1]  6.11 11.11 -1.11
#> 
#> $miastoC
#> [1] 5.000 5.556 0.556
```

<!-- lapply -->
<!-- \@ref(dzialania-na-wektorach) -->
<!-- wektoryzacja-->
<!-- http://www.noamross.net/blog/2014/4/16/vectorization-in-r--why.html -->
<!-- http://alyssafrazee.com/2014/01/29/vectorization.html -->
<!-- *apply -->


```r
pomiary = data.frame(
  miastoA = c(6.1, 1.4, -2.1),
  miastoB = c(4.3, 5.2, 3.0),
  miastoC = c(4.1, 4.2, 3.3)
  )
```


```r
sr_miasto = vector("numeric", length = ncol(pomiary))
for(i in seq_len(ncol(pomiary))){
  sr_miasto[i] = mean(pomiary[, i])
}
sr_miasto
#> [1] 1.80 4.17 3.87
```


```r
sr_dzien = vector("numeric", length = nrow(pomiary))
for(i in seq_len(nrow(pomiary))){
  sr_dzien[i] = mean(unlist(pomiary[i, ]))
}
sr_dzien
#> [1] 4.83 3.60 1.40
```


```r
apply(pomiary, MARGIN = 2, FUN = mean)
#> miastoA miastoB miastoC 
#>    1.80    4.17    3.87
```


```r
apply(pomiary, MARGIN = 1, FUN = mean)
#> [1] 4.83 3.60 1.40
```

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">W R istnieje cała rodzina funkcji poświęcona programowaniu funkcyjnemu.
Oprócz najczęściej używanych wymienionych powyżej, `lapply()` i `apply()`, istnieją również takie funkcje jak `sapply()`, `vapply()`, `tapply()`, `mapply()` i inne.</div>\EndKnitrBlock{rmdinfo}

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">Pakiet **purrr** oferuje ulepszone i rozszerzone narzędzia do programowania funkcyjnego [@R-purrr].
Przykładowo, odpowiednikiem funkcji `lapply()` w pakiecie **purrr** jest funkcja `map()`.
Ma ona dodatkowo kilka kolejnych wariantów, np. `map_df()` - która przyjmuje jako wejście listy, ale zwraca ramki danych, czy `map_dbl()` - która również przyjmuje listy, ale zwraca wartości zmiennoprzecinkowe.</div>\EndKnitrBlock{rmdinfo}

<!-- https://r4ds.had.co.nz/iteration.html#the-map-functions -->
<!-- link to purrr -->

## Zadania

<!-- peer instruction - https://journals.plos.org/ploscompbiol/article/file?id=10.1371/journal.pcbi.1006023&type=printable -->

1) Spójrz na poniższy kod, ale nie wykonuj go.
Ile razy zostanie wyświetlony tekst `"Działa!"`?


```r
for (i in c(1, 2, 4, 5, 6)){
    if (i < 2 | i >= 5)
      print("Działa!")
}
```

2) Spójrz na poniższy kod, ale nie wykonuj go.
Ile razy zostanie wyświetlony tekst `"Działa!"`?


```r
for (i in c(1, 2, 4, 5, 6)){
  for (j in 6:3){
    if (i < 2 | i >= 5)
      print("Działa!")
  }
}
```

3) Spójrz na poniższy kod, ale nie wykonuj go.
Ile razy zostanie wyświetlony tekst `"Działa!"`?


```r
for (i in c(1, 2, 4, 5, 6)){
  for (j in 6:3){
    if (i < 2 & j >= 5)
      print("Działa!")
  }
}
```

4) Spójrz na poniższy kod, ale nie wykonuj go.
Ile razy zostanie wyświetlony tekst `"Działa!"`?


```r
for (i in c(1, 2, 4, 5, 6)){
  for (j in 6:3){
    if (i < 2 | j >= 5)
      print("Działa!")
  }
}
```

5) Spójrz na poniższy kod, ale nie wykonuj go.
Ile razy zostanie wyświetlony tekst `"Działa!"`?


```r
for (i in c(1, 2, 3)){
  for (j in 6:3){
    i = i + j
    if (i < 4 | i >= 9)
      print("Działa!")
  }
}
```

<!-- stworz for 1 -->
<!-- stworz for 2 -->
<!-- stworz while 1 -->
<!-- lapply 1 -->
<!-- lapply 2 -->
<!-- apply 1 -->
