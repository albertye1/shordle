clear >$(tty)

# colors
RED='\033[1;31m'
YEL='\033[1;33m'
GRN='\033[1;32m'
RES='\033[0m'

# pick the random word
KEY=$(sort -R ans.txt | awk 'NR <= 1 { print $1 }')
KEY2=$(sort -R ans.txt | awk 'NR <= 1 { print $1 }')

# echo $KEY1
# echo $KEY2

echo "we have 2 cool words. they're guaranteed to be 5 letters long. you have seven tries. now guess."
right=0
right2=0

for i in {1..7}; do
	while true; do
		echo "attempt $i: input word"
		read word
		# IFS=' ' read -r -a arr <<< "$word_tot"
		# word=${arr[0]}
		# word2=${arr[1]}
		# echo $word
		# echo $word2

		# grep finds if a word occurs in the dictionary
		if grep -Fxq "$word" words.txt; then
			resu=""
			if [[ "$right" == "1" ]]; then
				resu="     "
			else
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
			fi
			
			resu2=""
			if [[ "$right2" == "1" ]]; then
				resu2="     "
			else
				for j in {0..4}; do
					ch1=${word:$j:1}
					ch2=${KEY2:$j:1}
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
						c2=${KEY2:$k:1}
						c3=${word:$k:1}
						if [ $c1 == $c2 -a $c2 != $c3 ]; then
							nocc=$(($nocc+1))
						fi
					done
					# echo $nocc
					# echo $nbef
					# echo $j
					if [ $ch1 == $ch2 ]; then
						resu2=$resu2${GRN}$ch1${RES}
					elif [[ $nocc -gt $nbef ]]; then # this part needs to be somewhat changed
						resu2=$resu2${YEL}$ch1${RES}
					else
						resu2=$resu2${RED}$ch1${RES}
					fi
				done
			fi

			echo "$resu $resu2"
			if [ $word == $KEY ]; then
				# echo "${GRN}congrations${RES}"
				right=1
			fi
			if [ $word == $KEY2 ]; then
				right2=1
			fi
			break
		else
			echo "${YEL}word not found${RES}"
			continue
		fi
	done
	if [[ "$right" == "1" ]] && [[ "$right2" == "1" ]]; then
		break
	fi
done

if [[ "$right" == "0" || "$right2" == "0" ]]; then
	echo "${RED}ur bad lol${RES}"
fi
echo "the words were \"$KEY\" and \"$KEY2\""

read -n 1 -s -r -p "Press any key to continue"
clear >$(tty)
