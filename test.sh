#/bin/bash
tput sc # save cursor
printf "Something that I made up for this string"
sleep 1
tput rc;tput el # rc = restore cursor, el = erase to end of line
printf "Another message for testing"
sleep 1
tput rc;tput el
printf "Yet another one"
sleep 1
tput rc;tput el
