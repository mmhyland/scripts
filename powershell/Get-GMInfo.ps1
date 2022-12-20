$vCenter = 'VCENTER'
$gmName ='GM-NAME'

# Get Creds
if (!$Global:cred) {$Global:cred=Get-Credential -Credential "$env:USERDOMAIN\$env:USERNAME"}

# Connect to vCenter
$ConnectvCenter = Connect-VIServer $vCenter -Credential $Global:cred

# Get VM Info
$vm = Get-VM $gmName -ErrorAction Stop -Server $vCenter

Write-Host "Name:                   " $gmName
Write-Host "Cluster:                " ($vm|VMware.VimAutomation.Core\Get-Cluster).Name
Write-Host "Folder:                 " ($vm).Folder.Name
Write-Host "vHardware:              " ($vm).HardwareVersion
Write-Host "VMware Tools:           " ($vm).Guest.ToolsVersion
Write-Host "IP:                     " ($vm).Guest.IpAddress
Write-Host "CPUs:                   " ($vm).NumCpu
Write-Host "CPU Cores:              " ($vm).CoresPerSocket
Write-Host "CPU Hot Add Enabled:    " ($vm|Get-View).Config.CpuHotAddEnabled
Write-Host "Memory GB:              " ($vm).MemoryGB
Write-Host "Memory Hot Add Enabled: " ($vm|Get-View).Config.MemoryHotAddEnabled
Write-Host "Datastore:              " ($vm|Get-Datastore).Name
Write-Host "SCSI Controllers:       " ($vm|Get-ScsiController).Type
Write-Host "Disk Size GB:           " ($vm|Get-Harddisk).CapacityGB
Write-Host "Storage Format:         " ($vm|Get-Harddisk).StorageFormat #Thin, Thick, or EagerZeroedThick
Write-Host "Network Name:           " ($vm|Get-NetworkAdapter).NetworkName
Write-Host "Network Adapter Type:   " ($vm|Get-NetworkAdapter).Type

# Disconnect from vCenter
Disconnect-VIServer * -Confirm:$false