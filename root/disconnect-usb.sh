#!/bin/bash

# get state of USB to compare to on reconnect
currUSB=$(ls /dev/sd*)
preUSB=/home/emurr/previous-usb.txt
echo "$currUSB" > "$preUSB"


# shitty unmount
comm -13 /home/emurr/previous-usb.txt /home/emurr/current-usb.txt > /home/emurr/diff-usb.txt
directory=$(sed -n '2{p;q}' /home/emurr/diff-usb.txt)

sudo umount "$directory"