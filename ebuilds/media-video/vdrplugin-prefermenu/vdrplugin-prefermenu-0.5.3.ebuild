# Copyright 2003 Henning Ryll <henning.ryll@web.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-prefermenu/vdrplugin-prefermenu-0.5.3.ebuild,v 1.2 2003/06/05 09:36:29 mad Exp $

IUSE=""
VERSION="0.5.3"

S=${WORKDIR}/prefermenu-${VERSION}
DESCRIPTION="Video Disk Recorder Prefermenu Plugin"
HOMEPAGE="http://www.olivierjacques.com/vdr/prefermenu/"
SRC_URI="http://famillejacques.free.fr/vdr/prefermenu/vdr-prefermenu-${VERSION}.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.0"

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
	newins libvdr-prefermenu.so libvdr-prefermenu.so.${VERSION}
	dodoc COPYING README 
	touch ${D}etc/vdr/plugins/prefermenu.conf
	fowners vdr ${D}etc/vdr/plugins/prefermenu.conf
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-prefermenu.so.${VERSION} libvdr-prefermenu.so
}

pkg_postinst() {
	einfo
	einfo "you need to to add the module to /etc/conf.d/vdr and"
	einfo "restart vdr to activate it."
	einfo
}
