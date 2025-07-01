#!/bin/bash


read -p "Trier les processus par mémoire ou cpu ? (m/c) " choice
read -p "Combien de processus à afficher ? " number
echo ""

total_number=$((number+1))

if [ "$choice" == "m" ]
then
	ps aux --sort -%mem |egrep "$USER|MEM" |head -n$total_number
elif [ "$choice" == "c" ]
then
	ps aux --sort -%cpu |egrep "$USER|CPU" |head -n$total_number
else
echo "Mauvais choix"
fi
