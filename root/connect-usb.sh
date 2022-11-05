#!/bin/bash

# Clear Old Tours
sudo rm /var/www/html/nginx/toursite/*

# Definitions
currUSB=/home/emurr/current-usb.txt
preUSB=/home/emurr/previous-usb.txt
diffUSB=/home/emurr/diff-usb.txt
output=/dev/tty1

# Blink to Begin
echo timer > /sys/class/leds/led0/trigger

# await race condition...
echo "sleep 10s for race condition" > $output
echo "look up more about polling... may need to implement instead of sleep" > $output
for i in {1..10}
do
  echo -n "$i " > $output
  sleep 1
done

# get usb directories (regex) & diff (comm -13) with what was last in the usb
ls /dev/sd* > "$currUSB"
comm -13 "$preUSB" "$currUSB" > "$diffUSB"

# take the diff which should now be the curr dir of the USB
directory=$(sed -n '2{p;q}' "$diffUSB")

# mount the curr dir of the USB
sudo mount "$directory" /media/usb

# copy the mounted USB files to our NGINX dir
sudo cp -r /media/usb/toursite /var/www/html/nginx/

# dedicated finish
echo default-on > /sys/class/leds/led0/trigger
