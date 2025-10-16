<#*********************************************************
    Function: Scrape IOC.html
    Input: None
    Output: Table of contents with columns Pattern and Explanation
*********************************************************#>

function gatherIocs() {

$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.21/IOC.html

# Get all tr elements of HTML document
$trs = $page.ParsedHtml.body.getElementsbyTagName("tr")

# Empty array to hold results
$fullTable = @()
for($i=1; $i -lt $trs.Length; $i++) { # go through every tr element
    
    # get every td element in current tr element 
    $tds = $trs[$i].getElementsByTagName("td")

    $fullTable += [pscustomobject]@{"Pattern" = $tds[0].innerText;
                                   "Explanation" = $tds[1].innerText;
                                   }
} # end for loop
return $fullTable
} # end gatherIocs

# gatherIocs

<#*******************************************************
    Function: Format a table of log records
    Input: None
    Output: formatted table of log records including IP, time, method, page, protocol, response, and referrer
*******************************************************#>
function parseAccessLogs() {

# get file contents from access log
$logsNotFormatted = Get-Content C:\xampp\apache\logs\access-1.log

# empty array for formatting records
$tableRecords = @()

# iterate over each log 
for($i=0; $i -lt $logsNotFormatted.Count; $i++){
    # split record string into words
    $words = $logsNotFormatted[$i].Split(" ");

    $tableRecords += [pscustomobject] @{ "IP" = $words[0];
                                         "Time" = $words[3].Trim('[');
                                         "Method" = $words[5].Trim('"');
                                         "Page" = $words[6];
                                         "Protocol" = $words[7];
                                         "Response" = $words[8];
                                         "Referrer" = $words[10];
                                         }

} # end of for loop
return $tableRecords
} # end parseAccessLogs
# parseAccessLogs | Format-Table -AutoSize -Wrap