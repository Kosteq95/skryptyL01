#! /bin/bash
#moj komentarz 

h_end=18

h_now=$(($(date +%H)+2))
m_now=$(date +%M)

h_left=$((h_end-h_now-1))
m_left=$((60-$m_now))

echo "Jest godzina: $h_now:$m_now !"
echo "Do końca szychty zostało: x:y"
