#!/usr/bin/env bash

WALLPAPER_DIR="/etc/nixos/wallpapers/"

INTERVAL=300
while true; do
  CURRENT_WALL=$(hyprctl hyprpaper listloaded)
  
  WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)
  
  hyprctl hyprpaper reload ,"$WALLPAPER"
  sleep $INTERVAL
done 

