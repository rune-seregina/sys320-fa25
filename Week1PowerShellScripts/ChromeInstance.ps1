function chromeinstance() {
$chrome = (Get-Process | Where-Object { $_.Name -ilike "*chrome*" }).Name
    if (-not $chrome) {
        Start-Process "chrome" "https://champlain.edu" 
        Write-Host "Opening Chrome..." 
        }
    else  {
        Stop-Process -Name "chrome" 
        Write-Host "Stopping Chrome..."
        }
}