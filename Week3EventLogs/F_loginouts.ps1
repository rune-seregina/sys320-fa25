<# *********************************************
    Functions: Get Login and Logout records of a user within a specified timeline
    Input: length of time for login/out records
    Output: Formatted table of records
***********************************************#>

function Get-LoginOutEvents($Days) {
# Get login and logoff records from Windows Events and save to a variable
# Get the last 14 days
$loginouts = Get-EventLog System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$Days)

$loginoutsTable = @() # Empty array to fill customly
for($i=0; $i -lt $loginouts.Count; $i++){

# Creating event property value
$event = ""
if($loginouts[$i].EventID -eq 7001) {$event="Logon"}
if($loginouts[$i].EventID -eq 7002) {$event="Logoff"}

# Creating user property value
# v1: $user = $loginouts[$i].ReplacementStrings[1]
# v2: convert SID to username
$sid = New-Object System.Security.Principal.SecurityIdentifier($loginouts[$i].ReplacementStrings[1])
$user = $sid.Translate([System.Security.Principal.NTAccount]).Value

# Adding each new line (in form of a custom object) to empty array
$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated;
                                       "Id" = $loginouts[$i].InstanceId;
                                    "Event" = $event;
                                     "User" = $user;
                                     }
} # End of for
return $loginoutsTable
} # End of function