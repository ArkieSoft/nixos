#!/run/current-system/sw/bin/bash

while true; do
   A=$((900 + RANDOM % 900))
   play /etc/nixos/sounds/alert.mp3 &
   dunstify -u critical -t 5000 "Hey, Hydrate you retard!"
   sleep $A
done
