$objWMi1 = get-wmiobject -namespace root\WMI -computername localhost -Query "Select * from WmiMonitorConnectionParams"

while($true) {
    Start-Sleep -s 5
    $objWMi2 = get-wmiobject -namespace root\WMI -computername localhost -Query "Select * from WmiMonitorConnectionParams"

    if ($objWMi1.Count -ne $objWMi2.Count) {
        $objWMi1 = $objWMi2
        
        if ($objWMi2.Count -lt 2) { # Without external monitors
            powercfg -setacvalueindex 381b4222-f694-41f0-9685-ff5bb260df2e 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 1
            powercfg -setdcvalueindex 381b4222-f694-41f0-9685-ff5bb260df2e 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 1
        } else { # With external monitors
            powercfg -setacvalueindex 381b4222-f694-41f0-9685-ff5bb260df2e 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0
            powercfg -setdcvalueindex 381b4222-f694-41f0-9685-ff5bb260df2e 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0
        }
    }
}