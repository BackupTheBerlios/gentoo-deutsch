# Copyright 2004 Frederik Kunz <frederik.kunz@web.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-screenshot/vdrplugin-screenshot-0.0.5.ebuild,v 1.1 2004/06/10 18:36:40 fow0ryl Exp $

IUSE=""
VDRPLUGIN="screenshot"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder Screenshot PlugIn"
HOMEPAGE="http://www.joachim-wilke.de/vdr.html"
SRC_URI="http://www.stud.uni-karlsruhe.de/~upi9/vdr/vdr-${VDRPLUGIN}-${PV}.tar.bz2"
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
