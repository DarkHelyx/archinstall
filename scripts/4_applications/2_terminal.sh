#!/bin/bash
printf "\nThis will install urxvt terminal emulator, tmux terminal multiplexer and zsh. Would you like to continue (Y/N): "
read USER_CONSENT

if [[ "${USER_CONSENT,,}" = "y" ]]; then
    pacman -Syu rxvt-unicode tmux zsh zsh-completions
    printf "\nurxvt and tmux setup successfully!\n"
else
    printf "\nurxvt and tmux setup aborted.\n"
fi
exit

