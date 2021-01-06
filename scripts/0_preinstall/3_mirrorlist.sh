#!/bin/bash
if [[ -e /etc/pacman.d/mirrorlist ]]; then
    echo "/etc/pacman.d/mirrorlist exists. Renaming to mirrorlist.old"
    mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.old
fi
curl -s "https://archlinux.org/mirrorlist/?country=AU&protocol=https&ip_version=4&country=NZ&country=SG&country=JP&country=KR&country=TH" | sed -e 's/^#Server/Server/' -e '/^#/d' > /etc/pacman.d/mirrorlist
echo "Mirrorlist downloaded!"
