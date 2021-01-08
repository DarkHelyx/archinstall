#!/bin/bash
printf "\nThis will install rofi window switch and app launcher. Would you like to continue (Y/N): "
read USER_CONSENT

if [[ "${USER_CONSENT,,}" = "y" ]]; then
    pacman -Syu rofi
    printf "\npcmanfm setup successfully!\n"
else
    printf "\npcmanfm setup aborted.\n"
fi
exit

