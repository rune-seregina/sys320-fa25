#! /bin/bash

authfile="/var/log/auth.log"

function getLogins(){
 logline=$(cat "$authfile" | grep "systemd-logind" | grep "New session")
 dateAndUser=$(echo "$logline" | cut -d' ' -f1,2,11 | tr -d '\.')
 echo "$dateAndUser" 
}

#function getFailedLogins(){
# Todo - 1
# a) Make a little research and experimentation to complete the function
# b) Generate failed logins and test
function getFailedLogins(){
failedLogLines=$(cat "$authfile" | grep "authentication failure" | cut -d ' ' -f 1,2,3,7,8,16 | tr -d ';')
echo "$failedLogLines"
}
# getFailedLogins
# Sending logins as email - Do not forget to change email address
# to your own email address
echo "To: rune.seregina@mymail.champlain.edu" > emailform.txt
echo "Subject: Logins" >> emailform.txt
echo "" >> emailform.txt
getFailedLogins >> emailform.txt
cat emailform.txt | ssmtp rune.seregina@mymail.champlain.edu

# Todo - 2
# Send failed logins as email to yourself.
# Similar to sending logins as email 

