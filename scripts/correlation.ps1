# Windows SOC Lab
# Basic Logon ID correlation

param(
    [string]$LogonId
)

if (-not $LogonId) {
    Write-Host "Usage:"
    Write-Host ".\correlation.ps1 -LogonId '0x82E7A77'"
    exit
}

Write-Host "Searching Security events for Logon ID: $LogonId"

Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
} -MaxEvents 2000 |
Where-Object {
    $_.Message -match $LogonId
} |
Select-Object TimeCreated, Id, Message |
Sort-Object TimeCreated