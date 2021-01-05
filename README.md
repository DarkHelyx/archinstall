# Arch Install

## References

- [Installation Reference](https://nwildner.com/posts/2020-07-04-secure-your-boot-process/)

## Step 1: GPT Partitioning

| Partition # | Size | Partition Type | Partition Name |
| --- | --- | --- | --- |
| 1 | 16M | Special | FAT32 | defec7ed-d00d-1dea-0001-c0011dea5101 |
| 2 | 256M | EFI | FAT32 | EFI | defec7ed-d00d-1dea-0002-b0074b13babe |
| 3 | 48G | System | LVM LUKS | defec7ed-d00d-1dea-0003-736861726564 |
| 4 | All | LVM | LVM LUKS | defec7ed-d00d-1dea-0004-637279707430 |

### 1.1 - Create LVM Partitions
#### crypt0sys (48G)

```
cryptsetup -c aes-xts-plain64 -y --use-random luksFormat /dev/nvme0n1p3
cryptsetup open /dev/nvme0n1p3 crypt0sys
pvcreate /dev/mapper/crypt0sys
vgcreate sysvg /dev/mapper/crypt0sys
lvcreate -L 16G sysvg -n swap
lvcreate -L 100%FREE sysvg -n root
```

#### crypt0home
```
cryptsetup -c aes-xts-plain64 -y --use-random luksFormat /dev/nvme0n1p4
cryptsetup open /dev/nvme0n1p4 crypt0home
pvcreate /dev/mapper/crypt0home
vgcreate homevg /dev/mapper/crypt0home
lvcreate -L 8G homevg -n share
lvcreate -L 100%FREE homevg -n home
```

## Step 2: Formatting Volumes
### 2.1 - Plaintext Partitions

```
mkfs.vfat -F32 /dev/nvme0n1p1
mkfs.vfat -F32 /dev/nvme0n1p2
```

#### 2.2.2 - LVM Partitions

```
mkfs.ext4 /dev/mapper/sysvg-root
mkswap /dev/mapper/sysvg-swap
mkfs.ext4 /dev/mapper/homevg-home
mkfs.ext4 /dev/mapper/homevg-shared

```

## Step 3: Mount the new system

```
mount /dev/mapper/crypt0vol-root /mnt
mkdir /mnt/efi
mkdir /mnt/data
mkdir /mnt/home
mount /dev/nvme0n1p2 /mnt/efi
mount /dev/mapper/homevg-share /mnt/data
mount /dev/mapper/homevg-home /mnt/home
swapon /dev/mapper/sysvg-swap
```

## Step 4: Pacstrap Install

`pacstrap /mnt base base-devel vim efibootmgr linux linux-firmware lvm2 mkinitcpio networkmanager amd-ucode git efitools wget python`

## Step 5: Chroot

```
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
```
