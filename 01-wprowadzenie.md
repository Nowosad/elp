
# Wprowadzenie {#wprowadzenie}

Programowanie, w znacznym uproszczeniu, to proces tworzenia serii instrukcji, które informują komputer jak wykonać pewne zadanie.
<!-- why we code? -->
<!-- cost of reproduction! (economy) -->
<!-- money, money, money -->
<!-- reproducibility -->

 
Programowanie komputerowe ma obecnie już długą historię<!--^[footnote o programowaniu niekomputerowym-https://en.wikipedia.org/wiki/History_of_programming_languages]--> - pierwszy język programowania Plankalkül powstał w latach 1943-1945^[https://en.wikipedia.org/wiki/Plankalk%C3%BCl].
Fortran, stworzony w roku 1957, jest nadal używany współcześnie do wielu celów, między innymi wymagających dużej wydajności obliczeń hydrologicznych, prognozowania pogody czy modelowania klimatu.
Programowanie ewoluowało i nadal ewoluuje wraz z rozwojem dostępności i możliwości komputerów.
Pojawiły się nowe pradygmaty<!--^[wyjaśnij]--> programowania oraz wiele nowych języków.
W tym samym czasie narosło również wiele mitów dotyczących programowania^[Zobacz porównanie oczekiwań i rzeczywistej pracy programisty na https://www.youtube.com/watch?v=HluANRwPyNo.].

Jednym z mitów jest to, że programowanie polega tylko siedzeniu przed ekranem komputera i wpisywaniu do niego kolejnych linii kodu.
<!-- mit, Coding is Simply the Act of Writing Code -->
<!-- mit, Coding Starts and Ends With a Computer -->
Jest to oczywiście istotna część pracy programistycznej, ale prawdopodobnie nie jest ona nawet dominująca w przeciętym dniu programisty.
Wcześniej konieczne jest zastanowienie się jaki problem rozwiązujemy oraz zaprojektowanie możliwego rozwiązania tego problemu.
Stworzony kod może okazać się być nieprzystępny dla użytkownika, słabo zoptymalizowany, lub nawet błędny. 
Dlatego też innym ważnym elementem jest testowanie kodu w celu wyłapania potencjalnych problemów.
Innym aspektem programowania jest tworzenie dokumentacji. 
Żaden program nie może zachęcić do siebie użytkowników, jeżeli nie będą oni w stanie zrozumieć jak on działa.
Dokumentacja jest też cenna dla twórców programu, szczególnie kiedy konieczne jest użycie czy modyfikacja programu kilka miesięcy po jego ostatnim użyciu.
Programy komputerowe są też zazwyczaj w dużej sieci powiązań z już istniejącymi bibliotekami czy oprogramowaniem.
Zmiana w tych bibliotekach czy oprogramowaniu może skutkować nie zawsze oczekiwanymi zmianami w stworzonym programie.
Częścią programowania jest też utrzymywanie istniejącego kodu źródłowego oraz jego ulepszanie.

Mitem również jest przekonanie, że programowanie to męskie zajęcie.
Bierze się ono z obecnej na rynku pracy struktury, w której około 75% programistów to mężczyźni a tylko 25% to kobiety. ^[http://www.smbc-comics.com/?id=1883].
Ta struktura jednak nie jest odzwierciedleniem jakichś wrodzonych umiejętności.
Za pierwszego programistę często uważa się Adę Lovelace, angielskego matematyka i poetkę^[https://en.wikipedia.org/wiki/Ada_Lovelace].
To ona w 1843 opublikowała pierwszy program komputerowy.
Jej algorytm do obliczenia liczb Bernoulliego nie został jednak przetestowany, ponieważ urządzenie do tych obliczeń (zwane maszyną analityczną) nie zostało skonstruowane.
<!-- https://www.smithsonianmag.com/smart-news/computer-programming-used-to-be-womens-work-718061/ -->
<!-- https://www.history.com/news/coding-used-to-be-a-womans-job-so-it-was-paid-less-and-undervalued -->
<!-- https://www.bbc.com/news/technology-35559439 -->
Tem mit jest też powiązany z wymienionym kilka akapitów niżej mitem samotnego programisty.
<!-- rladies -->

Kolejny jest mit wielkiego produktu.
Oznacza on, że po nauczeniu się podstaw danego języka programowanie, jest się w stanie stworzyć bardzo złożony program (np. nowy system operacyjny, skomplikowaną aplikację na telefon, czy grę komputerową).

Ten mit wiąże się również z wynienionym w kolejnym akapicie mitem samotnego programisty.

<!-- mit, You Can Master a Language in a Few Weeks -->

W popkulturze osoba, która potrafi programować spędza czas samotnie, gwałtownie wpisując kolejne linie kodu 

<!-- mit, że trzeba zapamiętać kod, etc -->
<!-- mit, there is only one good solution -->
<!-- mit, Learning ends after the course completion -->
Wiele aspektów programowania może być też znacznie ułatwionych wykorzystując odpowiednie wspierające narzędzia, takie jak edytory kodu źródłowego, debugery, zintegrowane środowska programistyczne czy systemy kontroli wersji.




W poprzednim akapicie celowo użyłem stwierdzenia "osoba, która potrafi programować" zamiast "programista".
Jest to kolejny powszechny mit, że każda osoba która potrafi stworzyć program musi od razu zostać pełnoetatowym programistą.
Pisanie programów jest narzędziem, które ma wspomóc twórcę w pewnym celu.
<!-- data science -->
<!-- mit, że programiśći są dobrzy z matematyki/być geniuszem (I don’t mind failing repeatedly, and learning from my mistakes) -->






















<!-- impostor syndrome -->

<!-- akapit o złożoności -->
<!-- historia (języki ewoluują) -->
<!-- + many ways to solve the same problem -->
<!-- geoinformacyjne przykłady -->



<!-- group work -->

<!-- https://csgillespie.github.io/efficientR/collaboration.html#coding-style -->
<!-- There are, however, general principles that most programmers agree on, such as: -->

<!--     Use modular code; -->
<!--     Comment your code; -->
<!--     Don’t Repeat Yourself (DRY); -->
<!--     Be concise, clear and consistent. -->

<!-- lista języków -->
<!-- Java, C, Python, C++, Visual Basic .NET, JavaScript, C#, PHP, SQL, Objective-C, Assembly, Perl -->
<!-- why r (https://adv-r.hadley.nz/introduction.html)-->

<!-- (\@ref(fig:rlogo)).  -->

<div class="figure" style="text-align: center">
<img src="images/Rlogo.png" alt="Logo języka programowania R." width="25%" />
<p class="caption">(\#fig:rlogo)Logo języka programowania R.</p>
</div>

<!-- gdzie zdobyć wiedzę (online resources) -->
<!-- everything takes time -->



<!-- domain knowladge -->

<!-- whyr -->

Ta książka skupia się na prezentacji głównym konceptów programistycznych używając języka R. 
W sekcji \@ref(resources) można znaleźć listę różnorodnych materiałów, książek, blogów, kursów, czy serwisów ułatwiających i wspomagających naukę R.
Istnieje także wiele wprowadzających materiałów do nauki innych języków.
Przykładowo, osoby zainteresowane nauką Pythona mogą skorzystać z książek @gries2017practical oraz @guzdial2016introduction, czy też kursów http://swcarpentry.github.io/python-novice-inflammation/oraz https://www.python-course.eu/python3_course.php. 
W pracy programistycznej przydaje się również często znajomość linii komend.
Tutaj również można użyć materiałów z kursu [Software Carpentry](https://swcarpentry.github.io/shell-novice/) lub książki [The Unix Workbench ](https://seankross.com/the-unix-workbench/) [@krossseanUnixWorkbench2017].

<!-- https://rstudio.cloud/learn/primers -->
<!-- http://jarekj.home.amu.edu.pl/?page_id=36 -->
<!-- https://speakerdeck.com/jennybc/zen-and-the-art-of-workflow-maintenance -->

## Zadania

1. Zastanów się nad mitami związanymi z programowaniem.
Czy jesteś w stanie wskazać jakieś mity nie wymienione powyżej?
