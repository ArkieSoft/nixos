#!/usr/bin/env bash

sleep 45
#LIBVIRT_DEFAULT_URI=qemu:///system virsh start WindowsVM
#remmina -c ~/.local/share/remmina/group_rdp_windowsvm_192-168-122-149.remmina --enable-fullscreen
moonlight stream WindowsVM Desktop
