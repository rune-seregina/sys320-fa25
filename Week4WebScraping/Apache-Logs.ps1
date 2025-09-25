<# ************************************
    Function: Get IP address from Apache logs with specific parameters
    Input: 1) Page visited or referred from
           2) HTTP Code Returned
           3) Name of the web browser
    Output: IP addresses that have visited the given page or referred from, with the given web browser, and got the given HTTP response
*************************************#>
function Get-ApacheLogIPs ($Page, $HTTPCode, $Browser) {

# Define a regex for IP addresses
$regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

# Filter logs using variable
$filteredLogs = Get-Content C:\xampp\apache\logs\access.log | Select-String $Page | Select-String $HTTPCode | Select-String $Browser

# Get IPs from logs
$ipsUnorganized = $regex.Matches($filteredLogs)
$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++){
    $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value; }

}

# Count
$ipsoftens = $ips | Where-Object { $_.IP }
$counts = $ipsoftens | Group-Object -Property IP
$counts | Select-Object Count, Name

}