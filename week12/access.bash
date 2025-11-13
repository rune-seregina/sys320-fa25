#!/bin/bash
 logfile="/home/champuser/week12/fileaccesslog.txt"
emailfile="/home/champuser/week12/emailform2.txt"
date=$(date)
echo "File was accessed $date" >> "$logfile"

echo "To: rune.seregina@mymail.champlain.edu" > "$emailfile"
echo "Subject: Access" >> "$emailfile"
echo "" >> "$emailfile"
cat "$logfile" >> "$emailfile"
cat "$emailfile" | ssmtp rune.seregina@mymail.champlain.edu
