#Set Variables
$connServer = Read-Host "Enter Connection Server Name"


#Define functions
function Get-Creds {$Global:cred=get-credential -Credential "$env:USERDOMAIN\$env:username"}


# Connect to Horizon Connection Server
if (!$Global:cred) {Get-Creds}

# Set as a variable to keep quiet
$connection = Connect-HVServer -Server $connServer -Credential $Global:cred

$pools = (Get-HVPool).base.name

$myCol = @() # Create empty array
ForEach ($pool in $pools) {
        $poolName = Get-HVPool -PoolName $pool
        $row = " " | Select-Object PoolName, Parent, Snapshot 
        $row.PoolName = $pool
        $row.Parent = $poolName.AutomatedDesktopData.VirtualCenterNamesData.ParentVmPath
        $row.Snapshot = $poolName.AutomatedDesktopData.VirtualCenterNamesData.SnapshotPath
        $myCol += $row
    }
Write-Output $myCol | Format-Table -AutoSize

Disconnect-HVServer * -Confirm:$false