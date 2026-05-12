read -p "Podaj liczbę kilometrów: " km
read -p "Podaj ilośc zatankowanego paliwa" litry
spalanie=$(echo "scale=2; 100*$litry/$km" | bc -l)

echo "Spalanie to: $spalanie l/100km"

