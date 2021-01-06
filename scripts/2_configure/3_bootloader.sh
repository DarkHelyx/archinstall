#!/bin/bash
printf "\nThis script will install systemd-boot to /boot. Would you like to continue (Y/N)?:"
read USER_CONSENT

if [ "${USER_CONSENT,,}" = "y" ]; then
    printf "\nNow installing bootloader to /boot\n" &&
        bootctl --path=/boot/ install &&
        echo "default arch" >> /boot/loader/loader.conf &&
        echo "timeout 3" >> /boot/loader/loader.conf &&
        echo "console-mode max" >> /boot/loader/loader.conf &&
        echo "editor 0" >> /boot/loader/loader.conf &&
        cp $PWD/arch.conf /boot/loader/entries/arch.conf

    printf "/boot/loader/loader.conf updated. Please update /boot/loader/entries/arch.conf.with UUID"
    exit
else
    echo "Installation of bootloader aborted."
    exit
fi
