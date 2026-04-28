#! /bin/bash
#moj komentarz 
echo "Podaj o której kończysz prace"
read h_end m_end

h_now=$(($(date +%H)+2))
m_now=$(date +%M)

if [ $m_end -lt $m_now ]
then
    h_end=$((h_end-1))
    m_en=$((m_end+60))
fi

h_left=$((h_end-h_now))
m_left=$((m_end-m_now))

echo "Jest godzina: $h_now:$m_now !"
echo "Do końca szychty zostało: $h_left h $m_left min"
