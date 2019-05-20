# 8.7 
# Posiadasz listę zawierającą wartości temperatury w stopniach Fahrenheita, która została przedstawiona na początku sekcji 8.3. Stwórz pętlę for, która zamieni te wartości na stopnie Celsjusza.
pomiary_f_lista = list(
  miastoA = c(61, 14, 21),
  miastoB = c(43, 52, 30),
  miastoC = c(41, 42, 33)
)
pomiary_f_lista
# Rozwiąż powyższe zadanie używając również pętli while. Dodatkowo: spróbuj rozwiązać to zadanie używając pętli repeat.
pomiary_c_lista = vector("list", length = length(pomiary_f_lista))
i = 1
while(i <= length(pomiary_f_lista)){
  pomiary_c_lista[[i]] = (pomiary_f_lista[[i]] - 32) / 1.8
  i = i + 1
}
pomiary_c_lista

# 8.8
# Posiadasz listę zawierającą wartości odległości w milach lądowych, która została przedstawiona na początku sekcji 8.1.2. Użyj metod programowania funkcyjnego, żeby przeliczyć jej wartości na kilometry.
odl_mile = list(142, 63, 121)
mil_to_km = function(x){
  x * 1.609
}
lapply(odl_mile, mil_to_km)

# 8.9
# Posiadasz ramkę danych pomiary zawierającą wartości temperatury dla kolejnych miast, która została przedstawiona w sekcji 8.3. Napisz dwie funkcje używając pętli for - jedna, która znajdzie drugą najwyższą wartość w każdym wierszu oraz druga, która znajdzie drugą najwyższą wartość w każdej kolumnie.
pomiary = data.frame(
  miastoA = c(6.1, 1.4, -2.1),
  miastoB = c(4.3, 5.2, 3.0),
  miastoC = c(4.1, 4.2, 3.3)
)
pomiary

max_row = vector(length = nrow(pomiary))
for(i in seq_len(nrow(pomiary))){
  max_row[i] = max(pomiary[i, ])
}
max_row

max_col = vector(length = ncol(pomiary))
for(i in seq_len(ncol(pomiary))){
  max_col[i] = max(pomiary[, i])
}
max_col

# 8.10
# Rozwiąż poprzednie zadanie korzystając z metod programowania funkcyjnego zamiast pętli for.
apply(pomiary, 1, max)
apply(pomiary, 2, max)

# 8.11
# Posiadasz macierz o wymiarach czterech wierszy na sześć kolumn składającą się z kolejnych liter alfabetu.
m = matrix(LETTERS[1:24], ncol = 6, nrow = 4)
m
# Napisz funkcję wykorzystującą pętle for aby określić “sąsiadów” kolejnych liter wykorzystując sąsiedztwo oparte tylko o wspólną krawędź (ang. 4-neighborhood). Przykładowo, sąsiadem litery “A” są litery “E” i “B”.


# 9.7
# Napisz funkcję, która przyjmuje jako argument nazwę folderu, a następnie wczytuje wszystkie pliki o rozszerzeniu .csv znajdujące się w tym folderze i łączy je kolumnami.

# 9.8
# W pliku list.txt znajduje się zaszyfrowana wiadomość. Aby ją odczytać należy stworzyć odwrotność jej zawartości, tj. pierwsza linia tekstu w pliku wejściowym ma być ostatnią linią tekstu w przetworzonym obiekcie, a pierwszy znak w danej linii ma stać się ostatnim, itd. Napisz funkcję, która odszyfruje tą wiadomość.

# 4.3

# 4.8

# 6.7

# 7.8

# 7.9