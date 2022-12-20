$vCenter = 'VCENTER'
$gmName ='GM-NAME'

# Get Creds
if (!$Global:cred) {$Global:cred=Get-Credential -Credential "$env:USERDOMAIN\$env:USERNAME"}

# Connect to vCenter
$ConnectvCenter = Connect-VIServer $vCenter -Credential $Global:cred

# Get VM Info
$vm = Get-VM $gmName -ErrorAction Stop -Server $vCenter

Write-Host "Name:                   " $gmName
Write-Host "Cluster:                " ($vm|VMware.VimAutomation.Core\Get-Cluster).Name #MCI Production
Write-Host "Folder:                 " ($vm).Folder.Name # 2022 GMs
Write-Host "vHardware:              " ($vm).HardwareVersion #19
Write-Host "VMware Tools:           " ($vm).Guest.ToolsVersion #At least 12.1.0
Write-Host "IP:                     " ($vm).Guest.IpAddress
Write-Host "CPUs:                   " ($vm).NumCpu
Write-Host "CPU Cores:              " ($vm).CoresPerSocket #1
Write-Host "CPU Hot Add Enabled:    " ($vm|Get-View).Config.CpuHotAddEnabled
Write-Host "Memory GB:              " ($vm).MemoryGB
Write-Host "Memory Hot Add Enabled: " ($vm|Get-View).Config.MemoryHotAddEnabled
Write-Host "Datastore:              " ($vm|Get-Datastore).Name #Tools01
Write-Host "SCSI Controllers:       " ($vm|Get-ScsiController).Type
Write-Host "Disk Size GB:           " ($vm|Get-Harddisk).CapacityGB
Write-Host "Storage Format:         " ($vm|Get-Harddisk).StorageFormat #Thin, Thick, or EagerZeroedThick
Write-Host "Network Name:           " ($vm|Get-NetworkAdapter).NetworkName #server_build
Write-Host "Network Adapter Type:   " ($vm|Get-NetworkAdapter).Type #Vmxnet3

# Disconnect from vCenter
Disconnect-VIServer * -Confirm:$false