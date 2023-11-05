#!/bin/bash

echo "--------------------------"
echo "User Name: ryuseunghwan"
echo "Student Number: 12215342"
echo "[menu]"
echo "1. Get the data of the movie identified by a specific 'movie id' from 'u.item'"
echo "2. Get the data of action genre movies from 'u.item’"
echo "3. Get the average 'rating’ of the movie identified by specific 'movie id' from 'u.data’"
echo "4. Delete the ‘IMDb URL’ from ‘u.item"
echo "5. Get the data about users from 'u.user’"
echo "6. Modify the format of 'release date' in 'u.item’"
echo "7. Get the data of movies rated by a specific 'user id' from 'u.data'"
echo "8. Get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'"
echo "9. Exit"
echo "--------------------------"

while true
do
	read -p "Enter your choice [ 1-9 ] " choice
	case $choice in
		1)
			read -p "Please enter 'movie id'(1~1682):" mvid1
			cat $1 | awk -v mv=$mvid1 'NR==mv'
			;;
		2)
			echo "Do you want to get the data of ‘action’ genre movies from 'u.item’?(y/n):" 
			read yorn1
			count=0
			if [ "$yorn1" = "y" ]
			then
				cat $1 | awk -F\| '$7==1 {print $1, $2}' |head -n 10
			fi
			;;
		3)
			read -p "Please enter the 'movie id’(1~1682):" mvid2
			
			cat $2 | awk -v mv=$mvid2 '$2==mv {sum +=$3; count++} END {print"average rating of "mv ": " sum/count}'
			;;
		4)
			read -p "Do you want to delete the 'IMDb URL fron 'u.item'?(y/n)" yorn2
			if [ "$yorn2" = "y" ]
			then
				cat $1 | sed -E 's/\|http[^\|]*\|/\|\|/g'| head -n 10
			fi
			;;
		5)
			read -p "Do you want to get the data about users from 'u.user'?(y/n): " yorn3
			if [ "$yorn3" = "y" ]
			then
				cat $3 | sed -E 's/^/user /g' | sed -E 's/\|/ is /' | sed -E 's/\|/ years old /' | sed -E 's/M\|/male /' | sed -E 's/F\|/female /'| sed -E 's/\|.....//'|head -n 10
			fi
			;;
		6)
			read -p "'release data' in 'u.item'?(y/n): " yorn4
			if [ "$yorn4" = "y" ]
			then
				cat $1 | sed -E 's/(..\-)(...)(\-....)/\3\2\1/' |sed -E 's/Jan/01/' | sed -E 's/Feb/02/' | sed -E 's/Mar/03/'| sed -E 's/Apr/04/'| sed -E 's/May/05/'| sed -E 's/Jun/06/'| sed -E 's/July/07/'| sed -E 's/Aug/08/'| sed -E 's/Sep/09/'| sed -E 's/Oct/10/'| sed -E 's/Nov/11/'| sed -E 's/Dec/12/' |sed -E 's/\-//'|sed -E 's/\-//'| tail -n 10
			fi	
			;;
		7)
			read -p "Please enter the 'user id' (1~943): " usid1

			cat $2 | sed "/^$usid1\s/!d" | sed 's/^..\s//' | sed 's/\s.//' | sed 's/\s........./\|/' | sort -n -k 1,1 |head -n -1 | tr -d '\n'

			cat $2 | sed "/^$usid1\s/!d" | sed 's/^..\s//' | sed 's/\s.//' | sed 's/\s.........//' | sort -n -k 1,1 | tail -n 1 | tr -d '\n'
			
			echo -e "\n"
			
			arr=$(cat $2 | awk -v id=$usid1 '$1==id{print $2}' | sort -n -k 1,1 | head -n 10) 
			for movie in ${arr[@]}
			do
				cat u.item | awk -F\| -v nn=$movie '$1==nn{print nn"|"$2}'
			done


			;;
		8)
			;;
		9)
			echo "Bye!"
			exit 0
			;;
	esac
done
