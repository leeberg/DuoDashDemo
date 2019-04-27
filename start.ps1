# UD Start Script
Import-Module .\duodash.psd1 -Force

Get-UDDashboard | Stop-UDDashboard
Get-UDRestApi | Stop-UDRestAPI
Start-DDash


