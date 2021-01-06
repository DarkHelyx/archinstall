# Arch Install

## References

- [Installation Reference](https://gist.github.com/OdinsPlasmaRifle/e16700b83624ff44316f87d9cdbb5c94)

## Step 1: GPT Partitioning

| Partition # | Size | Partition Type | Partition Name |
| --- | --- | --- | --- |
| 2 | 256M | EFI | FAT32 | EFI |
| 4 | All | LVM | LVM LUKS |

### 1.1 - Create LVM Partitions
#### crypt0sys (48G)

```
cryptsetup -c aes-xts-plain64 -y --use-random luksFormat /dev/nvme0n1p2
cryptsetup open /dev/nvme0n1p3 crypt0sys
pvcreate /dev/mapper/crypt0sys
vgcreate crypt0vg /dev/mapper/crypt0sys
lvcreate -L 16G crypt0vg -n swap
lvcreate -L 8G crypt0vg -n share
lvcreate -l 100%FREE crypt0vg -n root
```


## Step 2: Formatting Volumes
### 2.1 - Plaintext Partitions

```
mkfs.vfat -F32 /dev/nvme0n1p1
```

#### 2.2.2 - LVM Partitions

```
mkfs.ext4 /dev/mapper/crypt0vg-root
mkfs.ext4 /dev/mapper/crypt0vg-share
mkswap /dev/mapper/crypt0vg-swap
```

## Step 3: Mount the new system

```
mount /dev/mapper/crypt0vg-root /mnt
mkdir /mnt/boot
mkdir /mnt/data
mount /dev/nvme0n1p1 /mnt/boot
mount /dev/mapper/crypt0vg-share /mnt/data
swapon /dev/mapper/crypt0vg-swap
```

## Step 4: Pacstrap Install

`pacstrap /mnt base base-devel vim efibootmgr linux linux-firmware lvm2 mkinitcpio networkmanager amd-ucode git efitools wget python`

## Step 5: Chroot

```
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
```
