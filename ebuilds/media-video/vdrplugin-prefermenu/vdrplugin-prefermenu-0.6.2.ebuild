# Copyright 2003 Henning Ryll <henning.ryll@web.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-prefermenu/vdrplugin-prefermenu-0.6.2.ebuild,v 1.2 2004/08/11 13:44:00 austriancoder Exp $

IUSE=""

inherit vdrplugin

DESCRIPTION="Video Disk Recorder Prefermenu Plugin"
HOMEPAGE="http://www.olivierjacques.com/vdr/prefermenu/"
SRC_URI="http://www.azimi.de/vdr/vdr-${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.9"

src_install() {
	vdrplugin_src_install
	touch ${D}/etc/vdr/plugins/prefermenu.conf
	fowners vdr ${D}/etc/vdr/plugins/prefermenu.conf
}
