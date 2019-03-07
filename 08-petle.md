
# Powtarzanie {#petle}

## Pętla for


```r
for (element in wektor) {
  przetwarzanie elementu
}
```

<!-- mila lądowa = 1,609 km -->


```r
odl_mile = c(142, 63, 121)
```


```r
for (i in odl_mile) {
  print(i * 1.609)
}
#> [1] 228
#> [1] 101
#> [1] 195
```

<!-- i block -->


```r
for (i in 1:3) {
  print(odl_mile[i] * 1.609)
}
#> [1] 228
#> [1] 101
#> [1] 195
```



```r
odl_mile_l = seq_along(odl_mile)
for (i in odl_mile_l) {
  print(odl_mile[i] * 1.609)
}
#> [1] 228
#> [1] 101
#> [1] 195
```


```r
odl_mile_l = seq_along(odl_mile)
for (i in odl_mile_l) {
  odl_mile[i] = odl_mile[i] * 1.609
}
odl_mile
#> [1] 228 101 195
```


```r
odl_km = vector("numeric", length = 0)
odl_mile_l = seq_along(odl_mile)
for (i in odl_mile_l) {
  odl_km = c(odl_km, odl_mile[i] * 1.609)
}
odl_km
#> [1] 368 163 313
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

## Pętla while

<!-- https://rstudio-education.github.io/hopr/loops.html#while-loops -->

<!-- `next`, `break` -
https://adv-r.hadley.nz/control-flow.html#loops -->
<!-- `while`, `repeat` -->
<!--     pętla for stosowana w sytuacji, gdy ilość wykonań kodu jest znana przed rozpoczęciem działania pętli -->
<!--     pętla while stosowana gdy ilość wykonań nie jest znana przed zakończeniem działania pętli -->

## Programowanie funkcyjne

<!-- wektoryzacja-->
<!-- http://www.noamross.net/blog/2014/4/16/vectorization-in-r--why.html -->
<!-- *apply -->

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

1) Spójrz na poniższy kod, ale nie wykonuj go.
Ile razy zostanie wyświetlony tekst `"Działa!"`?


```r
for (i in c(1, 2, 4, 5, 6)){
  for (j in 6:3){
    if (i < 2 | i >= 5)
      print("Działa!")
  }
}
```

1) Spójrz na poniższy kod, ale nie wykonuj go.
Ile razy zostanie wyświetlony tekst `"Działa!"`?


```r
for (i in c(1, 2, 4, 5, 6)){
  for (j in 6:3){
    if (i < 2 & j >= 5)
      print("Działa!")
  }
}
```

1) Spójrz na poniższy kod, ale nie wykonuj go.
Ile razy zostanie wyświetlony tekst `"Działa!"`?


```r
for (i in c(1, 2, 4, 5, 6)){
  for (j in 6:3){
    if (i < 2 | j >= 5)
      print("Działa!")
  }
}
```

1) Spójrz na poniższy kod, ale nie wykonuj go.
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
