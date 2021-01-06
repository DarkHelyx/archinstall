#!/bin/bash
printf "\nThis script will install systemd-boot to /boot. Would you like to continue (Y/N)?:"
read USER_CONSENT

if [ "${USER_CONSENT,,}" = "y" ]; then
    printf "\nNow installing bootloader to /boot\n" &&
        bootctl --path=/boot/ install &&
        echo "default arch" >> /boot/loader/loader.conf &&
        echo "timeout 3" >> /boot/loader/loader.conf &&
        echo "console-mode max" >> /boot/loader/loader.conf &&
        echo "editor no" >> /boot/loader/loader.conf

    printf "/boot/loader/loader.conf updated. Please read https://gist.github.com/OdinsPlasmaRifle/e16700b83624ff44316f87d9cdbb5c94 and update /boot/loader/entries/arch.conf."
    exit
else
    echo "Installation of bootloader aborted."
    exit
fi
