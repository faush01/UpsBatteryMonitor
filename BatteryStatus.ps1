# (Get-WmiObject -class win32_battery -property BatteryStatus | select-object BatteryStatus).BatteryStatus
# ((Get-WmiObject -class win32_battery | Select BatteryStatus).BatteryStatus | Measure -Minimum).Minimum
# ((Get-WmiObject -class win32_battery | select EstimatedChargeRemaining).EstimatedChargeRemaining | Measure -Average).Average

$bat_info = Get-WmiObject -class win32_battery
$bat_status = (($bat_info | Select BatteryStatus).BatteryStatus | Measure -Minimum).Minimum
$bat_level = (($bat_info | Select EstimatedChargeRemaining).EstimatedChargeRemaining | Measure -Average).Average

$bat_status
$bat_level
