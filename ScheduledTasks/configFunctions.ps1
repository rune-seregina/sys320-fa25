<#************************************************
configurationMenu
    Function: runs a menu for user choice for scheduler configuration
    Input: None
    Output: None, runs until user quits
************************************************#>
function configurationMenu() {
$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "-----------------------------`n"
$Prompt += "1 - Show Configuration `n"
$Prompt += "2 - Change Configuration `n"
$Prompt += "3 - Exit `n"

$operation = $true

while($operation) {
    Write-Host $Prompt | Out-String
    $choice = Read-Host

    if($choice -match '^[1-3]$') {

        if ($choice -eq 1) {
            Write-Host "You chose option 1. Showing current configuration..."
            readConfiguration | Format-Table
        } # end choice 1

        elseif ($choice -eq 2) {
            Write-Host "You chose option 2. Changing current configuration..."
            $daysToChange = Read-Host -Prompt "Enter the number of days for which the logs will be obtained"
                if($daysToChange -match '[0-9]') {
                    $daysToChange = [int]$daysToChange
                }
                else {
                    Write-Host "Invalid input, enter a number."
                    continue
                }
            $timeToChange = Read-Host -Prompt "Enter the daily execution time of the script (format: 12:00 PM)"
            $timeRegex = '^(0?[1-9]|1[0-2]):[0-5][0-9]\s?(AM|PM)$'
                if($timeToChange -notmatch $timeRegex) {
                    Write-Host "Invalid input, please use the format 12:00 PM"
                    continue
                }
                else {
                }
            changeConfiguration($daysToChange, $TimetoChange)

        } # end choice 2
            
        elseif ($choice -eq 3) {
             Write-Host "You chose option 3. Quitting..."
             break
        } # end choice 3
    } # end input filtering 1-3
    else {
        Write-Host "Invalid choice. Please select number 1-3."
    }
} # end menu while loop
} # end configurationMenu

<#************************************************
readConfiguration
    Function: displays the current scheduler configuration as a pscustomobject
    Input: None
    Output: array of organized config
************************************************#>
function readConfiguration() {
$config = Get-Content -Path C:\Users\champuser\Desktop\ScheduledTasks\configuration.txt

$configTable = @()
$configTable += [pscustomobject]@{ "Days" = $config[0];
                                   "ExecutionTime" = $config[1];
                                 }
return $configTable

} # end readConfiguration

<#************************************************
changeConfiguration
    Function: allows the user to change days and execution time in scheduler config
    Input: Days config and Execution Time config from user
    Output: none, confirmation that config has been updated
************************************************#>
function changeConfiguration($daysToChange, $timeToChange) {
$newConfig = @($daysToChange
               $timeToChange)
Set-Content -Path "C:\Users\champuser\Desktop\ScheduledTasks\configuration.txt" -Value $newConfig
} # end changeConfiguration