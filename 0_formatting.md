# Partitioning the disk
fdisk # Create EFI partition of 256M (ef00) 
Create boot partition of 512M (8300)
Create system partition followed by Linux Partition for the rest.

# Create and Format EFI and Boot Partition
```
mkfs.vfat -F32 /dev/nvme0n1p1
mkfs.ext2 /dev/nvme0n1p2
```

# Format LVM on Luks Root Partition
```
cryptsetup -c aes-xts-plain64 -y --use-random luksFormat /dev/nvme0n1p3
cryptsetup open /dev/nvme0n1p3 crypt0
pvcreate /dev/mapper/crypt0
vgcreate sysvol0 /dev/mapper/crypt0
lvcreate -L 1G sysvol0 -n swap
lvcreate -L 100%FREE sysvol0 -n root
```

# Create volumes on encrypted partition
```
mkfs.ext4 /dev/mapper/sysvol0-root
mkswap /dev/mapper/sysvol0-swap
```

# Mount the new system
```
mount /dev/mapper/sysvol0-root /mnt
swapon /dev/mapper/sysvol0-swap
mkdir /mnt/boot
mount /dev/nvme0n1p2 /mnt/boot
mkdir /mnt/boot/efi
mount /dev/nvme0n1p1 /mnt/boot/efi
```

# Next Steps
Follow pacstrap

