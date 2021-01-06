#!/bin/bash
echo "This script should be run within chroot. Would you like to continue (Y/N)?:"
read USER_CONSENT

if [ "${USER_CONSENT,,}" = "y" ]; then
    printf "\nNow setting up system locale!\n" &&
        ln -sf /usr/share/zoneinfo/Australia/Sydney /etc/localtime &&
        hwclock --systohc &&
        sed -i "s/^#en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen &&
        sed -i "s/^#en_US ISO/en_US ISO/" /etc/locale.gen &&
        locale-gen &&
        locale > /etc/locale.conf

    printf "\nLocale Successfully Set!\n"
    exit
else
    "Locale setup aborted."
    exit
fi
