$vCenter = 'VCENTER'
$vmName ='VMNAME'
$datastore = 'DATASTORE'

# Get Creds
if (!$Global:cred) {$Global:cred=Get-Credential -Credential "$env:USERDOMAIN\$env:USERNAME"}

Read-Host -Prompt "Make sure x:\$vmName\ exists then press any key to continue"

# Connect to vCenter
$ConnectvCenter = Connect-VIServer $vCenter -Credential $Global:cred

$currDir = Get-Location
$ds = Get-Datastore "$datastore"
New-PSDrive -Location $ds -Name ds -PSProvider VimDatastore -Root "\"
Set-Location ds:\
Set-Location "$vmName"
Copy-DatastoreItem -Item ds:\$vmName\* -Destination x:\$vmName\
Set-Location $currDir
Remove-PSDrive -Name ds

# Disconnect from vCenter
Disconnect-VIServer * -Confirm:$false