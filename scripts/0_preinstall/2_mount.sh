#!/bin/bash
echo "Please provide device path of EFI partition (e.g. /dev/nvme0n1p1)"
read PART_EFI
if [[ "$PART_EFI" = "" ]]; then
    echo "EFI Partition Not Provided. Aborting."
    exit
fi
echo "Please provide device path of root volume (e.g. /dev/mapper/crypt0vg-root)"
read VOL_ROOT
if [[ "$VOL_ROOT" = "" ]]; then
    echo "Root Partition Not Provided. Aborting."
    exit
fi
echo "Please provide device path of share volume (e.g. /dev/mapper/crypt0vg-share)"
read VOL_SHARE
if [[ "$VOL_SHARE" = "" ]]; then
    echo "Share Partition Not Provided. Aborting."
    exit
fi
echo "Please provide device path of swap volume (e.g. /dev/mapper/crypt0vg-swap)"
read VOL_SWAP
if [[ "$VOL_SWAP" = "" ]]; then
    echo "Swap Partition Not Provided. Aborting."
    exit
fi

printf "\nThis script will mount the following volumes:\n\tEFI: $PART_EFI\n\tLVM: $VOL_ROOT\n\tSwap: $VOL_SWAP\n\tShare: $VOL_SHARE\n"
printf "Would you like to continue (Y/N):"
read USER_CONSENT

if [ "${USER_CONSENT,,}" = "y" ]; then
    printf "\nNow Mounting System Volumes!\n"
    mount $VOL_ROOT /mnt &&
    mkdir /mnt/boot &&
    mkdir /mnt/data &&
    mount $PART_EFI /mnt/boot &&
    mount $VOL_SHARE /mnt/data &&
    swapon $VOL_SWAP &&

    printf "\nVolumes Successfully Mounted!\n"
    exit
else
    echo "Mounting volumes aborted."
    exit
fi


