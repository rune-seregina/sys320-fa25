. (Join-Path $PSScriptRoot "F_loginouts.ps1")
. (Join-Path $PSScriptRoot "F_shutdowns.ps1")

clear 

# Get Login and Logoffs from the last 15 days
$loginoutsTable = Get-LoginOutEvents 15
$loginoutsTable

# Get Start Ups and Shut Downs from the last 25 days
$shutdownsTable = Get-StartStopTime 25
$shutdownsTable