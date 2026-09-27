# Windows SOC Lab
# Collect selected Windows Security Events

$Events = @(4624,4625,4672,4688,4720,4728,4732)

foreach ($EventId in $Events) {

    Write-Host "Collecting Event ID $EventId..."

    Get-WinEvent -FilterHashtable @{
        LogName = 'Security'
        Id = $EventId
    } -MaxEvents 100 |
    Select-Object TimeCreated, Id, ProviderName, Message
}