#!/bin/bash
printf "\nThis will install neovim and Python provider python-pynvim. Would you like to continue (Y/N): "
read USER_CONSENT

if [[ "${USER_CONSENT,,}" = "y" ]]; then
    pacman -Syu neovim python-pynvim
    printf "\ni3-gaps setup successfully!\n"
else
    printf "\ni3-gaps setup aborted.\n"
fi
exit

