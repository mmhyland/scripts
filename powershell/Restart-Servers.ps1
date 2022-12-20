[CmdletBinding()]
    Param(
        [Parameter(Mandatory=$False,Position=1)][string[]]$Servers
        )

if (!$Global:cred) {$Global:cred=get-credential -Credential "$env:USERDOMAIN\$env:username"}

if (!$Servers)
    {
        $wshell = New-Object -ComObject Wscript.Shell
        $wshell.Popup("Enter Text File with Server Names")|OUT-NULL
        [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |Out-Null
        $openFileDialog = New-Object System.Windows.Forms.openFileDialog
        $openFileDialog.filter = "TXT Files (*.txt)|*.txt"
        $openFileDialog.ShowDialog() | Out-Null
        $filesv=$openFileDialog.filename
        $Servers = Get-Content $filesv
    }
ForEach($s in $Servers){
	Restart-Computer -Computername $s -Force -Credential $Global:cred
}