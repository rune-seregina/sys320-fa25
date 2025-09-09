# Get IPv4 Address from Ethernet Interface
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet" }).IPAddress

# Get IPv4 PrefixLength from Ethernet Interface
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet" }).PrefixLength

# Show what classes there are of Win32 library that start with Net, sort alphabetically
Get-WmiObject -List | Where-Object { $_.Name -ilike "Win32_Net*" } | Sort-Object

# Get-DHCP Server IP, hiding the table headers
Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" ` | select  DHCPServer | Format-Table -HideTableHeaders

# Get DNS Server IPs and Display only the first one
(Get-DnsClientServerAddress -AddressFamily IPv4 | ` Where-Object { $_.InterfaceAlias -ilike "Ethernet" }).ServerAddresses[0]

# Choose a directory with some .ps1 files, list files based on file name
cd C:\Users\champuser\psscripts
$files = (Get-ChildItem)
for ($j=0; $j -le $files.Count; $j++){
    if ($files[$j].Name -ilike "*ps1"){
        Write-Host $files[$j].Name
    }
}

# Create outfolder if doesn't already exist
$folderpath="$PSScriptRoot\outfolder"
if (Test-Path -Path $folderpath){
    Write-Host "Folder Already Exists"
}
else{
    New-Item -ItemType Directory -Path $folderpath
}

# list files in directory, save results of files that have .ps1 extension to "outfolder"
cd C:\Users\champuser\psscripts
$files = (Get-ChildItem)

$folderPath = "$PSScriptRoot/outfolder/"
$filePath = Join-Path $folderPath "out.csv"
$files | Where-Object { $_.Extension -eq ".ps1" } | ` Export-Csv -Path $filePath

# without changing directory to outfolder, find every .csv recurseively and change the extensions to .log, display all files
cd C:\Users\champuser\Desktop
$files = Get-ChildItem -Recurse -File
$files | Rename-Item -NewName { $_.Name -replace '.csv', '.log' }
Get-ChildItem -Recurse -File