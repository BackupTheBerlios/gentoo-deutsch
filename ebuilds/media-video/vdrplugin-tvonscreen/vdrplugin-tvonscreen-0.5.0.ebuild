# Copyright 2003 Frederik Kunz <frederik.kunz@web.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-tvonscreen/Attic/vdrplugin-tvonscreen-0.5.0.ebuild,v 1.4 2004/03/23 15:21:13 austriancoder Exp $

IUSE=""
VDRPLUGIN="tvonscreen"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder TvOnScreen PlugIn"
HOMEPAGE="http://www.js-home.org/vdr/tvonscreen"
SRC_URI="http://www.js-home.org/vdr/tvonscreen/vdr-tvonscreen-${PV}.tar.gz
http://www.visual-page.de/vdr/vdr-136-tvonscreen-0.5.0-patch.diff.gz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.6"

src_unpack() {
	unpack ${A}

	# patch for vdr 1.3.x ?
	epatch ../vdr-136-tvonscreen-0.5.0-patch.diff
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
	insopts -m0755 -ovdr -gvideo
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PV}
	dodoc COPYING README HISTORY
        insopts -m0644 -ovdr -gvideo
        insinto /etc/vdr/plugins/${VDRPLUGIN}
        doins ${S}/${VDRPLUGIN}/*
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PV} libvdr-${VDRPLUGIN}.so
}

pkg_postinst() {
	einfo
	einfo "you need to add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to activate it."
	einfo 
}
