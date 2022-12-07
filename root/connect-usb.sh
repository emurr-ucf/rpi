#!/bin/bash

# Clear Old Tours
# sudo rm -r /var/www/html/nginx/toursite/*

# Definitions
currUSB=/home/emurr/current-usb.txt
preUSB=/home/emurr/previous-usb.txt
diffUSB=/home/emurr/diff-usb.txt
output=/dev/tty2

# Blink to Begin
echo timer > /sys/class/leds/led0/trigger

# await race condition...
echo "sleep 10s for race condition" > $output
# echo "look up more about polling... may need to implement instead of sleep" > $output
for i in {1..10}
do
  echo -n "$i " > $output
  if [[ "$(ls -A /dev/sd*)" ]]; then
    break
  fi
  if [[ i -eq 9 ]]; then
    echo "no USB found" > $output
    echo mmc0 > /sys/class/leds/led0/trigger
    exit -1;
  fi
  sleep 1
done



# get usb directories (regex) & diff (comm -13) with what was last in the usb
ls /dev/sd* > "$currUSB"
comm -13 "$preUSB" "$currUSB" > "$diffUSB"

# stream editor (sed), suppress normal output (-n), print second line from the file ("$diffUSB"), then quit ('2{p;q}')
directory=$(sed -n '2{p;q}' "$diffUSB")

# mount the curr dir of the USB
sudo mount "$directory" /media/usb

# copy the mounted USB files to our NGINX dir
sudo rm -r /var/www/html/nginx/toursite/*
sudo cp -r /media/usb/toursite /var/www/html/nginx/

# dedicated finish
echo default-on > /sys/class/leds/led0/trigger
