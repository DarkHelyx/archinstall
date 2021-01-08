#!/bin/bash
printf "\nThis will install pcmanfm file manager. Would you like to continue (Y/N): "
read USER_CONSENT

if [[ "${USER_CONSENT,,}" = "y" ]]; then
    pacman -Syu pcmanfm-gtk3 gvfs
    printf "\npcmanfm setup successfully!\n"
else
    printf "\npcmanfm setup aborted.\n"
fi
exit

