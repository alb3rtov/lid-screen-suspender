# HDMI Screen Suspender
This script allows you to setup you laptop as a computer desktop closing the lid without suspend the PC while the HDMI cable is connected to a external monitor. If the HDMI cable is unplugged, then close the lid will suspend the laptop. 

## Requeriments
In the absence of testing on different Linux distributions, as far as I check, this script works in every Linux distributions. You just to be sure that the `logind.conf` is in `/etc/systemd/` directory.

Also make sure that the HDMI port used corresponds with the `HDMI-1`, or just modify the code changing it. You can also change the port instead of using HDMI in case you use a DisplayPort, DVI, VGA, etc. In order to check what ports are being used, use the `xrandr` command.

## Working script
This script use two basics of Linux. The command `xrandr` and the `logind.conf` located in `/etc/systemd/` directory. The command `xrandr` is used to check if HDMI port is connected to a external monitor or is not. In order two manage the lid behavior the `logid.conf` is modified, specifically the line of `HandleLidSwitch`. This script change this line to `ignore` option if HDMI is connected and if is not connected comment the line with a `#`.


## Set up the script
In order to automate this tasks there are differents ways to run a script on boot, for example, using `crontab` is a good idea. But in some desktops of Debian/Ubuntu distros like XFCE, there is a tab in configuration menu for configure startup applications. You can use the `python` script or the `bash` script. I highly recommend `bash` script, I just do the `python` script for my laziness to learn `bash`. 

For automate with `crontab` just add this line to your crontab file:

    @reboot sudo /absolute-full-path-of-where-script-is/hdmi-screen-suspender.sh &

or

    @reboot sudo python3 /absolute-full-path-of-where-script-is/hdmi-screen-suspender.py &