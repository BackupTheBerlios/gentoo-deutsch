# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/x11-plugins/gkrellm-plugins/gkrellm-plugins-2.0.ebuild,v 1.1 2003/10/03 12:42:27 longint Exp $

IUSE="gnome"

S=${WORKDIR}/${P//gkrellm-}
DESCRIPTION="emerge this package to install all of the plugins for gkrellm2"
HOMEPAGE="http://www.gkrellm.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND="=app-admin/gkrellm-2*
		x11-plugins/gkrellm-hddtemp
		x11-plugins/gkrellm-leds
		x11-plugins/gkrellm-mailwatch
		x11-plugins/gkrellm-newsticker
		x11-plugins/gkrellm-plugins
		x11-plugins/gkrellm-radio
		x11-plugins/gkrellm-reminder
		x11-plugins/gkrellm-seti
		x11-plugins/gkrellm-vaiobright
		x11-plugins/gkrellm-volume
		x11-plugins/gkrellmitime
		x11-plugins/gkrellmlaunch
		x11-plugins/gkrellmms
		x11-plugins/gkrellmoon
		x11-plugins/gkrellmwireless
		x11-plugins/gkrellshoot
		x11-plugins/gkrellweather
		gift? ( x11-plugins/gkrellm-giFT )
		"

# These plugins are for gkrellm-1* (at least the version currently in portage):
#		x11-plugins/gkrellm-bgchanger
#		x11-plugins/gkrellmwho
#		x11-plugins/gkrellm-bfm
#		x11-plugins/gkrellm-console
#		x11-plugins/gkrellm-alltraxclock
#		gnome? ( x11-plugins/gkrellm-gnome )
#		x11-plugins/gkrellmouse
#		x11-plugins/gkrellm-sensors
#		x11-plugins/gkrellm-logwatch
