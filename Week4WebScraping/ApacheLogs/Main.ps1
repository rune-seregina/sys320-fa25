. (Join-Path $PSScriptRoot "Apache-Logs.ps1")

clear

Get-ApacheLogIPs -Page "index.html" -HTTPCode "200" -Browser "Chrome"