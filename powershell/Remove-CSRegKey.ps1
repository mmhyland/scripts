$reg1="HKLM:\SYSTEM\CrowdStrike\{9b03c1d9-3138-44ed-9fae-d9f4c034b88d}\{16e0423f-7058-48c9-a204-725362b67639}\Default\"
$reg2="HKLM:\SYSTEM\CurrentControlSet\Services\CSAgent\Sim\"
$name="AG"
$reg1status=(Get-ItemProperty $reg1 -EA Ignore).PSObject.Properties.Name -contains $name
$reg2status=(Get-ItemProperty $reg2 -EA Ignore).PSObject.Properties.Name -contains $name
Write-Host "Crowdstrike Registry Entry 1:" $reg1status
Write-Host "Crowdstrike Registry Entry 2:" $reg2status
Read-Host -Prompt "Press any key to continue or CTRL+C to quit" 
Write-Host "Deleting Crowdstrike Registry Entries" -ForegroundColor Yellow
Remove-ItemProperty -Path "HKLM:\SYSTEM\CrowdStrike\{9b03c1d9-3138-44ed-9fae-d9f4c034b88d}\{16e0423f-7058-48c9-a204-725362b67639}\Default\" -Name "AG"
Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\CSAgent\Sim\" -Name "AG"
$reg1status=(Get-ItemProperty $reg1 -EA Ignore).PSObject.Properties.Name -contains $name
$reg2status=(Get-ItemProperty $reg2 -EA Ignore).PSObject.Properties.Name -contains $name
Write-Host "Crowdstrike Registry Entry 1:" $reg1status
Write-Host "Crowdstrike Registry Entry 2:" $reg2status
Read-Host -Prompt "Press any key to close" 