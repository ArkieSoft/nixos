#!/run/current-system/sw/bin/bash

if [[ $# -lt 1 ]] || [[ ! -d $1   ]]; then
	echo "Usage:
	$0 /etc/nixos/wallpapers"
	exit 1
fi

sleep 3

if [[ $(pidof swww-daemon) ]];then
  echo "swww-daemon found, restarting process"
  pkill swww-daemon
  sleep 3
  swww-daemon &
else
  echo "swww-daemon not found, launching swww-daemon"
  swww-daemon &
fi

# Edit below to control the images transition
export SWWW_TRANSITION_FPS=120
export SWWW_TRANSITION_STEP=150
export SWWW_TRANSITION_DURATION=10

# This controls (in seconds) when to switch to the next image
INTERVAL=300

while true; do
	find "$1" -type f \
		| while read -r img; do
			echo "$((RANDOM % 1000)):$img"
		done \
		| sort -n | cut -d':' -f2- \
		| while read -r img; do
			swww img "$img" --transition-type any
			sleep $INTERVAL
		done
done
