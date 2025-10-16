. (Join-Path $PSScriptRoot "gatheriocs.ps1")

$fullTable = gatherIocs
$patterns = $fullTable.Pattern
# return $patterns

$tableRecords = parseAccessLogs

$matchedRecords = $tableRecords | Where-Object {
    for ($i =0; $i -lt $patterns.Count; $i++) {
        if ($_.Page -match $patterns[$i]) {
            return $true
        } # end if block
    } # end for block
} # end where-object
           
return $matchedRecords | Format-Table -AutoSize -Wrap