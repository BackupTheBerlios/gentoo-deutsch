# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-remote/vdrplugin-remote-0.3.1.ebuild,v 1.1 2004/06/12 10:33:49 fow0ryl Exp $

IUSE=""
VDRPLUGIN="remote"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder ${VDRPLUGIN} plugin"
HOMEPAGE="http://endriss.escape.bei.t-online.de/vdr/"
SRC_URI="
	http://endriss.escape.bei.t-online.de/vdr/vdr-${VDRPLUGIN}-${PV}.tgz
	http://michael.justfor-e.net/gentoo/vdr/vdr-remote-0.3.1-0.3.1a.diff.gz
"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.3.6"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ../vdr-remote-0.3.1-0.3.1a.diff
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
