#!/bin/bash
printf "\nThis will install xorg, AMD drivers and gtk3. Would you like to continue (Y/N): "
read USER_CONSENT

if [[ "${USER_CONSENT,,}" = "y" ]]; then
    pacman -Syu xorg-server mesa xf86-video-amdgpu gtk3
    printf "\nxorg setup successfully!\n"
else
    printf "\nxorg setup aborted.\n"
fi
exit

