# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-weather/vdrplugin-weather-0.2.1e.ebuild,v 1.3 2004/03/22 18:45:49 fow0ryl Exp $

IUSE=""
VDRPLUGIN="weather"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
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
	unpack ${A}
	
	if [ -n "`vdr -V | grep "1.3"`" ]
	then
		cd ${S}
		einfo "applying VDR 1.3.x patch"
		patch < ${FILESDIR}/vdr-1.3.6-${VDRPLUGIN}-${PV}.diff
	fi
}

src_compile() {
	sed -i "/cp.*LIBDIR/d" Makefile
	sed -i "s/^DVBDIR.*$/DVBDIR = \/usr\/include\/dvb/" Makefile
	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" Makefile
	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib\/vdr/" Makefile
	make all || die "compile problem"
}

src_install() {
	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PV}
	dodoc COPYING README HISTORY
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PV} libvdr-${VDRPLUGIN}.so
}

pkg_postinst() {
	einfo
	einfo "you need to add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to activate it."
	einfo
}
