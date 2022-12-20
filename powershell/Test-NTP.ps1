$NTPServer=Read-Host "Enter the NTP server to test"
$TestCount=Read-Host "Enter the number of tests to run"

w32tm /stripchart /computer:$NTPServer /dataonly /samples:$TestCount