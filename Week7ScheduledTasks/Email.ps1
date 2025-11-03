<#************************************************
SendAlertEmail
    Function: sends an alert email with a user input body
    Input: body of email
    Output: none
************************************************#>
function SendAlertEmail($Body){

$From = "rune.seregina@mymail.champlain.edu"
$To = "rune.seregina@mymail.champlain.edu"
$Subject = "Suspicious Activity"


$Password = "gcdh nsbl lsmk idwm" | ConvertTo-SecureString -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password

Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer "smtp.gmail.com" -port 587 -UseSsl -Credential $Credential

}

#SendAlertEmail "Body of Email"