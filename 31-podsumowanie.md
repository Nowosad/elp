
# Podsumowanie {#podsumowanie}

Celem tego rozdziału jest z jednej strony podsumowanie zawatych w niej informacji, ale co ważniejsze wskazanie co można zrobić dalej na podstawie uzyskanej wiedzy i umiejętnośc z tej książki. 
Nie jest możliwe, aby jedna książka wyczerpująco pokazywała wszystkie elementy języka programowania i podawała wszelkie jego możliwości i zastosowania. 
Jest to szczególnie nieosiągalne w przypadku takiego języka jak R, który posiada ogromny zbiór pakietów, oraz społeczność, która używa ten język na wiele sposobów, co wpływa na jego ewolucję.

W jaki sposób można najbardziej efektywnie użyć wiedzę z tej książki? 
Stosując uzyskane umiejętności w praktyce. 
<!-- Może to być... -->

<!-- co było -->

## Grafika

R posiada potężne wbudowane narzędzia do tworzenia wykresów.


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


```r
boxplot(tavg ~ nazwa_stacji, data = met)
```

<img src="figures/unnamed-chunk-3-1.png" width="100%" style="display: block; margin: auto;" />


```r
library(ggplot2)
#> Registered S3 methods overwritten by 'ggplot2':
#>   method         from 
#>   [.quosures     rlang
#>   c.quosures     rlang
#>   print.quosures rlang
ggplot(met, aes(nazwa_stacji, tavg)) + geom_boxplot()
```

<img src="figures/unnamed-chunk-4-1.png" width="100%" style="display: block; margin: auto;" />

<!-- graphics -->

## Analiza danych

<!-- aka tidyverse -->
<!-- dplyr -->
<!-- tidyr -->
<!-- purrr -->
<!-- https://speakerdeck.com/jennybc/purrr-workshop?slide=91 -->
<!-- pipe %>%  -->

## Inne zastosowania

<!-- https://cran.r-project.org/web/views/ -->
<!-- maps -->
<!-- bioinformatyka -->


## Programowanie

<!-- czytanie kodu źródłowego innych osób -->
<!-- https://jennybc.github.io/wtf-2019-rsc/read-the-source.pdf -->

<!-- functional programming - 05 -->

<!-- tidy eval -->


