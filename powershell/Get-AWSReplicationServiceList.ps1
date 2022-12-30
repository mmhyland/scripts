$AWSServices = Get-CimInstance Win32_Service -ComputerName $((Get-ADComputer -filter * | Where-Object { $_.DistinguishedName -Like "*Client VMs*" }).Name) -ErrorAction Ignore | Where-Object { $_.DisplayName -like "AWSRep*"}

$Count = (($AWSServices | Select-Object PSComputerName, Name, StartMode, State | Where-Object { $_.StartMode -ne 'Disabled' }).PSComputerName | Select-Object -Unique).Count

Write-Host "Current machine count is:" $Count -ForegroundColor Yellow

(($AWSServices | Select-Object PSComputerName, Name, StartMode, State | Where-Object { $_.StartMode -ne 'Disabled' }).PSComputerName) | Sort-Object -Unique