#!/bin/bash

raw="report.txt"
file="/var/www/html/report.html"

echo "<html>" > "$file"
echo "<body>" >> "$file"
echo "Access Logs with Indicators" >> "$file"
echo '<table border="1" cellpadding="5">' >> "$file"

while read -r line; do
ip=$(echo "$line" | cut -d ' ' -f 1)
date=$(echo "$line" | cut -d ' ' -f 2)
page=$(echo "$line" | cut -d ' ' -f 3)

# echo "$ip $date $page"
echo "<tr><td>$ip</td><td>$date</td><td>$page</td></tr>" >> "$file"
done < "$raw"

echo "</table>" >> "$file"
echo "</body>" >> "$file"
echo "</html>" >> "$file"
