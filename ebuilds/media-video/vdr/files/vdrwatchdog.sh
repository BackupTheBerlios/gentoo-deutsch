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
		/etc/init.d/vdr fullrestart 2>&1 >/dev/null
	fi
	unset RUN
done
