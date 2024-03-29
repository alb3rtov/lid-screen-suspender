# Lid Screen Suspender
This script allows you to setup you laptop as a computer desktop closing the lid without suspend the PC while a video cable is connected to a external monitor/s. If video cable is unplugged, then close the lid will suspend the laptop. 

## Requeriments
### Linux
In the absence of testing on different Linux distributions, as far as I check, this script works in every Linux distributions. You just to be sure that the `logind.conf` is in `/etc/systemd/` directory. **Make sure that your logind.conf have HandleLidSwitch line like** `HandleLidSwitch=ignore` or `#HandleLidSwitch=ignore`, otherwise maybe the script will not work properly. More info about `logind.conf` file [here](https://www.freedesktop.org/software/systemd/man/logind.conf.html).

### Windows
The only requeriment for Windows OS is have a `Powershell` version `5.1` or higher. In order to know what is your current version use the command `Get-Host | Select-Object Version`.

## Working script
### Linux
This script use two basics of Linux. The command `xrandr` and the `logind.conf` located in `/etc/systemd/` directory. The command `xrandr` is used to check if any video port is connected to a external monitor or it is not. In order to manage the lid behavior, the `logind.conf` is modified, specifically the line of `HandleLidSwitch`. This script change this line to `ignore` option if video cable is connected and if is not connected comment the line with `#`.

### Windows
For Windows it is use the command `Get-WmiObject` and query the information about current monitors connected to the machine. To change the lid behaviour, it is used the `powercfg` and the default _GUID_ power plan, that is `381b4222-f694-41f0-9685-ff5bb260df2e 4f971e89-eebd-4455-a8de-9e59040e7347`, so you have to set your power plan to `Balanced`, otherwise you will have to change to your correspoding _GUID_.

## Setup the script for run on boot
### Linux
In order to automate this tasks there are differents ways to run a script on boot, for example, using `crontab` is a good idea. But in some desktops of Debian/Ubuntu distros like XFCE, there is a tab in configuration menu for configure startup applications.

For automate with `crontab` just add this line to your crontab file:

    @reboot sudo /absolute-full-path-of-where-script-is/linux-screen-suspender.sh &

### Windows
You can use the **Windows Task Scheduler** to set up the script and run it on every boot. You just create a new basic task, give it a name and description, set the _trigger_ as 'When I log on' and set the _action_ as **Start a program** and add next command:

    Powershell.exe -windowstyle hidden "\absolute-full-path-of-where-script-is\windows-screen-suspender.ps1"

In addition, maybe you have to change some properties of the task, like set the OS to Windows 10, and check the box of **Run with highest privileges**. Now on every boot a `powershell` window maybe will pop up for few seconds and then the script will be running on background.

You can run this in a powershell terminal with high privileges to configure automatically the task:
```powershell
$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument "-windowstyle hidden \absolute-full-path-of-where-script-is\windows-screen-suspender.ps1"
$trigger = New-ScheduledTaskTrigger -AtLogOn
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Lid Screen Suspender" -Description "Lid Screen Suspender" -Settings $settings -RunLevel Highest 
```

_If not works, maybe you have to connect your laptop to the power supply_.
