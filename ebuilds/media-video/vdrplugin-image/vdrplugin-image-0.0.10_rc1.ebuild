# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-image/vdrplugin-image-0.0.10_rc1.ebuild,v 1.1 2004/06/30 18:55:11 fow0ryl Exp ${VDRPLUGIN}/vdr-${VDRPLUGIN}-0.0.5a.ebuild,v 1.2 2003/04/15 08:17:08 fow0ryl Exp $

IUSE=""
VDRPLUGIN="image"

#S=${WORKDIR}/${VDRPLUGIN}-${PV/_/-}
S=${WORKDIR}/${VDRPLUGIN}-0.0.10-dev
DESCRIPTION="Video Disk Recorder ${VDRPLUGIN} Plugin"
HOMEPAGE="http://deltab.de/"
#SRC_URI="http://deltab.de/vdr/vdr-${VDRPLUGIN}-${PV/_/-}.tar.gz"
SRC_URI="http://deltab.de/vdr/vdr-${VDRPLUGIN}-0.0.10-dev.tar.gz"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.7
	>=media-video/mpeg2vidcodec
	>=media-libs/netpbm-9.12-r4"

src_unpack() {
	unpack ${A}
	ln -s ${S} ${WORKDIR}/${VDRPLUGIN}-${PV}
}

src_compile() {
	sed -i "/cp.*LIBDIR/d" Makefile
	sed -i "s/^DVBDIR.*$/DVBDIR = \/usr/" Makefile
	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" Makefile
	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib/" Makefile

	make all|| die "compile problem"
}

src_install() {
	cd ${S}
	insinto /etc/vdr/plugins
	insopts -m0744
	doins examples/imagesources.conf
	
	exeinto /usr/bin
	doexe scripts/convert_jump.sh
	doexe scripts/convert_functions.sh
	doexe scripts/convert.sh
	doexe scripts/convert_zoom.sh
	doexe scripts/mount.sh

	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PV}
	dodoc COPYING README HISTORY
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PV} libvdr-${VDRPLUGIN}.so
}

pkg_postinst() {
	echo
	einfo "you need add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to aktivate it."
	echo
}
