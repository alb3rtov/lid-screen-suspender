# Video Port Screen Suspender
This script allows you to setup you laptop as a computer desktop closing the lid without suspend the PC while a video cable is connected to a external monitor. If video cable is unplugged, then close the lid will suspend the laptop. 

## Requeriments
### Linux
In the absence of testing on different Linux distributions, as far as I check, this script works in every Linux distributions. You just to be sure that the `logind.conf` is in `/etc/systemd/` directory. In order to check what ports are being used, use the `xrandr` command. More info about `logind.conf` file [here](https://www.freedesktop.org/software/systemd/man/logind.conf.html).

### Windows
The only requeriment for Windows OS is have a `Powershell` version `5.1` or higher. In order to know what is your current version use the command `Get-Host | Select-Object Version`.

## Working script
### Linux
This script use two basics of Linux. The command `xrandr` and the `logind.conf` located in `/etc/systemd/` directory. The command `xrandr` is used to check if any video port is connected to a external monitor or it is not. In order two manage the lid behavior, the `logind.conf` is modified, specifically the line of `HandleLidSwitch`. This script change this line to `ignore` option if video cable is connected and if is not connected comment the line with a `#`.

### Windows
For Windows it is use the command `Get-WmiObject` and query the information about current monitors connected to the machine. To change the lid behaviour, it is used the `powercfg` and the default _GUID_ power plan, that is `381b4222-f694-41f0-9685-ff5bb260df2e 4f971e89-eebd-4455-a8de-9e59040e7347`.

## Setup the script for run on boot
### Linux
In order to automate this tasks there are differents ways to run a script on boot, for example, using `crontab` is a good idea. But in some desktops of Debian/Ubuntu distros like XFCE, there is a tab in configuration menu for configure startup applications.

For automate with `crontab` just add this line to your crontab file:

    @reboot sudo /absolute-full-path-of-where-script-is/hdmi-screen-suspender.sh &

### Windows
You can use the **Windows Task Scheduler** to set up the script and run it on every boot. But an easy way to do it, is just grab the [windows-screen-suspender.ps1]() and then move it into the directory `%APPDATA%\Microsoft\Windows\Start Menu\Startup`  
