#!/bin/bash
clear >$(tty)

# colors
RED='\033[1;31m'
YEL='\033[1;33m'
GRN='\033[1;32m'
RES='\033[0m'

# pick the random word
KEY=$(shuf ans.txt | awk 'NR <= 1 { print $1 }')
# echo $KEY

echo "we have a cool word. it's guaranteed to be 5 letters long. you have six tries. now guess."
right=0
error=0

for i in {1..6}; do
	while true; do
		if [[ "$error" == "0" ]]; then 
			echo "attempt $i: input a line"
		fi
		tput sc
		read word
		# grep finds if a word occurs in the dictionary
		if grep -Fxq "$word" words.txt; then
			error=0
			resu=""
			for j in {0..4}; do
				ch1=${word:$j:1}
				ch2=${KEY:$j:1}
				nocc=0
				nbef=0
				for k in {0..4}; do
					if [ $k == $j ]; then
						break
					fi
					c=${word:$k:1}
					if [ $ch1 == $c ]; then
						nbef=$(($nbef+1))
					fi
				done
				for k in {0..4}; do
					c1=${word:$j:1}
					c2=${KEY:$k:1}
					c3=${word:$k:1}
					if [ $c1 == $c2 -a $c2 != $c3 ]; then
						nocc=$(($nocc+1))
					fi
				done
				# echo $nocc
				# echo $nbef
				# echo $j
				if [ $ch1 == $ch2 ]; then
					resu=$resu${GRN}$ch1${RES}
				elif [[ $nocc -gt $nbef ]]; then # this part needs to be somewhat changed
					resu=$resu${YEL}$ch1${RES}
				else
					resu=$resu${RED}$ch1${RES}
				fi
			done
			tput rc;tput el
			tput sc
			echo -e $resu
			if [ $word == $KEY ]; then
				echo "${GRN}congrations${RES}"
				right=1
			fi
			break
		else
			tput rc;tput el
			echo -e "${YEL}word not found${RES}"
			error=1
			sleep 0.25
			tput rc;tput el
			continue
		fi
	done
	if [[ "$right" == "1" ]]; then
		break
	fi
done

if [[ "$right" == "0" ]]; then
	echo -e "${RED}ur bad lol${RES}"
fi
echo "the word was \"$KEY\""

read -n 1 -s -r -p "Press any key to continue"
clear >$(tty)
