# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-pilot/vdrplugin-pilot-0.0.6-r2.ebuild,v 1.2 2004/08/11 13:47:19 austriancoder Exp $

IUSE=""
inherit vdrplugin eutils

DESCRIPTION="Video Disk Recorder Pilot PlugIn"
HOMEPAGE="http://famillejacques.free.fr/vdr/"
SRC_URI="http://famillejacques.free.fr/vdr/pilot/vdr-${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.0"

src_unpack() {
	vdrplugin_src_unpack
	if has_version ">=media-video/vdr-1.3.7" ;
	then
		epatch ${FILESDIR}/${VDRPLUGIN}-${PV}-1.3.7.diff
	fi
}
