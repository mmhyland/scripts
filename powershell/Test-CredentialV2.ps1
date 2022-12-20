$username = Read-Host "Enter Username"
$password = Read-Host "Enter Password"
Clear-Host

Write-Host "Credentials are correct?"
Test-ADAuthentication -username $username -password $password
Clear-Variable password
