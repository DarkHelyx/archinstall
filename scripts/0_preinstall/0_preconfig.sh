#!/bin/bash
echo "This script will set keyboard layout, console fonts and update the system clock."
printf "Please connect to the internet before running this script\nWould you like to continue (Y/N)?:"
read USER_CONSENT
if [ "${USER_CONSENT,,}" = "y" ]; then
    echo "Setting keyboard layout to US" &&
    loadkeys us &&
    echo "Setting consolefont to sun12x22" &&
    setfont sun12x22 &&
   
    echo "Updating system clock" &&
    timedatectl set-ntp true &&
    timedatectl status &&
    printf "\nPreconfigure setup complete!\n"
else
    echo "Preconfiguring Aborted."
    exit
fi
