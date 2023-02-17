# Shordle

Like wordle, but on bash. The dictionary is in `words.txt`, and the executable is `shordle.sh`.
The shell file can be run by typing `sh shordle.sh` or modifying `shordle.sh` as an executable
by running `chmod +x shordle.sh`.

Every time you start a game, a random word will be chosen from a list of 1000 commonly used words. 
Each word will be only five letters.

For Dordle, two random words will be chosen from the same list, and your goal is to input words until
you have guessed both of the words correctly. You are allowed 7 guesses, but you now have 2 words to 
guess.
