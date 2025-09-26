. (Join-Path $PSScriptRoot "ScrapeChamplain.ps1")

# Call full function
daysTranslator(gatherClasses)

# Call and save just full table for further parsing
$FullTable = gatherClasses
$FullTable = daysTranslator $FullTable

# List all classes of Instructor Furkan Paligu
$FullTable | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" | `
    Where-Object { $_."Instructor" -ilike "Furkan Paligu" 
    }

# List all classes of JOYC 310 on Mondays, displaying class code and times sorted by start time
$FullTable | Where-Object { ($_.Location -ilike "JOYC 310") -and ($_.Days -ilike "*Thursday*") } | `
             Sort-Object "Time Start" | `
             Select-Object "Time Start", "Time End", "Class Code" 

# Make a list of all the instructors that teach at least 1 course in
# SYS, SEC, NET, FOR, CSI, DAT
# Sort by name and make it unique
$ITSInstructors = $FullTable | Where-Object { ($_."Class Code" -ilike "SYS*") -or `
                                              ($_."Class Code" -ilike "NET*") -or `
                                              ($_."Class Code" -ilike "SEC*") -or `
                                              ($_."Class Code" -ilike "FOR*") -or `
                                              ($_."Class Code" -ilike "CSI*") -or `
                                              ($_."Class Code" -ilike "DAT*") } `
                             | Select-Object "Instructor" `
                             | Sort-Object "Instructor" -Unique

# Group all instructors by number of classes they are teaching
$FullTable | Where-Object { $_.Instructor -in $ITSInstructors.Instructor } `
           | Group-Object "Instructor" | Select-Object Count, Name | Sort-Object Count -Descending                