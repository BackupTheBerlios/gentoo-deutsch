# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-osdpip/vdrplugin-osdpip-0.0.6.ebuild,v 1.3 2004/08/11 13:26:16 austriancoder Exp $

IUSE=""
inherit vdrplugin

DESCRIPTION="Video Disk Recorder OSD-PIP PlugIn"
HOMEPAGE="http://www.magoa.net/linux"
SRC_URI="http://www.magoa.net/linux/files/vdr-${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.7
	>=media-libs/libmpeg2-0.4.0
	=media-video/ffmpeg-0.4.8*
	"

src_unpack() {
	vdrplugin_src_unpack

	cd ${S}
	/bin/sed -i Makefile \
	  -e 's/^FFMDIR.*$/FFMDIR = \/usr\/include\/ffmpeg/'
}

