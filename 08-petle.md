# Powtarzanie {#petle}

W sekcji \@ref(jezyki-programowania) zostały wspomniane różne istniejące paradygmaty programowania.
Pętle `for` czy `while` (sekcje \@ref(petla-for) i \@ref(petla-while)) są przykładami programowania imperatywnego, gdzie program komputerowy postrzegany jest jako ciąg poleceń dla komputera.
Alternatywą do tego sposobu działania jest programowanie funkcyjne, w którym rozwiązanie pewnego problemu jest oparte o użycie lub stworzenie odpowiedniej funkcji (sekcja \@ref(prog-fun)).
Język R pozwala na stosowanie zarówno paradygmatu imperatywnego jak i paradygmatu funkcyjnego^[R również obsługuje paradygmat obiektowy.].

<!-- intro -->
<!-- https://recology.info/2019/03/control-flow-exceptions/ -->

## Pętla for {#petla-for}

Pęlta `for` jest jednym z najczęściej używanych wyrażeń w językach programowania^[https://en.wikipedia.org/wiki/For_loop], którego celem jest powtórzenie pewnej operacji o znaną liczbę razy.

### Składnia

Pęlta `for` jest zbudowana z dwóch elementów: nagłówka określającego powtórzenia, oraz ciała zawierającego obliczenia.


```r
for (element in wektor) {
  przetwarzanie elementu
}
```

### Przykład działania {#for-example}

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

Teraz naszym celem jest potworzenie tej operacji dla każdego elementu.


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
Dlatego w tym przypadku moglibyśmy uniknąć wielokrotnego pisania podobnego kodu używając pętli `for`.
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

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">Tradycyjnie zmienna w pętli `for` nazywana jest `i`, a w przypadku zagnieżdżonych pętli druga zmienna nazywana jest `j`.
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

Wcześniejsze przykłady wyświetlały przeliczone na kilometry kolejne elementy listy `odl_mile`.
Możliwe było zobaczenie nowych wartości, ale nie zostawały one w pamięci komputera - w efekcie nie można było wykorzystać wyników działania pętli `for` w przyszłości.
Co w takim razie należy zrobić, aby wynik dało się użyć dalej?
Jednym z podejść jest modyfikacja istniejącej list `odl_mile`.
Poniższa pętla `for` zastępuje kolejne wartości z obiektu `odl_mile` na kilometry.


```r
for (i in seq_along(odl_mile)) {
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

Niestety, w efekcie stracone zostały oryginalne wartości w milach lądowych. 


```r
odl_mile = list(142, 63, 121)
```

Aby zostawić oryginalne wartości w milach lądowych, ale też stworzyć nowy obiekt określony w kilometrach musimy stworzyć nowy, pusty obiekt, a następnie wypełnić go wartościami.
Poniżej nazwany on został `odl_km` - jest to pusta lista.
Następnie kolejne wykonania pętli `for` doklejają kolejne elementy do tej listy.


```r
odl_km = vector("list", length = 0)
for (i in seq_along(odl_mile)) {
  odl_km = c(odl_km, odl_mile[[i]] * 1.609)
}
odl_km
#> [[1]]
#> [1] 228
#> 
#> [[2]]
#> [1] 101
#> 
#> [[3]]
#> [1] 195
```

Efektem jest poprawne rozwiązanie naszego problemu, ale niestety posiada ono istotną wadę - to rozwiązanie nie jest bardzo wydajne.
Za każdym przejściem pętli następuje bowiem alokacja pamięci, co zabiera niepotrzebnie czas.
Więcej informacji na ten temat można znaleźć w rozdziale \@ref(analiza-kodu).

Lepszym rozwiązaniem w takiej sytuacji jest od razu stworzenie listy, o długości zgodnej z naszym oczekiwaniem.
Następnie kolejne elementy stworzonej listy są zamieniane na oczekiwane przez nas wartości.


```r
odl_km = vector("list", length = length(odl_mile))
for (i in seq_along(odl_mile)) {
  odl_km[[i]] = odl_mile[[i]] * 1.609
}
odl_km
#> [[1]]
#> [1] 228
#> 
#> [[2]]
#> [1] 101
#> 
#> [[3]]
#> [1] 195
```

<!-- Wiele funkcji w R jest zwektoryzowanych, w efekcie powyższy przykład można by zastąpić kodem `odl_km = odl_mile * 1.609`.  -->
<!-- Taka zamiana jest jednak możliwa w ten sposób, ponieważ mnożenie jest w niewidzialny sposób dla użytkownika rozpisane jako pętla for. -->

### Zastosowanie w funkcjach

Pętle `for`, podobnie jak wyrażenia warunkowe (sekcja \@ref(wwwf)), w naturalny sposób są stosowane w funkcjach.
Przykładowo, możemy stworzyć nową funkcję `mile_na_km()`, która przyjmuje listę z wartościami w milach lądowych jako obiekt wejściowy, a później zwraca listę z wartościami w kilometrach.


```r
mile_na_km = function(odl_mile) {
  odl_km = vector("list", length = length(odl_mile))
  for (i in seq_along(odl_mile)) {
    odl_km[[i]] = odl_mile[[i]] * 1.609
  }
  odl_km
}
```

Sprawdźmy działanie funkcji na prostym przykładzie listy z pięcioma elementami.


```r
odleglosci_mile = list(0, 1, 10, 55, 160)
mile_na_km(odleglosci_mile)
#> [[1]]
#> [1] 0
#> 
#> [[2]]
#> [1] 1.61
#> 
#> [[3]]
#> [1] 16.1
#> 
#> [[4]]
#> [1] 88.5
#> 
#> [[5]]
#> [1] 257
```

Zgodnie z oczekiwaniami zero mil lądowych to również zero kilometrów, a jedna mila lądowa to 1,609 kilometra.



## Pętla while {#petla-while}

W przypadku pętli `for` znana jest liczba powtórzeń przed rozpoczęciem jej działania.
Inny rodzaj pętli, pętla `while`, jest natomiast stosowany gdy nie wiadomo ile potworzeń jest koniecznych.
W efekcie pętla `while` jest bardziej elastyczna, co jest zarazem jej atutem i wadą.
Bardziej elastyczne metody charakteryzuje większa liczba potencjalnych sytuacji do których mogą zostać użyte, ale w efekcie też więcej potencjalnych problemów.
Pętla `while` powinna być używana tylko gdy rozwiązanie z użyciem pętli `for` nie jest możliwe. 

<!-- https://rstudio-education.github.io/hopr/loops.html#while-loops -->
<!--https://adv-r.hadley.nz/control-flow.html#loops -->

Pętla `while` składa się z nagłówka definiującego pewien warunek oraz ciała określającego operację do wykonania.
Pętla ta będzie tak długo powtarzana jak długo warunek będzie spełniony - dlatego też w ciele pętli musi być jakiś mechanizm zmieniający wartość wpływającą na warunek.


```r
while (warunek){
    wykonuj operację tak długo jak warunek jest spełniony
}
```






Wyobraźmy sobie poniższą sytuację.
Mamy 1000 zł (obiekt `budzet`) i chcemy zainwestować te pieniądze na giełdzie w celu ich pomnożenia.
Interesują nas tylko dwa scenariusze - jeden w którym tracimy całą kwotę, oraz drugi w którym udaje się nam podwoić tę kwotę.
Wiemy też jedną dodatkową rzecz - losowe wahania na giełdzie mogą pozwolić nam na stratę maksymalnie 100 zł aż do zysku 100 zł każdego dnia.
Poniższy kod wykonuje pętlę `while` tak długo jak obiekt `budzet` ma wartość większą od zera i mniejszą od 2000.


```r
budzet = 1000
liczba_dni = 0
while(budzet > 0 && budzet < 2000){
  budzet = budzet + sample(-100:100, size = 1) # losowa strata lub zysk
  liczba_dni = liczba_dni + 1
}
```

Po jego wykonaniu możemy dowiedzieć się czy udało się nam zarobić czy też stracić całe pieniądze.
Dodatkowo możemy sprawdzić ile zajęło to dni.


```r
budzet
#> [1] -33
liczba_dni
#> [1] 522
```

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">Inne istniejące rodzaje pętli to pętla `repeat` oraz pętla `do`.
Pętla `repeat` powtarza pewien kod aż do momentu przerwania go przez użytkownika (np. użycie klawisza Esc) lub do pojawienia się komendy `break`.
Działanie pętli `do` natomiast wygląda w następujący sposób:
`do {wykonuj operację} while (warunek)`.
Pętla `do` nie występuje w R.</div>\EndKnitrBlock{rmdinfo}

Dodatkowe informacje na temat pętli for and while można znaleźć w sekcji [Loops](https://adv-r.hadley.nz/control-flow.html#loops) książki Advanced R [@wickham2014advanced]

## Programowanie funkcyjne {#prog-fun}

Sprawdźmy działanie programowania funkcyjnego na dwóch przykładach.
W pierwszym posiadamy listę `pomiary_f_lista` składającą się z trzech elementów - każdy z nich to wektor z trzema pomiarami temperatury w stopniach Fahrenheita. 


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

Naszym celem jest zamiana tych wartości na stopnie Celsjusza.
Używając paradygmatu imperatywnego, moglibyśmy zastosować pętlę `for` i zastosować przeliczenie wartości dla kolejnych elementów listy.
W paradygmacie funkcyjnym natomiast naszym pierwszym krokiem jest stworzenie funkcji wykonującej podstawową operację:


```r
konwersja_f_to_c = function(temperatura_f){
    (temperatura_f - 32) / 1.8
}
```

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">Funkcje użyte w programowaniu funkcyjnym muszą spełniać dwa warunki:
  
1. Wynik działania funkcji musi zależeć od obiektu wejściowego, czyli gdy dwa razy uruchomimy tą samą funkcję na tych samych danych musimy dostać ten sam wynik.
Taka funkcja nie może mieć w sobie, np. elementu losowego.
2. Funkcja nie może mieć efektów ubocznych (ang. *side-effects*), czyli wykonywać jakiegoś działania w tle, jak np. wyświetlanie czy zapisywanie na dysk.
</div>\EndKnitrBlock{rmdinfo}

Powyższa funkcja `konwersja_f_to_c()` działa poprawnie na wektorach wartości, ale niestety nie jest w stanie zwrócić wyniku w przypadku listy, co obrazuje komunikat błędu.


```r
konwersja_f_to_c(pomiary_f_lista)
#> Error in temperatura_f - 32: non-numeric argument to binary operator
```

Języki obsługujące programowanie funkcyjne posiadają jednak szereg narzędzi do przetwarzania funkcji, które zbiorczo są nazywane funkcjonałami (ang. *functional*).
Funkcjonały to funkcje, które przyjmują inne funkcje jako argumenty.

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">W R istnieje cała rodzina funkcji poświęcona programowaniu funkcyjnemu.
Oprócz najczęściej używanych, `lapply()` i `apply()`, istnieją również takie funkcje jak `sapply()`, `vapply()`, `tapply()`, `mapply()` i inne.</div>\EndKnitrBlock{rmdinfo}

Jednym z podstawowych funkcjonałów w R jest `lapply()`.
Funkcjonał `lapply()` przyjmuje jako pierwszy argument wektor atomowy lub listę, a następnie przetwarza go używając funkcji podanej jako drugi argument `FUN`.

Poniżej, `lapply()` wykonuje funkcję `konwersja_f_to_c()` na kolejnych elementach listy `pomiary_f_lista` i zwraca nową listę zawierającą wyniki


```r
pomiary_c_lista = lapply(pomiary_f_lista, FUN = konwersja_f_to_c)
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

Programowanie funkcyjne można też stosować do innych klas obiektów.
Poniższa ramka danych `pomiary` zawiera trzy kolumny z pomiarami temperatury dla kolejnych miast. 
Dla każdego miasta wykonano jeden pomiar dziennie.


```r
pomiary = data.frame(
  miastoA = c(6.1, 1.4, -2.1),
  miastoB = c(4.3, 5.2, 3.0),
  miastoC = c(4.1, 4.2, 3.3)
)
pomiary
#>   miastoA miastoB miastoC
#> 1     6.1     4.3     4.1
#> 2     1.4     5.2     4.2
#> 3    -2.1     3.0     3.3
```

Naszym celem jest wyliczenie średnich - zarówno średniej wartości dla każdego miasta (kolumny) oraz średniej wartości dla każdego dnia (wiersze).
Możemy to zrobić używając pętli `for`.
Najpierw tworzymy pusty wektor `sr_miasto` o długości oczekiwanego wyniku, a następnie wyliczamy średnią dla kolejnych kolumn i dodajemy ją do tego wektora.


```r
sr_miasto = vector("numeric", length = ncol(pomiary))
for(i in seq_len(ncol(pomiary))){
  sr_miasto[i] = mean(pomiary[, i])
}
sr_miasto
#> [1] 1.80 4.17 3.87
```

W kolejnym kroku tworzymy pusty wektor `sr_dzien` również o długości oczekiwanego wyniku, a następnie wyliczamy średnią dla kolejnych wierszy i dodajemy ją do tego wektora.


```r
sr_dzien = vector("numeric", length = nrow(pomiary))
for(i in seq_len(nrow(pomiary))){
  sr_dzien[i] = mean(unlist(pomiary[i, ]))
}
sr_dzien
#> [1] 4.83 3.60 1.40
```

Alternatywą w takich przypadkach jest użycie programowania funkcyjnego, a w szczególności funkcjonału `apply()`.
Oczekuje on co najmniej trzech argumentów, `X` - obiektu wejściowego którym mogą być między innymi ramki danych czy macierze, `MARGIN` określającego czy wartości będą grupowane po wierszach czy kolumnach, oraz `FUN` zawierającego używaną funkcję.

W poniższym przypadku obiektem wejściowym jest ramka danych `pomiary`, `MARGIN = 2` oznacza wyliczanie oddzielnie dla kolejnych kolumn przy użyciu zdefiniowanej funkcji `mean()`.


```r
apply(pomiary, MARGIN = 2, FUN = mean)
#> miastoA miastoB miastoC 
#>    1.80    4.17    3.87
```

Podobne obliczenie, ale dla kolejnych wierszy można uzyskać zamieniając argument `MARGIN` na `1`.


```r
apply(pomiary, MARGIN = 1, FUN = mean)
#> [1] 4.83 3.60 1.40
```

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">Pakiet **purrr** oferuje ulepszone i rozszerzone narzędzia do programowania funkcyjnego [@R-purrr].
Przykładowo, odpowiednikiem funkcji `lapply()` w pakiecie **purrr** jest funkcja `map()`.
Ma ona dodatkowo kilka kolejnych wariantów, np. `map_df()` - która przyjmuje jako wejście listy, ale zwraca ramki danych, czy `map_dbl()` - która również przyjmuje listy, ale zwraca wartości zmiennoprzecinkowe.</div>\EndKnitrBlock{rmdinfo}

<!-- https://stackoverflow.com/questions/7142767/why-are-loops-slow-in-r -->
<!-- https://adv-r.hadley.nz/functionals.html -->

## Zadania {#zad8}

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

6) Posiadasz listę zawierającą wartości temperatury w stopniach Fahrenheita, która została przedstawiona na początku sekcji \@ref(prog-fun). 
Stwórz pętlę `for`, która zamieni te wartości na stopnie Celsjusza.

