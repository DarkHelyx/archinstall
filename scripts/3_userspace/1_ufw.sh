#!/bin/bash
printf "\nThis will install ufw and start/enable ufw.service at boot. Would you like to continue (Y/N): "
read USER_CONSENT

if [[ "${USER_CONSENT,,}" = "y" ]]; then
    pacman -Syu ufw &&
        systemctl start ufw &&
            systemctl enable ufw &&
            ufw default deny &&
            ufw limit ssh &&
            ufw enable &&
            sleep 1 &&
            ufw status

    printf "\nufw setup successfully!\n"
else
    printf "\nufw setup aborted.\n"
fi
exit

