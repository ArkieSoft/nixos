#!/bin/sh

nwg-panel & disown nwg-panel
thunar --daemon & disown thunar
xrandr --output DP-2 --primary
#LIBVIRT_DEFAULT_URI=qemu:///system virsh net-start default
sleep 15
nextcloud & disown nextcloud
#telegram-desktop -startintray & disown telegram-desktop
#signal-desktop --start-in-tray & disown signal-desktop
#LIBVIRT_DEFAULT_URI=qemu:///system virsh start WindowsVM
