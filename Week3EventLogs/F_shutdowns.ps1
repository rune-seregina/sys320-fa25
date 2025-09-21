<# *********************************************
    Functions: Get Computer start and shut down times
    Input: length of time for start/stop records
    Output: Formatted table of records
***********************************************#>

function Get-StartStopTime($Days) {
# Get start/stop records from Windows Events and save to a variable
# Get the last 14 days
$shutdowns = Get-EventLog System -Source "EventLog" -After (Get-Date).AddDays(-$Days)

$shutdownsTable = @() # Empty array to fill customly
for($i=0; $i -lt $shutdowns.Count; $i++){

# Creating event property value
$event = ""
if($shutdowns[$i].EventID -eq 6005) {$event="Start"}
if($shutdowns[$i].EventID -eq 6006) {$event="Shutdown"}

# Creating user property value (constant (system)
$user = "System"

# having issues with non stop/shutdown events showing, ignore them if event is empty
if ($event -ne "") {
# Adding each new line (in form of a custom object) to empty array
$shutdownsTable += [pscustomobject]@{"Time" = $shutdowns[$i].TimeGenerated;
                                       "Id" = $shutdowns[$i].EventID;
                                    "Event" = $event;
                                     "User" = $user;
                                     }
                    } # End of if empty event
} # End of for
return $shutdownsTable
} # End of function