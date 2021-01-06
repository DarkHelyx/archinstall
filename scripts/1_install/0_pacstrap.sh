#!/bin/bash
printf "\nNow installing base Arch system. Would you like to continue (Y/N)?:\n"
read USER_CONSENT
if [ "${USER_CONSENT,,}" = "y" ]; then
    pacstrap /mnt base base-devel vim efibootmgr linux linux-firmware lvm2 mkinitcpio networkmanager amd-ucode git efitools wget python
fi
