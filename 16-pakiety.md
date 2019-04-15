
# Pakiety {#tworzenie-pakietow}
<!-- https://journals.plos.org/ploscompbiol/article/file?id=10.1371/journal.pcbi.1006561&type=printable -->
<!-- https://github.com/ropensci/dev_guide -->

Pakiety są powszechnie wykorzystywane podczas pracy z językiem R.
Celem sekcji \@ref(pakiety) było wprowadzenie do tego czym są pakiety, jak się je instaluje oraz dołącza. 
Najważniejszą informacją było, że pakiety są zorganizowanymi zbiorami funkcji. 
Oznacza to, że nie tylko posiadamy pewną liczbę stworzonych funkcji, ale także są one ułożone w pewien ustalony sposób.
Funkcje w pakietach posiadają też swoją dokumentację (jej struktura została przedstawiona w sekcji \@ref(dokumentacja-funkcji)) czy przykładowe dane.
Pakiety, oprócz swojej unikalnej nazwy, posiadają również informacje o swojej wersji, autorach, zależnościach i licencji.

Informacje w tym rozdziale powinny pozwolić na stworzenie podstawowego pakietu R.
Istnieje jednak wiele dodatkowych aspektów i kwestii w tym temacie, które zostały tutaj wspomniane pobieżnie lub pominięte.
W celu poznania i zrozumienia złożnych aspektów tworzenia pakietów R cennymi źródłami wiedzy może być książki [R packages](https://r-pkgs.org) [@wickham2015r] oraz [rOpenSci Packages: Development, Maintenance, and Peer Review](https://ropensci.github.io/dev_guide/) [@ropensci_2019_2554759].
Dodatkowo, w niektórych przypadkach pomocna może być oficjalna dokumentacja [Writing R Extensions](https://cran.r-project.org/doc/manuals/R-exts.html#Creating-R-packages) [@team1999writing].

## Nazwa pakietu

Nazwa nowego pakietu musi spełniać kilka wymagań: składać się tylko ze znaków [ASCII](https://en.wikipedia.org/wiki/ASCII), cyfr i kropek, mieć co najmniej dwa znaki oraz zaczynać się od litery i nie kończyć się kropką [@team1999writing]. 
Ważne jest również myślenie o nazwie pakietu tak jak o nazwach funkcji (sekcja \@ref(styl)) - nazwy pakietów powinny ułatwiać zrozumienie ich zawartości.
Dodatkowo, z uwagi na istnienie wielu pakietów warto najpierw sprawdzić czy pakiet o wymyślonej przez nas nazwie już nie istnieje.
Można to przykładowo zrobić używając pakietu **https://github.com/ropenscilabs/available** [@R-available], który sprawdza przy wybrana nazwa nie jest już zajęta oraz czy nie ma ona jakiegoś niepożądanego przez nas znaczenia.

## Tworzenie szkieletu pakietu

Kolejnym krokiem jest stworzenie szkieletu pakietu, czyli zorganizowanego zbioru plików i folderów, do których później należy dodać odpowiednie informacje i funkcje.
Znacznie w tym może pomóc pakiet **usethis** [@R-usethis], który zawiera szereg funkcji ułatwiających budowanie pakietów R.


```r
library(usethis)
```


Do stworzenia szkieletu pakietu służy funkcja `create_packages()`, w której należy podać ścieżkę do nowego pakietu.<!-- package.skeleton()  Never use this! -->
W tej ścieżce ostatnia nazwa folderu określa również nazwę pakietu.^[Funkcja również `create_packages()` sama tworzy nowy folder, jeżeli on wcześniej nie istniał.]


```r
usethis::create_package("~/Documents/mojpakiet")
```

W efekcie działania powyższej funkcji stworzony zostanie nowy folder `mojpakiet` zawierający kilka plików oraz otwarty zostanie nowy projekt RStudio zawierający ten pakiet.
Najważniejsze nowe pliki to:

1. `mojpakiet.Rproj` - plik projektu RStudio
2. `DESCRIPTION` - plik zawierający podstawowe informacje o pakiecie, w tym jego nazwę, tytuł, wersję, autorów, opis, czy licencję
3. `R/` - w tym pustym folderze konieczne będzie umieszczenie nowych funkcji R
4. `NAMESPACE` - ten plik określa, między innymi, jakie funkcje są dostępne w tym pakiecie. 
Ten plik i jego zawartość jest tworzona automatycznie

## Rozwijanie pakietu

Rozwój pakietu R może opierać się na kilku poniższych krokach:

1. Tworzenie/modyfikowanie kodu
2. Używanie funkcji `devtools::load_all()`, która dodaje nowe/zmodyfikowane funkcje do R
3. Sprawdzenie czy funkcja działa zgodnie z oczekiwaniami na kilku przykładach
4. Dodanie testów jednostkowych (sekcja \@ref(testy-jednostkowe)) na podstawie stworzonych przykładów
5. Powtórzenie powyższych czynności

## Dokumentacja funkcji

<!-- roxygen2 -->

## Zależności

## Dokumentacja pakietu

<!-- vignettes -->
<!-- usethis::use_vignette("name") -->
<!-- rmarkdown -->
<!-- rstudio helper -->
<!-- pkgdown -->
<!-- readme -->
<!-- news -->

## Wbudowane testy {#wbudowane-testy}

<!-- Unit testing -->
<!-- usethis::use_test() -->
<!-- devtools::test() -->
<!-- devtools::test_coverage() -->
<!-- https://katherinemwood.github.io/post/testthat/ -->
<!-- Automated testing with Travis CI + codecov -->

## Licencje

<!-- There are three main open source licenses -->

<!-- CC0 “public domain”, best for data packages  -->
<!-- MIT Free for anyone to do anything with -->
<!-- GPL Changes and bundles must also be GPL -->
<!-- These are gross simplifications! -->

<!-- DESCRIPTION: -->
<!-- License: file LICENSE -->
<!-- LICENSE: -->
<!-- Proprietary: do not distribute outside of -->
<!-- Widgets Incorporated. -->


## Publikowanie pakietów

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">software documentation</div>\EndKnitrBlock{rmdinfo}

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">software promotion</div>\EndKnitrBlock{rmdinfo}

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">Continuous Integration</div>\EndKnitrBlock{rmdinfo}


## Zadania
