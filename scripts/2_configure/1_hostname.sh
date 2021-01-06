#!/bin/bash
echo "Please enter a hostname:"
read NEW_HOSTNAME

printf "\nThis script will setup the system hostname to $NEW_HOSTNAME. Would you like to continue (Y/N)?: "
read USER_CONSENT

if [ "${USER_CONSENT,,}" = "y" ]; then
    printf "\nNow setting up system hostname!\n" &&
        echo "$NEW_HOSTNAME" > /etc/hostname &&
        printf "127.0.0.1\tlocalhost\n" >> /etc/hosts &&
        printf "::1\tlocalhost\n" >> /etc/hosts &&
        printf "127.0.1.1\t$NEW_HOSTNAME.localdomain\t$NEW_HOSTNAME\n" >> /etc/hosts
    printf "\nHostname successfully updated!\n"
    exit
else
    echo "Hostname setup aborted."
    exit
fi
