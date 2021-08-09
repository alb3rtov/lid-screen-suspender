#!/usr/bin/python
import os
import time

DISCONNECTED = "disconnected"
CONNECTED = "connected"
HLS_OFF = "#HandleLidSwitch=ignore\n"
HLS_ON = "HandleLidSwitch=ignore\n"
FILENAME = "/etc/systemd/logind.conf"
COMMAND = "xrandr | grep \"HDMI-1\""

xr1 = os.popen(COMMAND)
status1 = xr1.read()
first_iteration = True

def get_line():
    """ Get number line of HandleLidSwitch """
    with open(FILENAME, "r") as file:
        data = file.readlines()

    cnt = 0

    for line in data:
        if "HandleLidSwitch=" in line:
            break
        cnt += 1

    return cnt

def modify_file(status, num_line):
    """ Edit logind.conf file """
    with open(FILENAME, "r") as file:
        data = file.readlines()
    
    if status == DISCONNECTED:
        data[num_line] = HLS_OFF
    elif status == CONNECTED:
        data[num_line] = HLS_ON

    with open(FILENAME, "w") as file:
        file.writelines(data)

    file.close()
    # Restart logind service
    os.system("sudo systemctl restart systemd-logind.service")

# Main loop
while True:
    num_line = get_line()
    time.sleep(5)
    xr2 = os.popen(COMMAND)
    status2 = xr2.read()

    if (status1 != status2 or first_iteration):
        status1 = status2
        first_iteration = False

        if DISCONNECTED in status2: 
            modify_file(DISCONNECTED, num_line) 
        else:
            modify_file(CONNECTED, num_line)