# Copyright 2003 Gentoo Technologies Inc
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-timeline/vdrplugin-timeline-0.8.1.ebuild,v 1.2 2004/03/22 18:43:59 fow0ryl Exp $

IUSE=""
VDRPLUGIN="timeline"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder Timeline PlugIn"
HOMEPAGE="http://www.js-home.org/vdr/timeline/"
SRC_URI="http://www.js-home.org/vdr/timeline/vdr-${VDRPLUGIN}-${PV}.tar.gz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.6"

src_unpack() {
	unpack ${A}
	
	if [ -n "`vdr -V | grep "1.3"`" ]
	then
		einfo "applying VDR 1.3.x patch"
		patch  -p0 < ${FILESDIR}/vdr-1.3.6-${VDRPLUGIN}-${PV}.diff
	fi

}

src_compile() {
	sed -i "/cp.*LIBDIR/d" Makefile
	sed -i "s/^DVBDIR.*$/DVBDIR = \/usr/" Makefile
	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" Makefile
	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib/" Makefile
	#sed -i "s/@install.*$//" Makefile
	sed -i "/@install.*$/d" Makefile
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
