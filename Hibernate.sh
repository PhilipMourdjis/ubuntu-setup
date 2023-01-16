# Set size of swapfile
sudo swapoff -a
sudo dd if=/dev/zero of=/swapfile bs=1M count=16000
sudo mkswap /swapfile
sudo chmod 0600 /swapfile
sudo swapon /swapfile

# Install dependencies:

sudo apt install pm-utils hibernate uswsusp

# Find your UUID and swap offset:
findmnt -no UUID -T /swapfile
sudo filefrag -v /swapfile

Edit /etc/default/grub and replace the string:

GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
with your UUID and offset:

GRUB_CMDLINE_LINUX_DEFAULT="quiet splash resume=UUID=371b1a95-d91b-49f8-aa4a-da51cbf780b2 resume_offset=23888916"
Update GRUB:

sudo update-grub
Test your hibernation:

sudo systemctl hibernate
Probably you should not change the size of your swap after enabling the hibernation (at least without changing the swap-offset in GRUB).

See wiki for more details.

EXTRA BONUS: If you want to hibernate when a laptop lid is closed (see this):

Disable any options in the settings that touch the laptop lid, set them to "do nothing".

Run:

sudo mkdir -p /etc/acpi/events/ && sudo nano /etc/acpi/events/laptop-lid
and paste:

event=button/lid.*
action=/etc/acpi/laptop-lid.sh
Run:

sudo touch /etc/acpi/laptop-lid.sh && sudo chmod +x /etc/acpi/laptop-lid.sh && sudo nano /etc/acpi/laptop-lid.sh
and paste:

#!/bin/bash

LOG_FILE='/var/log/laptop-lid.log'
touch $LOG_FILE && chmod 0666 $LOG_FILE

grep -q closed /proc/acpi/button/lid/LID/state
if [ $? = 0 ]
then
    # close action
    echo "$(date '+%Y.%m.%d %H:%M:%S.%3N'): closed" >> $LOG_FILE
    systemctl hibernate
else
    # open action
    echo "$(date '+%Y.%m.%d %H:%M:%S.%3N'): opened" >> $LOG_FILE
fi
Run:

sudo /etc/init.d/acpid restart