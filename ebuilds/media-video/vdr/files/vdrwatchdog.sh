#!/bin/bash
#
# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the GPL
#
# watchdog script to restart vdr after failure
# to stop watchdog temporarily touch /tmp/nowatchdog
#
#
while sleep 8; do

	[ -f /tmp/nowatchdog ] && continue

	pidof /usr/bin/vdr > /dev/null && RUN=1

	if [ -z $RUN ]; then
		 logger -i -t vdrwatchdog -p local0.info "initializing full VDR restart"
		/etc/init.d/vdr stop 2>&1 >/dev/null
		/etc/init.d/vdr zap 2>&1 >/dev/null
		/etc/init.d/dvb stop 2>&1 >/dev/null
		sleep 2
		/etc/init.d/dvb start 2>&1 >/dev/null
		/etc/init.d/vdr start 2>&1 >/dev/null
		fi
	unset RUN
done
