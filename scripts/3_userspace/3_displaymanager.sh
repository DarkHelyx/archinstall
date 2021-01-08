#!/bin/bash
printf "\nThis will install LXDM. Would you like to continue (Y/N): "
read USER_CONSENT

if [[ "${USER_CONSENT,,}" = "y" ]]; then
    pacman -Syu lxdm-gtk3
    printf "\nxorg setup successfully!\n"
else
    printf "\nxorg setup aborted.\n"
fi
exit

