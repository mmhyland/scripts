$vCenter = Read-Host "Enter vCenter address"
$IP = Read-Host "Enter IP to find"
        
# Get Creds
if (!$Global:cred) {$Global:cred=Get-Credential -Credential "$env:USERDOMAIN\$env:USERNAME"}

# Connect to vCenter
$ConnectvCenter = Connect-VIServer $vCenter -Credential $Global:cred

# Gather VM info, select VMs matching the IP then display results
Get-VM * |
where-object{$_.Guest.IPAddress -match "$IP"} |
Select-Object Name,
    VMHost,
    PowerState,
    GuestId,
    @{N="IP  Address";E={@($_.guest.IPAddress[0])}} |
Format-Table

# Disconnect from vCenter
Disconnect-VIServer * -Confirm:$false
