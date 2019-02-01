#!/bin/bash
# This script is intended for usage in a corn job to periodically create an image of the sd card
# a long with logging upon successful image creation.
DATE=`date +%d-%b-%Y`

/bin/dd if=/dev/mmcblk0 iflag=direct of=/media/usb/jgpiholebackup/jgpihole_$DATE.img
if [ $? != 0 ]; then
	echo "Image creation failed.	$(date)">> /var/log/doimage.log
			exit 1
fi
	echo "Backup image created successfully.	$(date)">> /var/log/doimage.log
	cat /var/log/doimage.log | grep "$DATE"
	echo "-------------------------------------------------------"
	ls -laGh /media/usb/jgpiholebackup/
