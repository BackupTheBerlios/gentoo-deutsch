#!/bin/bash
#
# sample vdrshutdown script (needs nvram-wakeup)
#

if [ "$1" -ne "0" ]; then
	/usr/bin/nvram-wakeup -s$1 -l -C /etc/nvram-wakeup.conf
	lilo -R PowerOff
	reboot

else
	/usr/bin/nvram-wakeup -d
	poweroff
fi
