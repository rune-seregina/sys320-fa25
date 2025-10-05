<# ********************************************
Function: Format a table of log records for pages accessed by 10.x.x.x IP addresses
    Input: None
    Output: formatted table of records including IP, Time, Method, Page, Protocol, Response, Referrer, and Client
*********************************************#>
function lastTenLogs() {
$logsNotformatted = Get-Content C:\xampp\apache\logs\access.log -Tail 10
$tableRecords = @()

for($i=0; $i -lt $logsNotformatted.Count; $i++){

# split a string into words
$words = $logsNotformatted[$i].Split(" ");

$tableRecords += [pscustomobject] @{ "IP" = $words[0];
                                     "Time" = $words[3].Trim('[');
                                     "Method" = $words[4].Trim('"');
                                     "Page" = $words[6];
                                     "Protocol" = $words[7];
                                     "Response" =$words[8];
                                     "Referrer" = $words[10];
                                     "Client" = $words[11] }
} # end of for loop
return $tableRecords
}