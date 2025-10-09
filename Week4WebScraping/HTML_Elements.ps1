$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.21/ToBeScraped.html

# Get count of links in page
$scraped_page.Links.Count

# Display links as HTML element
$scraped_page.Links

# Display only URL and its text
$scraped_page.Links | select href, outerText

# Get outer text of every element with the tag h2
$h2s = $scraped_page.ParsedHtml.body.getElementsByTagName("h2") | select outerText
$h2s

# Print innerText of every div element that has the class "div-1"
$divs1 = $scraped_page.ParsedHtml.body.getElementsByTagName("div") | where { `
$_.getAttributeNode("class").Value -ilike "div-1" } | select innerText

$divs1
