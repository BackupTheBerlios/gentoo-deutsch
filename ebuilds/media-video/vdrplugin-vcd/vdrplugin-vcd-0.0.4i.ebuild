# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-vcd/Attic/vdrplugin-vcd-0.0.4i.ebuild,v 1.1 2003/06/07 22:09:10 fow0ryl Exp ${VDRPLUGIN}/vdr-${VDRPLUGIN}-0.0.4i.ebuild,v 1.1 2003/05/12 18:01:14 fow0ryl Exp $

IUSE=""
VDRPLUGIN="vcd"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder ${VDRPLUGIN} Plugin"
HOMEPAGE="http://www.heiligenmann.de/"
SRC_URI=" http://www.heiligenmann.de/download/vdr-${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.0"

src_unpack() {
	unpack ${A}
}

src_compile() {
	sed -i "/cp.*LIBDIR/d" Makefile
	sed -i "s/^DVBDIR.*$/DVBDIR = \/usr\/include\/dvb/" Makefile
	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" Makefile
	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib\/vdr/" Makefile
	make all|| die "compile problem"
}

src_install() {
	insinto /etc/conf.d
	doins ${FILESDIR}/vdr.${VDRPLUGIN}
	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PV}
	dodoc COPYING HISTORY README
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PV} libvdr-${VDRPLUGIN}.so
}

pkg_postinst() {
	einfo
	einfo "you need add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to aktivate it."
	einfo
}