7) Rozwiąż powyższe zadanie używając również pętli `while`.
Dodatkowo: spróbuj rozwiązać to zadanie używając pętli `repeat`.


8) Posiadasz listę zawierającą wartości odległości w milach lądowych, która została przedstawiona na początku sekcji \@ref(for-example). 
Użyj metod programowania funkcyjnego, żeby przeliczyć jej wartości na kilometry.

9) Posiadasz ramkę danych `pomiary` zawierającą wartości temperatury dla kolejnych miast, która została przedstawiona w sekcji \@ref(prog-fun).
Napisz dwie funkcje używając pętli `for` - jedna, która znajdzie drugą najwyższą wartość w każdym wierszu oraz druga, która znajdzie drugą najwyższą wartość w każdej kolumnie. (Tutaj może pomocna okazać się funkcja `sort()`.)

10) Rozwiąż poprzednie zadanie korzystając z metod programowania funkcyjnego zamiast pętli `for`.

11) Posiadasz macierz o wymiarach czterech wierszy na sześć kolumn składającą się z kolejnych liter alfabetu. 

```r
m = matrix(LETTERS[1:24], ncol = 6, nrow = 4)
m
#>      [,1] [,2] [,3] [,4] [,5] [,6]
#> [1,] "A"  "E"  "I"  "M"  "Q"  "U" 
#> [2,] "B"  "F"  "J"  "N"  "R"  "V" 
#> [3,] "C"  "G"  "K"  "O"  "S"  "W" 
#> [4,] "D"  "H"  "L"  "P"  "T"  "X"
```
Napisz funkcję wykorzystującą pętle `for` aby określić "sąsiadów" kolejnych liter wykorzystując sąsiedztwo oparte tylko o wspólną krawędź (ang. *4-neighborhood*).
Przykładowo, sąsiadem litery "A" są litery "E" i "B".

12) Przepisz powyższą funkcję, aby wykorzystywała sąsiedztwo oparte także o wspólne punkty (ang. *8-neighborhood*).
Przykładowo, sąsiadem litery "A" są litery "E", "B" i "F".

