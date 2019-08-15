#!/bin/bash
DATE=`date +%d-%b-%Y`

/bin/dd bs=4M if=/dev/mmcblk0 iflag=direct of=/media/usb/jgpiholebackup/jgpihole_$DATE.img
if [ $? != 0 ]; then
	echo "Image creation failed.	$(date)">> /var/log/doimage.log
			exit 1
fi

cd /media/usb/jgpiholebackup/
/sbin/losetup -P /dev/loop0 jgpihole_$DATE.img && /sbin/e2fsck -f -y /dev/loop0p2 && /sbin/losetup -D
if [ $? != 0 ]; then
	echo "Filesystem check/repair failed.	$(date)">> /var/log/doimage.log
			exit 1
fi

/media/usb/jgpiholebackup/pishrink.sh -s /media/usb/jgpiholebackup/jgpihole_$DATE.img
if [ $? != 0 ]; then
	echo "Image shrink failed.	$(date)"
fi
	echo "Backup image created successfully.	$(date)">> /var/log/doimage.log
	cat /var/log/doimage.log | grep "$DATE"
	echo "-------------------------------------------------------"
	ls -laGh /media/usb/jgpiholebackup/
