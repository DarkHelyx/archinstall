#!/bin/bash
echo "Please provide device path of EFI partition (e.g. /dev/nvme0n1p1)"
read PART_EFI
echo "Please provide device path of LVM partition (e.g. /dev/nvme0n1p2)"
read PART_LVM

if [[ "$PART_EFI" = "" ]]; then
    PART_EFI="/dev/nvme0n1p1"
fi
if [[ "$PART_LVM" = "" ]]; then
    PART_LVM="/dev/nvme0n1p2"
fi

printf "This script will format the following partitions:\n\tEFI: $PART_EFI\n\tLVM: $PART_LVM\n\n"
printf "This will destroy existing partition data. Would you like to continue (Y/N):"
read USER_CONSENT

if [ "${USER_CONSENT,,}" = "y" ]; then
    echo "Now formatting partitions!"
    # LVM Partition First
    printf "\nSetting up LVM on LUKS Partition!\n"
    cryptsetup -c aes-xts-plain64 -y --use-random luksFormat $PART_LVM &&
    cryptsetup open $PART_LVM crypt0sys &&
    pvcreate /dev/mapper/crypt0sys &&
    vgcreate crypt0vg /dev/mapper/crypt0sys &&
    lvcreate -L 16G crypt0vg -n swap &&
    lvcreate -L 8G crypt0vg -n share &&
    lvcreate -l 100%FREE crypt0vg -n root &&

    printf "\nFormatting Partitions!\n" &&
    mkfs.vfat -F32 $PART_EFI &&
    mkfs.ext4 /dev/mapper/crypt0vg-root &&
    mkfs.ext4 /dev/mapper/crypt0vg-share &&
    mkswap /dev/mapper/crypt0vg-swap &&

    printf "\nPartitions Successfully Formatted!\n"
    exit
else
    echo "Partition formatting aborted."
    exit
fi
