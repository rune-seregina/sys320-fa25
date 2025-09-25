. (Join-Path $PSScriptRoot "Apache-Logs.ps1")
. (Join-Path $PSScriptRoot "Parse-Apache-Logs.ps1")

clear

Get-ApacheLogIPs -Page "index.html" -HTTPCode "200" -Browser "Chrome"
$tableRecords = ApacheLogs1
$tableRecords | Format-Table -AutoSize -Wrap