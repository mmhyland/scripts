function Invoke-PingTest {
    [CmdletBinding()]
    Param(
            [Parameter(Mandatory=$False,Position=1)][string[]]$Addresses,
            [Switch]$FromFile
            )
    if (!$Addresses -or $fromFile)
        {
            $wshell = New-Object -ComObject Wscript.Shell
            $wshell.Popup("Enter Text File with IPs or Hostnames")|OUT-NULL
            [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |Out-Null
            $openFileDialog = New-Object System.Windows.Forms.openFileDialog
            $openFileDialog.filter = "TXT Files (*.txt)|*.txt"
            $openFileDialog.ShowDialog() | Out-Null
            $filesv=$openFileDialog.filename
            $Addresses = Get-Content $filesv
        }
    ForEach ($Node in $Addresses){
        $Result = ([System.Net.NetworkInformation.Ping]::new().Send($Node)).Status
        if ($Result -like "Success") {Write-Host "$Node - $Result" -ForegroundColor Green}
        else {Write-Host "$Node - $Result" -ForegroundColor Red}
	}
}


#######################################

Invoke-PingTest
