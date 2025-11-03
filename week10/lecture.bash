#!/bin/bash

allLogs=""
file="/var/log/apache2/access.log"

function getAllLogs(){
allLogs=$(cat "$file" | cut -d' ' -f 1,4,7,12 | tr -d "[")
}

function pages(){
pagesAccessed=$(echo "$allLogs" | cut -d' ' -f 3)
}

function countPages {
uniquePages=$(echo "$pagesAccessed" | sort | uniq -c | sort -nr)
}

function curls() {
curls=$(echo "$allLogs" | cut -d ' ' -f 4 | grep "curl" )
}

function countingCurlAccess() {
uniqueCurls=$(echo "$curls" | sort | uniq -c | sort -nr)
}

getAllLogs

# echo "$allLogs"

# pages
# countPages
# echo "$uniquePages"

curls
# echo "$curls"
countingCurlAccess
echo "$uniqueCurls"
