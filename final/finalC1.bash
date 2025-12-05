#!/bin/bash

url="10.0.17.6/IOC.html"

raw=$(curl -sL "$url" | \
awk -F"[><]" '/td/' | \
sed 's/<\/tr>//g' | \
sed -e 's/&amp;//g' | \
sed -e 's/<tr>//g' | \
sed -e 's/<td[^>]*>//g' | \
sed -e 's/<\/td>//g' | \
sed 's/\t//g')

echo "$raw" > IOC.txt
sed -i '1d' IOC.txt
tr -d '\r' < IOC.txt > IOC_clean.txt
mv IOC_clean.txt IOC.txt

IOCs=$(sed -n '1p;3p;5p;7p;9p;11p' IOC.txt)
echo "$IOCs" > IOC.txt
