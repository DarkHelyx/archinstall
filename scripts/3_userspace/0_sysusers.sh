#!/bin/bash
echo "Please provide the name of the system user to be created: "
read NEW_USER

if [[ "$NEW_USER" = "" ]]; then
    echo "No name provided. Aborting."
    exit
fi

printf "\nThis will install sudo, create a new superuser named $NEW_USER and add them to the wheel group. Would you like to continue (Y/N): "
read USER_CONSENT

if [[ "${USER_CONSENT,,}" = "y" ]]; then
    sudo pacman -Syu sudo &&
        useradd -m -U -G wheel -s /bin/bash $NEW_USER

    printf "\nUser $NEW_USER setup successfully!\n"
else
    printf "\nUser setup aborted.\n"
fi
exit

