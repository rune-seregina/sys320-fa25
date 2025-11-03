. "C:\Users\champuser\Desktop\ScheduledTasks\Email.ps1"
. "C:\Users\champuser\Desktop\ScheduledTasks\Scheduler.ps1"
. "C:\Users\champuser\Desktop\ScheduledTasks\configFunctions.ps1"
. "C:\Users\champuser\Desktop\LocalUserManagement\Event-Logs.ps1"

# Obtaining configuration
$configuration = readConfiguration
$configuration

# Obtaining at risk users
$Failed = getAtRiskUsers $configuration.Days

SendAlertEmail ($Failed | Format-Table | Out-String)

# Setting the script to be run daily
ChooseTimeToRun($configuration.ExecutionTime)