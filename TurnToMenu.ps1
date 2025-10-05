. (Join-Path $PSScriptRoot Week4WebScraping\ApacheLogs\LastTenLogs.ps1)
. (Join-Path $PSScriptRoot Week1PowerShellScripts\ChromeInstance.ps1)
. (Join-Path $PSScriptRoot LocalUserManagement\Event-Logs.ps1)

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "-----------------------------`n"
$Prompt += "1 - Display last 10 Apache Logs`n"
$Prompt += "2 - Display last 10 failed logins for all users`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Start Chrome web browser and navigate to champlain.edu`n"
$Prompt += "5 - Exit`n"

# script runs continiously until user exits
$operation = $true

while($operation){
    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 

    # check that input is valid (1-5)
    if($choice -match '^[1-5]$') {

        # choice 1: last 10 apache logs
        if ($choice -eq 1) {
            Write-Host "You chose option 1. Displaying last 10 Apache Logs..."
            $lasttenlogs = lastTenLogs
            $lasttenlogs | Format-Table -AutoSize -Wrap
        } # end choice 1


        # choice 2: last 10 failed logins from all users
        elseif ($choice -eq 2) {
            Write-Host "You chose option 2. Displaying last 10 failed login attempts for all users..."
            $allFailures = getFailedLogins 10000 # very big number
            $lasttenfailures = $allfailures | Sort-Object TimeGenerated -Descending | Select-Object -First 10
            $lasttenfailures | Format-Table -AutoSize
        } # end choice 2

        # choice 3: display at-risk users
        elseif ($choice -eq 3) {
            Write-Host "You chose option 3. Displaying at-risk users (10+ failed login attempts)..."
            $atRiskUsers = getAtRiskUsers 10000
            if ($atRiskUsers.Count -eq 0) {
                Write-Host "No at risk users found"
            }
            else {
                Write-Host "At risk users:"
                $atRiskUsers | ForEach-Object { Write-Host $_ }
            }

        } # end choice 3

        # choice 4: open chrome & navigate to champlain.edu
        elseif ($choice -eq 4) {
            Write-Host "You chose option 4. Opening Chrome and navigating to champlain.edu..."
            chromeinstance
        } # end choice 4
        else {
            Write-Host "You chose option 5. Quitting..."
            break
        } # end choice 5
    } # end input filtering for numbers 1-5
    else {
        Write-Host "Invalid choice. Please select a number 1-5."
    }
} # end menu loop