#!/bin/bash
DISCONNECTED="disconnected"
CONNECTED="connected"
HLS_OFF="#HandleLidSwitch=ignore"
HLS_ON="HandleLidSwitch=ignore"
FILENAME="/etc/systemd/logind.conf"

status1=$(xrandr | grep "HDMI-1")
first_iteration=true

modify_file() {
    sed -i "s/$2/$1/" FILENAME
}

while true; do
    sleep 5
    status2=$(xrandr | grep "HDMI-1")

    if [[ $status1 == $status2 ]] || [[ $first_iteration ]]
    then
        status1=$status2
        first_iteration=false

        if [[ $status2 == *$DISCONNECTED* ]]
        then
            modify_file $HLS_OFF $HLS_ON
        else
            modify_file $HLS_ON $HLS_OFF
        fi
    fi
done