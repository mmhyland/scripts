$vCenter = Read-Host "Enter vCenter address"
        
# Get Creds
if (!$Global:cred) {$Global:cred=Get-Credential -Credential "$env:USERDOMAIN\$env:USERNAME"}

# Connect to vCenter
$ConnectvCenter = Connect-VIServer $vCenter -Credential $Global:cred

# Gather VM info, select VMs not matching "win" then display results
Get-VM |
Where-Object{$_.ExtensionData.Config.GuestFullname -notmatch "win"} |
Select-Object Name,
    @{N="Configured OS";E={$_.ExtensionData.Config.GuestFullname}},
    @{N="Running OS";E={$_.Guest.OsFullName}} |
Format-Table

# Uncomment to export to a CSV
#Export-Csv "$((Get-Date).ToString("yyyy-MM-dd-HHmmss"))_LinuxVMs.csv" -NoTypeInformation -Encoding UTF8