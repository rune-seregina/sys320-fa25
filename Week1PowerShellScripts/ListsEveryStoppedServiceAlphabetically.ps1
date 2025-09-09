$stoppedServices = Get-Service | 
    Where-Object { $_.Status -eq "Stopped" } | 
    Select-Object -Property Name | 
    Sort-Object -Property Name | ` 
    Export-Csv -Path "C:\Users\champuser\Desktop\services.csv"