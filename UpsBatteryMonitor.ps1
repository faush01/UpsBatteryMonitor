# C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe

$log_path = $PSScriptRoot + "\battery_status_log.txt"
#Write-Output "$log_path"

$date_format = "[yyyy-MM-dd HH:mm:ss]"
$ds = (Get-Date).ToString($date_format)
(Get-Date).ToString($date_format) + " - Battery Monitor Started" >> $log_path

$bat_info = Get-WmiObject -class win32_battery
$bs = (($bat_info | Select BatteryStatus).BatteryStatus | Measure -Minimum).Minimum
$ecr = (($bat_info | Select EstimatedChargeRemaining).EstimatedChargeRemaining | Measure -Average).Average
"$ds - Status:$bs Cap:$ecr%" >> $log_path

While ($true) {

	$bat_info = Get-WmiObject -class win32_battery
	$bs = (($bat_info | Select BatteryStatus).BatteryStatus | Measure -Minimum).Minimum
	
	if($bs -eq 1) {
		$ds = (Get-Date).ToString($date_format)
		$ecr = (($bat_info | Select EstimatedChargeRemaining).EstimatedChargeRemaining | Measure -Average).Average
		"$ds - Status:$bs Cap:$ecr%" >> $log_path
		if($ecr -lt 80) {
			"$ds - BAT LOW!! Shutting Down" >> $log_path
			shutdown /s
		}
	}
	Start-Sleep -Seconds 30
}

#if($BatteryStatus) {
#    switch ($BatteryStatus)
#    {
#    1 { "Discharging" }
#    2 { "ONACMaybeNotCharging" }
#    3 { "FullyCharged" }
#    4 { "Low" }
#    5 { "Critical" }
#    6 { "Charging" }
#    7 { "ChargingAndHigh" }
#    8 { "ChargingAndLow" }
#    9 { "ChargingAndCritical " }
#    10 { "UnknownState" }
#    11 { "PartiallyCharged" }            
#    }
#}
