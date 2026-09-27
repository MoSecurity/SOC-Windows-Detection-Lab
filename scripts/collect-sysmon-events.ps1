# Windows SOC Lab
# Collect selected Sysmon telemetry

$Events = @(1,3,11)

foreach ($EventId in $Events) {

    Write-Host "Collecting Sysmon Event ID $EventId..."

    Get-WinEvent -FilterHashtable @{
        LogName = 'Microsoft-Windows-Sysmon/Operational'
        Id = $EventId
    } -MaxEvents 100 |
    Select-Object TimeCreated, Id, ProviderName, Message
}