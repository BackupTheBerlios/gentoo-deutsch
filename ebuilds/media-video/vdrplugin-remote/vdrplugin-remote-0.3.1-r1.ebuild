# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-remote/vdrplugin-remote-0.3.1-r1.ebuild,v 1.2 2004/08/11 18:57:28 austriancoder Exp $

IUSE=""

# inherit from vdrplugin
# include functions from eutils
inherit vdrplugin eutils

DESCRIPTION="Video Disk Recorder ${VDRPLUGIN} plugin"
HOMEPAGE="http://endriss.escape.bei.t-online.de/vdr/"
SRC_URI="
	http://endriss.escape.bei.t-online.de/vdr/vdr-${VDRPLUGIN}-${PV}.tgz
	http://michael.justfor-e.net/gentoo/vdr/vdr-remote-0.3.1-0.3.1a.diff.gz
"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.3.6"

src_unpack() {
	# extend inherited version
	vdrplugin_src_unpack

	cd ${S}
	epatch ../vdr-remote-0.3.1-0.3.1a.diff
}