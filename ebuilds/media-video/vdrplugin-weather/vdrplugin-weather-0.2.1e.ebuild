# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-weather/vdrplugin-weather-0.2.1e.ebuild,v 1.5 2004/08/12 19:01:49 austriancoder Exp $

IUSE=""
inherit vdrplugin eutils

#S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder ${VDRPLUGIN} Plugin"
HOMEPAGE="http://moldaner.de"
SRC_URI="http://www.moldaner.de/vdr/download/vdr-${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.3.2
	>=dev-libs/mdsplib-0.11
	>=net-libs/ftplib-3.1-r1"

src_unpack() {
	vdrplugin_src_unpack

	if has_version ">=media-video/vdr-1.3.7" ;
	then
		einfo "Applying ${VDRPLUGIN}-${PV}-1.3.7 patch"
		cd ${S}
		epatch ${FILESDIR}/vdr-1.3.6-${VDRPLUGIN}-${PV}.diff
	fi
}
