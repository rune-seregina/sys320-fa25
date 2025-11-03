#!/bin/bash

allLogs=""
file="/var/log/apache2/access.log"

function getAllLogs(){
allLogs=$(cat "$file" | cut -d' ' -f 1,4,7 | tr -d "[")
}

function pages(){
pagesAccessed=$(echo "$allLogs" | cut -d' ' -f 3)
}

function countPages {
uniquePages=$(echo "$pagesAccessed" | sort | uniq -c | sort -nr)
}

getAllLogs
pages
countPages
echo "$uniquePages"
