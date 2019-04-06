
# Kontrola wersji {#kontrola-wersji}

<!-- https://peerj.com/preprints/3159/ -->
<!-- https://swcarpentry.github.io/git-novice/ -->
<!-- https://arxiv.org/pdf/1811.02021.pdf -->
<!-- http://happygitwithr.com/ -->
<!-- https://whattheyforgot.org/ -->
<!-- https://education.github.com/git-cheat-sheet-education.pdf -->
<!-- https://enterprise.github.com/downloads/en/github-flow-cheatsheet.pdf -->

Systemy kontroli wersji to narzędzia pozwalające na zapamiętywaniu zmian zachodzących w plikach.
Dzięki nim możemy sprawdzić nie tylko kiedy zmieniliśmy dany plik i kto go zmienił, ale co najważniejsze - możemy linia po linii prześledzić zmiany wewnątrz tego pliku.
Dodatkowo, mamy możliwość przywracania wersji pliku z wybranego czasu w całej historii jego zmian.

Systemy kontroli wersji są bardzo powszechnie wykorzystywane przy tworzeniu wszelakiego rodzaju oprogramowania.
Wynika to nie tylko z ich zalet wymienionych powyżej, ale również rozbudowanych możliwości pozwalających na współpracę wielu osób nad jednym projektem.

Istnieje wiele systemów kontroli wersji różniących się zarówno używaną terminologią, sposobem działania czy możliwościami.^[https://en.wikipedia.org/wiki/Comparison_of_version-control_software#History_and_adoption]
Współcześnie najbardziej popularnym systemem kontroli jest Git, któremu będzie poświęcona reszta tego rozdziału.
Inne popularne systemy kontroli wersji to Concurrent Versions System (CVS), Mercurial czy Subversion (SVN).

<!-- gdzie wykorzystywaneC -->
<!-- block - large files -->

## Git

System Git jest niezależny od języka (lub języków) programowania, które używamy.
Jego działanie oparte jest o system komend rozpoczynających się od słowa `git `, które należy wykonać w systemowym oknie konsoli.^[Nie w oknie konsoli R.]
Zrozumienie działania systemu Git wymaga także poznania kilku nowych terminów.

Git składa się z kilkudziesięciu komend, których działanie jest dalej uzależnione od podanych argumentów.
Tutaj przedstawiony zostanie tylko podzbiór najczęściej używanych.
Pełniejszy opis komend systemu Git można znaleźć pod adresem https://education.github.com/git-cheat-sheet-education.pdf.

### Konfiguracja systemu Git

[^Instrukcje dotyczące instalacji Gita znajdują się we wstępie książki.]


```bash
git config --global user.name "imie nazwisko"
git config --global user.email "email"
```

### Repozytorium

<!-- co to repo -->
Podstawowym z nich jest repozytorium (ang. *repository*, często określane skrótowo jako repo).
Jest to folder, który przechowuje wszystkie pliki i foldery w ramach jednego projektu.^[W kontekście R, warto o tym myśleć jako o projekcie RStudio.]
Dodatkowo wewnątrz repozytorium znajduje się ukryty folder `.git`, który zawiera informację o historii i zmianach każdego z naszych plików.
Repozytorium może znajdować się na dysku naszego komputera (wtedy jest nazywane repozytorium lokalnym) lub też na serwerze w internecie (określane jako repozytorium zdalne (ang. *remote*)).
Istnieje wiele serwisów internetowych pozwalających na tworzenie, przechowywanie i edycję repozytoriów zdalnych, między innymi [GitHub](https://github.com/) (przybliżony w sekcji \@ref(github)), [GitLab](https://gitlab.com/), czy [BitBucket](https://bitbucket.org/).


```bash

git init
```

### Dodawanie zmian


```bash
git add sciezka_do_pliku
```

### Sprawdzanie zmian


```bash
git diff
```

### Zatwierdzanie zmian

Zatwierdzanie zmian (ang. **commit**)


```bash
git commit -m "opis wprowadzonych zmian"
```

### Rozgałęzienia


```bash
git branch
```


```bash
git branch nazwa_nowej_galezi
```


```bash
git checkout nazwa_innej_galezi
```


```bash
git merge nazwa_innej_galezi
```

### Repozytorium zdalne


```bash
git remote add 
```

### ...
<!-- co to push -->

### ...
<!-- co to pull -->

<!-- podstawowy workflow -->

## Git w RStudio

<!-- Use a Git client, if you like -->

## GitHub

<!-- https://github.com/maciejkorsan/podlaskigit -->
<!-- when something go wrong -->
<!-- stackoverflow git questions -->
<!-- co to pull request -->
<!-- lista podsatwowych komend -->

## Zadania

<!-- stwórz najprostszą stronę internetową -->
