#! /bin/bash

link="10.0.17.6/Assignment.html"

raw=$(curl -sL "$link" | \
awk -F"[><]" '/td/' | \
sed 's/<\/tr>//g' | \
sed -e 's/&amp;//g' | \
sed -e 's/<tr>//g' | \
sed -e 's/<td[^>]*>//g' | \
sed -e 's/<\/td>//g' | \
sed 's/\t//g')

echo "$raw" > table.txt
sed -i '1d' table.txt

temp=$(cat table.txt | cut -d $'\n' -f 1,3,5,7,9 | sed '/^$/d')
times=$(cat table.txt | cut -d $'\n' -f 2,4,6,8,10 | sed '/^$/d')
pressure=$(cat table.txt | cut -d $'\n' -f 11,13,15,17,19 | sed '/^$/d')

# paste -d " " <(printf '%s\n' "$pressure") <(printf '%s\n' "$times") <(printf '%s\n' "$temp")
