Get-VM |
Where-Object{$_.ExtensionData.Config.GuestFullname -notmatch "win"} |
Select-Object Name,
    @{N="Configured OS";E={$_.ExtensionData.Config.GuestFullname}},
    @{N="Running OS";E={$_.Guest.OsFullName}} |
Export-Csv "$((Get-Date).ToString("yyyy-MM-dd-HHmmss"))_LinuxVMs.csv" -NoTypeInformation -Encoding UTF8