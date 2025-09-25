# List all of the apache logs of xampp
Get-Content C:\xampp\apache\logs\access.log -Tail 5

# List last 5 Apache logs
Get-Content C:\xampp\apache\logs\access.log -Tail 5

# Display only Logs that contain 404 or 400 error
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ' , '400 '

# Display only logs that do not contain 200 OK status code
Get-Content C:\xampp\apache\logs\access.log | Select-String -NotMatch ' 200 '

# From every .log file in the directory, only get logs with the word "error" as an array
$A = Get-ChildItem C:\xampp\apache\logs\*.log | Select-String -AllMatches 'error'
    # Display last 5 elements of result array
$A[-5..-1]

# Display only IP addresses for 404 records
 # Get only logs that contain 404 and save to $notfounds
$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 '

    # Define a regex for IP addresses
$regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

    # Get $notfounds records that match to the regex
$ipsUnorganized = $regex.Matches($notfounds)

    # Get ips as pscustom object
$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++){
    $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value; }
}

# Count IPs from number 7
$ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
$counts = $ipsoftens | Group-Object -Property IP
$counts | Select-Object Count, Name