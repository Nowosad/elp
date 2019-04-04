
--- 
title: "Elementarz programisty"
subtitle: "Wstęp do programowania używając R"
author: "Jakub Nowosad"
date: "2019-04-04"
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: scrbook
classoption: "paper=6in:9in,pagesize=pdftex,headinclude=on,footinclude=on,10pt"
geometry: "top=1.6cm, bottom=2cm, left=2cm, right=2cm"
monofont: "Source Code Pro"
monofontoptions: "Scale=0.7"
bibliography: [references.bib, packages.bib]
biblio-style: apalike
link-citations: yes
github-repo: nowosad/my-minimal-bookdown
description: ""
graphics: yes
links-as-notes: true
---



# O książce {-}



Aktualna wersja książki znajduje się pod adresem https://nowosad.github.io/elp/. 
Jeżeli używasz tej książki, zacytuj ją jako:

- Nowosad, J., (2019). Elementarz programisty: wstęp do programowania używając R. Poznań: Space A. Online: https://nowosad.github.io/elp/

Zachęcam również do zgłaszania wszelkich uwag, błędów, pomysłów oraz komentarzy na stronie https://github.com/nowosad/elp/issues.

<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="Licencja Creative Commons" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-nd/4.0/88x31.png" /></a><br />Ta książka jest dostępna na <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/">licencji Creative Commons Uznanie autorstwa - Użycie niekomercyjne - Bez utworów zależnych 4.0 Międzynarodowe</a>.

## Wymagania wstępne {-}

Do odtworzenia przykładów oraz do wykonania zadań zawartych w tej książce konieczne jest posiadanie aktualnej wersji **R**. 
Pod adresem https://cloud.r-project.org/ można znaleźć instrukcje instalacji R dla systemów Windows, Mac OS i Linux.

W niektórych rodziałach użyte zostanie zintegrowane środowisko programistyczne **RStudio**.
Można je zainstalować korzystając ze strony https://www.rstudio.com/products/rstudio/download/#download.
<!-- https://rstudio-education.github.io/hopr/starting.html -->
<!--pakiety-->
<!-- dane -->

Aspekty dotyczące kontroli wersji zostaną omówione używając oprogramowania **Git**.
Zalecanym sposobem installacji Git na Windows jest wersja ze strony https://gitforwindows.org/.
Instrukcja instalacji na system Mac OS znajduje się pod adresem https://happygitwithr.com/install-git.html#macos.
Wersję Linuxową można zainstalować używając poniższej linii kodu:

```
# Ubuntu
sudo apt install git
```

```
# Fedora
sudo dnf install git
```

Dodatkowo, warto stworzyć konto na stronie **GitHub** poprzez adres https://github.com/join. 
GitHub jest serwisem internetowym wspierającym tworzenie oraz współpracę przy tworzeniu programów komputerowych.

## Styl książki {-}

W całej książce stosowana jest konwencja, w której `fun()` oznacza funkcje, `obi` oznacza nazwy obiektów, nazwy zmiennych oraz argumentów funkcji, a `sci/` oznacza ścieżki do plików.
Wszystkie pakiety użyte w tej książce oznaczane są pogrubioną czcionką - **pak**.

Tekst na szarym tle przedstawia blok kodu.
Może on zawierać komentarze (rozpoczynające się of znaku `#`), kod oraz wynik jego użycia (rozpoczynające się od znaków `#>`).


```r
# komentarz
kod
#> wynik użycia kodu
```

Dodatkowo, ikona kompasu na szarym tle przedstawia dodatkowe informacje, alternatywne sposoby użycia funkcji, czy też wskazówki.

\BeginKnitrBlock{rmdinfo}<div class="rmdinfo">Tutaj może znaleźć się dodatkowa informacja, alternatywny sposób użycia funkcji, czy też wskazówka.</div>\EndKnitrBlock{rmdinfo}

## Podziękowania {-}

Książka została stworzona w R [@R-base] z wykorzystaniem pakietów **bookdown** [@R-bookdown], **rmarkdown** [@R-rmarkdown], **knitr** [@R-knitr] oraz programu [Pandoc](http://pandoc.org/). 

<div>Użyte ikony zostały stworzone przez <a href="https://www.freepik.com/" title="Freepik">Freepik</a> z <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> na licencji <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0." target="_blank">CC 3.0 BY</a>.</div>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
  ga('create', 'UA-47892233-2', 'auto');
  ga('send', 'pageview');
</script>

