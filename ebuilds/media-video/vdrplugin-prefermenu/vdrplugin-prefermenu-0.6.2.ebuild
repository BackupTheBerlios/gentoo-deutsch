# Copyright 2003 Henning Ryll <henning.ryll@web.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-prefermenu/vdrplugin-prefermenu-0.6.2.ebuild,v 1.1 2004/06/13 00:06:42 fow0ryl Exp $

IUSE=""

S=${WORKDIR}/prefermenu-${PV}
DESCRIPTION="Video Disk Recorder Prefermenu Plugin"
HOMEPAGE="http://www.olivierjacques.com/vdr/prefermenu/"
#SRC_URI="http://famillejacques.free.fr/vdr/prefermenu/vdr-prefermenu-${VERSION}.tgz"
SRC_URI="http://www.azimi.de/vdr/vdr-prefermenu-${PV}.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.9"

src_unpack() {
	unpack ${A}
}

src_compile() {
	sed -i "/cp.*LIBDIR/d" Makefile 
	sed -i "s/^DVBDIR.*$/DVBDIR = \/usr/" Makefile
	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" Makefile
	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib/" Makefile
	make all|| die "compile problem"
}

src_install() {
	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-prefermenu.so libvdr-prefermenu.so.${PV}
	dodoc COPYING README 
	touch ${D}/etc/vdr/plugins/prefermenu.conf
	fowners vdr ${D}/etc/vdr/plugins/prefermenu.conf
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-prefermenu.so.${PV} libvdr-prefermenu.so
}

pkg_postinst() {
	einfo
	einfo "you need to to add the module to /etc/conf.d/vdr and"
	einfo "restart vdr to activate it."
	einfo
}
