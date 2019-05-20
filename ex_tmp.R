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
neigh = function(x){
  for (i in seq_len(ncol(x))){
    for (j in seq_len(nrow(x))){
      main = x[j, i]
      n1_i = i - 1
      n1_j = j - 1
      n1 =  x[n1_j, n1_i]

      cat("Główna litera: ", main, 
          " Sąsiad 1:", n1, "\n")
    }
  }
}

neigh(m)

# 9.7
# Napisz funkcję, która przyjmuje jako argument nazwę folderu, a następnie wczytuje wszystkie pliki o rozszerzeniu .csv znajdujące się w tym folderze i łączy je kolumnami.
reader_joiner = function(dir_name){
  file_names = dir(dir_name, pattern = "*.csv$", full.names = TRUE)
  x = lapply(file_names, read.csv)
  y = do.call(cbind, x)
  y
}

dir_name = "pliki"

# 9.8
# W pliku list.txt znajduje się zaszyfrowana wiadomość. Aby ją odczytać należy stworzyć odwrotność jej zawartości, tj. pierwsza linia tekstu w pliku wejściowym ma być ostatnią linią tekstu w przetworzonym obiekcie, a pierwszy znak w danej linii ma stać się ostatnim, itd. Napisz funkcję, która odszyfruje tą wiadomość.
tekst = readLines("pliki/list.txt")
stringi::stri_reverse(tekst)[length(tekst):1]

# 4.3
# Napisz funkcję, która przyjmuje trzy zmienne logiczne x, y i z. Jeżeli tylko jedna lub trzy ze zmiennych ma wartość TRUE wyświetl tekst "Nieparzysta liczba.", natomiast jeżeli dwie zmienne mają wartość TRUE wyświetl tekst "Parzysta liczba."
trzy_zmienne = function(x, y, z){
  how_many_true = sum(c(x, y, z))
  if (how_many_true %in% c(1, 3)){
    print("Nieparzysta liczba.")
  } else if (how_many_true == 2){
    print("Parzysta liczba.")    
  }
}

trzy_zmienne(TRUE, TRUE, FALSE)

# 6.7
# Stwórz funkcję, która przyjmując przykładowe dane z poprzedniego zadania zamieni współrzędne na format w postaci stopni dziesiętnych (np. 52°24′N w formacie DMS to 52.4 w stopniach dziesiętnych). 
wsp = c("52°24′N 16°55′E", "53°08′07″N 23°08′44″E", "39°6′N 84°31′W")
x = wsp

format_coords = function(x){
  # direction = stringr::str_extract_all(x, pattern = "[NSEW]")
  coords = stringr::str_extract_all(x, pattern = "([0-9]|[ ])")
  coords = lapply(coords, as.numeric)
  coords = lapply(coords, paste0, collapse = "")
  coords = stringr::str_split(coords, pattern = "NA")
  lat = unlist(lapply(coords, "[", 1))
  lon = unlist(lapply(coords, "[", 2))
  
  df = data.frame(lat = lat, lon = lon)
  df$lat_st = as.numeric(stringr::str_sub(df$lat, 1, 2))
  df$lat_mi = as.numeric(stringr::str_sub(df$lat, 3, 4))
  df$lat_se = as.numeric(stringr::str_sub(df$lat, 5, 6))
  d + (min/60) + (sec/3600)
  df$lat_res = df$lat_st + (df$lat_mi / 60) + ifelse(is.na(df$lat_se), 0, (df$lat_se / 3600))
  
  df
}

# 7.8
# Stwórz nową ramkę danych, ra1, która składa się z dwóch kolumn i trzech wierszy. Pierwsza kolumna data zawiera datę z dziś, wczoraj i przedwczoraj, a kolumna miasto zawiera nazwę miasta w którym się właśnie znajdujesz.
# Stwórz nową ramkę danych, ra2, która również składa się z dwóch kolumn i trzech wierszy. Kolumna tmin zawiera wartości 5.3, 4.6, 2.9, a kolumna tmax zawiera wartości 11.1, 14.6, 9.
ra1 = data.frame(data = seq(Sys.Date(), Sys.Date() - 2, by = -1),
                 miasto = c("Poznań"))
ra1
ra2 = data.frame(tmin = c(5.3, 4.6, 2.9),
                 tmax = c(11.1, 14.6, 9))
ra2

# Połącz dwie stworzone ramki danych ra1 i ra2 tworząc obiekt ra3. Używając obiektu ra3 wylicz średnią temperaturę dla każdego wiersza i wpisz ją w nową kolumnę tmean.
ra3 = cbind(ra1, ra2)
ra3
ra3$tavg = rowMeans(ra3[c("tmin", "tmax")])
ra3

# 7.9
# Zmień nazwę drugiej kolumny w obiekcie ra3 na "tmaks", a trzeciej na "tsr".
colnames(ra3)[c(4, 5)] = c("tmaks", "tsr")
ra3
