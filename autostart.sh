#!/bin/sh

waybar & disown waybar
thunar --daemon & disown thunar
sleep 15
nextcloud & disown nextcloud
telegram-desktop -startintray & disown telegram-desktop
signal-desktop --start-in-tray & disown signal-desktop

