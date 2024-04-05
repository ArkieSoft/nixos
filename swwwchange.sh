#!/bin/sh

DIR=/etc/nixos/wallpapers
PICS=($(ls ${DIR}))


if [[ $(pidof swaybg) ]]; then
  pkill swaybg
fi

swww query || swww-daemon

INTERVAL=300
#change-wallpaper using swww
while true; do

  RANDOMPICS=${PICS[ $RANDOM % ${#PICS[@]} ]}

  swww img ${DIR}/${RANDOMPICS} --transition-fps 60 --transition-type any --transition-duration 5
  sleep $INTERVAL
done
