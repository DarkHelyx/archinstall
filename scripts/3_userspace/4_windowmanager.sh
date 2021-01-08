#!/bin/bash
printf "\nThis will install i3-gaps window manager. Would you like to continue (Y/N): "
read USER_CONSENT

if [[ "${USER_CONSENT,,}" = "y" ]]; then
    pacman -Syu i3-gaps
    printf "\ni3-gaps setup successfully!\n"
else
    printf "\ni3-gaps setup aborted.\n"
fi
exit

