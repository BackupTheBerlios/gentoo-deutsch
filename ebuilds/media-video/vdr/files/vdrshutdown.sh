#!/bin/bash
#
# sample vdrshutdown script (needs nvram-wakeup)
#
if [ "$1" -ne "0" ]; then
	/usr/bin/nvram-wakeup -s$1 -l -C /etc/nvram-wakeup.conf
	/sbin/lilo -R PowerOff
	/sbin/reboot
else
	/usr/bin/nvram-wakeup -d
	/sbin/poweroff
fi
