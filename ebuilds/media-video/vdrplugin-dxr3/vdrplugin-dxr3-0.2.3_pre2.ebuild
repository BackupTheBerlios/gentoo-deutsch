# Copyright 2004 Christian Gmeiner
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-dxr3/Attic/vdrplugin-dxr3-0.2.3_pre2.ebuild,v 1.3 2004/08/10 21:59:18 austriancoder Exp $

IUSE=""

inherit vdrplugin

DESCRIPTION="Video Disk Recorder - dxr3 plugin"
HOMEPAGE="http://dxr3plugin.sf.net"
SRC_URI="http://switch.dl.sourceforge.net/sourceforge/dxr3plugin/vdr-${VDRPLUGIN}-0.2.3-pre2.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="${DEPEND} 
	>=media-video/vdr-1.2.6
	=media-video/ffmpeg-0.4.8*
	"

src_unpack() {
	vdrplugin_src_unpack

	cd ${S}
	/bin/sed -i Makefile \
	  -e 's/^FFMDIR.*$/FFMDIR = \/usr\/include\/ffmpeg/'
}
