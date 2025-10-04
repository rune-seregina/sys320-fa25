<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}

<# ******************************
checkPassword
    Function: Before creating a new user, check that password meets password requirements
    Input: password to check
    Output: true if password meets requirements, false if password does not meet requirements
****************************** #>
function checkPassword($password) {
    if ($password.Length -lt 6) {
        return $false
    }
    if ($password -notmatch '[!@#$%^&*()_\-+=\[\]{};:''"",.<>\?\\|]') {
        return $false
    }
        if ($password -notmatch '[0-9]') {
        return $false
    }
        if ($password -notmatch '[a-zA-Z]') {
        return $false
    }
    return $true
}