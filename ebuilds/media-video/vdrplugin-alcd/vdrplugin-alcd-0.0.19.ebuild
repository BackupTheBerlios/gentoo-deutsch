# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-alcd/vdrplugin-alcd-0.0.19.ebuild,v 1.2 2004/08/11 20:51:09 austriancoder Exp $

IUSE=""
inherit vdrplugin

S=${WORKDIR}/${VDRPLUGIN}
DESCRIPTION="Video Disk Recorder Activy 300 LCD PlugIn"
HOMEPAGE="http://home.primusnetz.de/mgeisler/alcd/"
SRC_URI="http://home.primusnetz.de/mgeisler/alcd/${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.0"

src_unpack() {
	vdrplugin_src_unpack
	cd ${S}
	sed -i "s/ifdef NEWSTRUCT/#ifdef NEWSTRUCT/" Makefile
	sed -i "s/DEFINES += -NEWSTRUCT/DEFINES += -D_GNU_SOURCE/" Makefile
	sed -i "s/else/#else/" Makefile
	sed -i "23s/endif/#endif/" Makefile
}

