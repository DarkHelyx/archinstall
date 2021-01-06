#!/bin/bash
printf "Updating mkinitcpio with LVM hooks. Would you like to continue (Y/N)?: "
read USER_CONSENT

if [ "${USER_CONSENT,,}" = "y" ]; then
    printf "\nUpdating mkinitcpio Hooks and Regenerating!\n" &&
        sed -i 's/^HOOKS=.*$/HOOKS=(base udev autodetect modconf block keyboard encrypt lvm2 filesystems fsck)/' /etc/mkinitcpio.conf &&
        mkinitcpio -p linux
    printf "\n/etc/mkinitcpio.conf updated and initramfs regenerated successfully!\n"
    exit
else
    echo "Initramfs Regeneration Aborted."
    exit
fi
