#!/bin/bash

DISCONNECTED="disconnected"
CONNECTED="connected"
HLS_OFF="#HandleLidSwitch=ignore\n"
HLS_ON="HandleLidSwitch=ignore\n"
FILENAME="/etc/systemd/logind.conf"

status1=$(xrandr | grep "HDMI-1")
first_iteration=true

get_line() {
    n=0
    while read line; do
        if [[ $line == *"HandleLidSwitch="* ]]; then
            break
        fi
        n=$((n+1))

    done < $FILENAME

    return $n
}

modify_file() {

}

#while true; do
    get_line
    num_line=$(echo $?)
    #echo $num_line
    sleep 5

    status2=$(xrandr | grep "HDMI-1")

    if [[ $status1 -eq $status2 ]] || [[ $first_iteration ]] then
        status1=$status2
        first_iteration=false

        if [[ $status2 == *$DISCONNECTED* ]] then
            modify_file $DISCONNECTED $num_line
        else
            modify_file $CONNECTED $num_line
        fi
    fi

#done