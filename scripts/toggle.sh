#!/run/current-system/sw/bin/bash

if [[ $(pgrep hydro.sh) ]];then
  echo "hydro.sh found, closing"
  pkill hydro.sh
  dunstify -t 2000 "Hydro is off"
else
  echo "Starting hydro.sh"
  dunstify -t 2000 "Hydro is on"
  /etc/nixos/scripts/hydro.sh &
  exit
fi
