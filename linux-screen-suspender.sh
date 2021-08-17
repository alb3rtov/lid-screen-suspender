#!/bin/bash
HLS_OFF="#HandleLidSwitch=ignore"
HLS_ON="HandleLidSwitch=ignore"
FILENAME="/etc/systemd/logind.conf"
COMMAND="xrandr | grep -w 'connected' | wc -l"

status1=$(eval "$COMMAND")

modify_file() {
    sudo sed -i "s/$2/$1/" $FILENAME
}

while true; do
    sleep 5
    status2=$(eval "$COMMAND")

    if [[ $status1 != $status2 ]]
    then
        status1=$status2

        if [[ $status2 > 1 ]]
        then
            modify_file $HLS_ON $HLS_OFF
        else
            modify_file $HLS_OFF $HLS_ON
        fi
    fi
done