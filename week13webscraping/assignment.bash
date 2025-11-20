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
tr -d '\r' < table.txt > table_clean.txt
mv table_clean.txt table.txt

temp=$(sed -n '1p;3p;5p;7p;9p' table.txt)
times=$(sed -n '2p;4p;6p;8p;10p' table.txt)
pressure=$(sed -n '11p;13p;15p;17p;19p' table.txt)

# echo "$temp" | cat -A
# echo ""
# echo "$times" | cat -A
# echo ""
# echo "$pressure" | cat -A
# echo ""

paste -d ' ' <(printf '%s\n' "$pressure") <(printf '%s\n' "$temp") <(printf '%s\n' "$times")
