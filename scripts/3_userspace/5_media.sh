#!/bin/bash
printf "\nThis will install ALSA utilities and Pulseaudio. Would you like to continue (Y/N): "
read USER_CONSENT

if [[ "${USER_CONSENT,,}" = "y" ]]; then
    pacman -Syu alsa-utils pulseaudio &&
        amixer sset Master unmute &&
        amixer sset Speaker unmute &&
        amixer sset Headphone unmute
    printf "\nurxvt and tmux setup successfully!\n"
else
    printf "\nurxvt and tmux setup aborted.\n"
fi
exit

