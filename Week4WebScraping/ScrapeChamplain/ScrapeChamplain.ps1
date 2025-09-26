<#*************************************************************
    Function: Scrape Courses.HTML and save contents to a custom object
    Input: None
    Output: Table of contents with columns Class Code, Title, Days, Time Start, Time End, Instructor, Location
*************************************************************#>
function gatherClasses() {

$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.21/Courses.html

# Get all the tr elements of HTML document
$trs = $page.ParsedHtml.body.getElementsbyTagName("tr")

# Empty array to hold results
$FullTable = @()
for($i=1; $i -lt $trs.Length; $i++){ # Going over every tr element

    # Get every td element of current tr element 
    $tds = $trs[$i].getElementsByTagName("td")

    # seperate start time and end time (previously one field)
    $Times = $tds[5].innerText.Split("-")

    $FullTable += [pscustomobject]@{"Class Code" = $tds[0].innerText;
                                    "Title"      = $tds[1].innerText;
                                    "Days"       = $tds[4].innerText;
                                    "Time Start" = $Times[0];
                                    "Time End"   = $Times[1];
                                    "Instructor" = $tds[6].innerText;
                                    "Location"   = $tds[9].innerText;
                                    }
    } # end of for loop
    return $FullTable
}

<#***********************************************************
    Function: translates days from ScrapeChamplain function to an array of days for readability
    Input: $FullTable from gatherClasses
    Output: $FullTable with translated days
***********************************************************#>

function daysTranslator($FullTable){

# Go over every record in the table
for ($i=0; $i -lt $FullTable.length; $i++){
    
    # Empty array to hold days for every record
    $Days = @()

    # If you see "M" -> Monday
    if($FullTable[$i].Days -ilike "M") { $Days += "Monday" }

    # If you see "T" followed by T,W, or F -> Tuesday
    if($FullTable[$i].Days -ilike "*T[TWF]*") { $Days += "Tuesday" }

    # If you see "W" -> Wednesday
    if($FullTable[$i].Days -ilike "*W*") { $Days += "Wednesday" }

    # If you see "TH" -> Thursday
    if($FullTable[$i].Days -ilike "*TH*") { $Days += "Thursday" }

    # If you see "F" -> Friday
    if($FullTable[$i].Days -ilike "*F*") { $Days += "Friday" }

    # Make the switch
    $FullTable[$i].Days = $Days
}
return $FullTable
}
