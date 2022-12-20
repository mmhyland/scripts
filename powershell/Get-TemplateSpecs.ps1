function Get-TemplateSpecs {
    [CmdletBinding()]
    Param([Parameter(Mandatory=$True)][string]$vCenter)
			
	# Get Creds
	if (!$Global:cred) {$Global:cred=Get-Credential -Credential "$env:USERDOMAIN\$env:USERNAME"}

	# Connect to vCenter
	$ConnectvCenter = Connect-VIServer $vCenter -Credential $Global:cred

	# Gather/Show Info
	#foreach($gm in Get-Template){
	foreach($gm in Get-Template | Where-Object {$_.Name -match 'TEMPLATE-NAME'}){
        $gm.ExtensionData.Config.Hardware | 
        Select-Object @{N="Template";E={$gm.Name}}, NumCPU, NumCoresPerSocket, MemoryMB
    }

	# Disconnect from vCenter
	Disconnect-VIServer * -Confirm:$false

}

#######################################

Get-TemplateSpecs
