#skrypt który będzie tworzył bazę paszportów samochodów np na firmie. "Paszport" będzie w formie pliku 
#i bedzie zawierał podstawowe informacje o pojezdzie
#skryt będzie odpowiednio segregował paszporty w foldery 
# ~/Baza_Pojazdow/
#       |- ciezarowe

#       |- osobowe
#            |- Audi
#                - TK12345.pc
#            |- Opel
#rozdział na samochody osobower i ciezarowe bedzie za pomocą argumentu do skrytu -c ciezarowy -o lub brak argumntu to samochód osobowy
#
#-------------- CAR PASSPORT ----------------- 
# Marka: ......... 
# Model: ......... 
# Rocznik: ....... 
# Numer rejestracyjny: .......... 
# Data ostatniego przegladu: DD.MM.YYYY 
# Przebieg na ostatnim przeglądzie: ...... km 
# Ostania aktualizacja odbyła się DD.MM.YYYY HH:MM:SS przez "nazwa użytkownika systemu"




read -p "Podaj markę samochodu: " marka
read -p "Podaj model samochodu: " model
read -p "Podaj rocznik samochodu: " rocznik
read -p "Podaj numer rejestracyjny samochodu: " nr_rej
read -p "Podaj datę ostatniego przeglądu i przebieg samochodu: (DD:MM:YYYY) " data_przegladu przebieg


echo "-------------- CAR PASSPORT ----------------- 
Marka: $marka
Model: $model
Rocznik: $rocznik 
Numer rejestracyjny: $nr_rej
Data ostatniego przegladu: $data_przegladu
Przebieg na ostatnim przeglądzie: $przebieg km 
Ostatnia aktualizacja odbyła się $(date +%d.%m.%Y\ %X) przez $USER > $nr_rej.pc

