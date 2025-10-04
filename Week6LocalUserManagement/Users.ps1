. (Join-Path $PSScriptRoot String-Helper.ps1)

<# ******************************
getEnabledUsers
    Function: Create a function that returns a list of NAMEs AND SIDs only for enabled users
    Input: None 
    Output: names and sids for enabled users
****************************** #>
function getEnabledUsers(){

  $enabledUsers = Get-LocalUser | Where-Object { $_.Enabled -ilike "True" } | Select-Object Name, SID
  return $enabledUsers

}

<# ******************************
getNotEnabledUsers
    Function: Create a function that returns a list of NAMEs AND SIDs only for not enabled users
    Input: None
    Output: names and sids for non enabled users
****************************** #>
function getNotEnabledUsers(){

  $notEnabledUsers = Get-LocalUser | Where-Object { $_.Enabled -ilike "False" } | Select-Object Name, SID
  return $notEnabledUsers

}

<# ******************************
checkUser
    Function: Before performing action on a user, check status of that username
    Input: username to check
    Output: true if user does not already exist, false if user already exists
****************************** #>
function checkUser($name){
    $checkusername = Get-LocalUser -Name $name -ErrorAction SilentlyContinue
    if ($null -ne $checkusername) {
        return $true
    }
    else {
        return $false
        }
    }

<# ******************************
createAUser
    Function: Create a function that adds a user
    Input: username and password for new user
    Output: none
****************************** #>
function createAUser($name, $password){

   $params = @{
     Name = $name
     Password = $securePassword
   }

   $newUser = New-LocalUser @params 


   # ***** Policies ******

   # User should be forced to change password
   Set-LocalUser $newUser -PasswordNeverExpires $false

   # First time created users should be disabled
   Disable-LocalUser $newUser

}

<# ******************************
removeAUser
    Function: Create a function that removes
    Input: username for user to remove
    Output: none
****************************** #>
function removeAUser($name){
   
   $userToBeDeleted = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Remove-LocalUser $userToBeDeleted
   
}

<# ******************************
disableAUser
    Function: Create a function that disables a user
    Input: username to be disabled
    Output: none
****************************** #>
function disableAUser($name){
   
   $userToBeDeleted = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Disable-LocalUser $userToBeDeleted
   
}

<# ******************************
enableAUser
    Function: Create a function that enables a user
    Input: username to be enabled
    Output: none
****************************** #>
function enableAUser($name){
   
   $userToBeEnabled = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Enable-LocalUser $userToBeEnabled
   
}