# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-wapd/vdrplugin-wapd-0.0.6c.ebuild,v 1.1 2004/08/11 18:41:45 austriancoder Exp $

IUSE=""

inherit vdrplugin

DESCRIPTION="Video Disk Recorder Wap PlugIn"
HOMEPAGE="http://vdr.heiligenmann.de/vdr/plugins/"
SRC_URI="http://vdr.heiligenmann.de/download/vdr-${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.6"

src_install() {
	vdrplugin_src_install

	insinto /etc/vdr/plugins
	doins ${FILESDIR}/waphosts
	doins ${FILESDIR}/wapaccess
}
