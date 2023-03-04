#!/bin/bash

# Update package lists
echo "Updating package lists..."
apt update

# Upgrade installed packages
echo "Upgrading installed packages..."
UPGRADED_PACKAGES=$(apt upgrade -y | grep "upgraded," | cut -d' ' -f1)

if [ -z "$UPGRADED_PACKAGES" ]
then
    echo "No packages were upgraded."
else
    # Send e-mail notification
    echo "The following packages were upgraded: $UPGRADED_PACKAGES" | sendmail user@example.com

    # Check if the kernel was upgraded
    if dpkg -l | grep -q "linux-image-.*-generic"
    then
        REBOOT_REQUIRED=true
    fi
fi

# Clean package lists
echo "Cleaning package lists..."
apt-get clean

echo "Done!"

# Reboot if necessary
#if [ "$REBOOT_REQUIRED" = true ]
#then
#    echo "Rebooting system..."
#    reboot
fi
