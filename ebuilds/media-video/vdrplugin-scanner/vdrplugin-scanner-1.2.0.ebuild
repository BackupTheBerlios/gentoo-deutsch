# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-scanner/Attic/vdrplugin-scanner-1.2.0.ebuild,v 1.2 2003/06/10 19:50:31 mad Exp $

IUSE=""
VDRPLUGIN="scanner"

S=${WORKDIR}/${VDRPLUGIN}
#S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder Clock PlugIn"
HOMEPAGE="http://akool.de/"
SRC_URI="http://www.akool.de/download/vdr-${VDRPLUGIN}-${PV}.tar.bz2"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch < ${FILESDIR}/${VDRPLUGIN}-${PV}.diff
}

src_compile() {
	sed -i \
		-e "/cp.*LIBDIR/d" \
		-e "s/^DVBDIR.*$/DVBDIR = \/usr/" \
		-e "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" \
		-e "s/^LIBDIR.*$/LIBDIR = \/usr\/lib\/vdr/" \
		-e "s/^LIBS.*$/LIBS = \/usr\/lib\/libdtv.a/" \
			Makefile

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
