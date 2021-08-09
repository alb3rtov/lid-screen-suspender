# HDMI Screen Suspender
This script allows you to setup you laptop as a computer desktop closing the lid without suspend the PC while the HDMI cable is connected to a monitor and when the HDMI is unplugged, then close the lid will suspend the laptop.

## Requeriments
In the absence of testing on different Linux distributions, as far as I check, this script works in every Linux distributions. You just to be sure that the `logind.conf` is in `/etc/systemd/` directory.

Also make sure that the HDMI port used corresponds with the `HDMI-1`, or just modify the code changing it. You can also change the port instead of using HDMI in case you use a DisplayPort, DVI, VGA, etc. In order to check what ports are being used, use the `xrandr` command.

## Set up the script
In order to automate this tasks the are differents ways to run a script on boot, for example, using `crontab` is a good idea. But in some desktops of Debian/Ubuntu distros like XFCE, there is a tab in configuration menu for configure startup applications.

For automate with `crontab` just add this line to your crontab file

    @reboot sudo python3 /absolute-full-path-of-where-script-is/hdmi-screen-suspender.py &