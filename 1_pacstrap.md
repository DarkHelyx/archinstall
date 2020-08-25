# Rank Mirrors
```
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
curl -s "https://www.archlinux.org/mirrorlist/?country=AU&country=NZ&country=SG&country=TH&country=JP&country=PH&country=IN&country=KR&protocol=https&ip_version=4" | sed -e 's/^#Server/Server/' -e '/^#/d' > /etc/pacman.d/mirrorlist
```

# Pacstrap command
```
pacstrap root base base-devel linux linux-firmware efibootmgr grub-efi-x86_64 zsh vim neovim man-db man-pages texinfo networkmanager lvm2
```

# Install fstab
`genfstab -pU /mnt >> /mnt/etc/fstab`

Then add `tmpfs /tmp tmpfs defaults,noatime,mode=1777 0 0` to /mnt/etc/fstab.

# Chroot into the system
```
arch-chroot /mnt /bin/bash
ln -s /usr/share/zoneinfo/Australia/Sydney /etc/localtime
hwclock --systohc --utc
```

# Set the hostname
`echo elsewhere > /etc/hostname`

# Update Locale
```
echo LANG=en_US.UTF-8 >> /etc/locale.conf
echo LANGUAGE=en_US >> /etc/locale.conf
echo LC_ALL=C >> /etc/locale.conf
```

# Set new root password
`passwd`

# Configure mkinitcpio
Add 'ext4' to MODULES in /etc/mkinitcpio.conf
Set hooks to
HOOKS=(base udev autodetect keyboard keymap consolefont modconf block lvm2 encrypt filesystems fsck)

`mkinitcpio -p linux`

# Install grub
`grub-install`

In /etc/default/grub edit GRUB_CMDLINE_LINUX to "cryptdevice=/dev/nvme0n1p3:luks:allow-discards"
Then run
`grub-mkconfig -o /boot/grub/grub.cfg`

# Exit new system and wrap everything up
```
exit
umount -R /mnt
swapoff -a
reboot
```
