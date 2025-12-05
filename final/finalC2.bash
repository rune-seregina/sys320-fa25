#!/bin/bash

logFile=$1
iocs=$2

logs=$(cat "$logFile")
ioctxt="$iocs"

echo "$logs" | egrep -i -f "$ioctxt" | cut -d " " -f 1,4,7 | tr -d '"' | tr -d '[' > report.txt
