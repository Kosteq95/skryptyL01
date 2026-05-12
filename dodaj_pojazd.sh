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

set -e

function pobierz_dane
{
    licznik=0

    while [ -z "$dana" ]
    do
        read -p "Podaj $1 samochodu: " dana
        licznik=$((licznik+1))

        if [ $licznik -gt 3 ]
        then
            echo "Nie podałeś wymaganych danych" 1>&2
            exit 2
        fi
    done
    
    echo $dana
}



typ="osobowe"

if [ "$1" = "-c" ] 
then
 typ="ciezarowe"
elif [ -n "$1" ] && [ "$1" != "-o" ]
then
    echo "Nie poprawny argument typu pojazdu" 1>&2
    exit 1
fi

#read -p "Podaj markę samochodu: " marka
marka=$(pobierz_dane "markę")
model=$(pobierz_dane "model")

isok=0
while [ $isok -eq 0 ]
do
    rocznik=$(pobierz_dane "rocznik")
    set +e
    zmienna=$(echo "$rocznik" | grep -icE "[A-Z]")
    set -e
    if [ $zmienna -eq 1 ]
    then 
        echo "Pozadno tekst zamiast roku!"
    elif [ $rocznik -lt 1884 ] || [ $rocznik -gt $(date +%Y) ]
    then
        echo "Takie auto nie może istnieć podaj rocznik z zakresy 1884 do $(date +%Y)"
    else
        isok=1
    fi
done

nr_rej=$(pobierz_dane "numer rejestracyjny")

isok=0
while [ $isok -eq 0 ]
do
    data_przegladu=$(pobierz_dane "datę przegladu")
    # DD.MM.YYYY
    dzien=$(echo $data_przegladu | cut -d "." -f 1)
    miesiac=$(echo $data_przegladu | cut -d "." -f 2)
    rok=$(echo $data_przegladu | cut -d "." -f 3)

    if [ $dzien -lt 0 ] || [ $dzien -gt 31 ] || [ $miesiac -lt 0 ] || [ $miesiac -gt 12 ] || [ $rok -lt $(($(date +%Y)-20)) ] || [ $rok -gt $(date +%Y) ] || ( [ $dzien -gt 30 ] && [[ $miesiac == [0][469] ]] )
    then
        echo "nie poprawna data"
    else
        isok=1
    fi 
done

przebieg=$(pobierz_dane "przebieg")

dir_path="$HOME/Baza_Pojazdow/$typ/$marka"

if ! [ -d $dir_path ]
then
  mkdir -p $dir_path
fi

echo "-------------- CAR PASSPORT ----------------- 
Marka: $marka
Model: $model
Rocznik: $rocznik 
Numer rejestracyjny: $nr_rej
Data ostatniego przegladu: $data_przegladu
Przebieg na ostatnim przeglądzie: $przebieg km 
Ostatnia aktualizacja odbyła się $(date +%d.%m.%Y\ %X) przez $USER" > "$dir_path/$nr_rej.pc"

