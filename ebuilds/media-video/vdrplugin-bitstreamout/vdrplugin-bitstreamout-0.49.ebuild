# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-bitstreamout/vdrplugin-bitstreamout-0.49.ebuild,v 1.1 2003/12/21 13:37:55 fow0ryl Exp $

IUSE=""
VDRPLUGIN="bitstreamout"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder - BitStreamOut"
HOMEPAGE="http://bitstreamout.sourceforge.net"
SRC_URI="http://osdn.dl.sourceforge.net/sourceforge/bitstreamout/vdr-${VDRPLUGIN}-${PV}.tar.bz2"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.6
	>=alsa-lib-0.9.8
	>=alsa-utils-0.9.8
	>=alsa-driver-0.9.8
	>=media-sound/mad-0.14.2b-r2
	"

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -i "/cp.*LIBDIR/d" Makefile
	sed -i "s/^DVBDIR.*$/DVBDIR = \/usr\/include\/dvb/" Makefile
	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" Makefile
	sed -i "s/^VIDEOLIB.*$/VIDEOLIB = \/usr\/lib\/vdr/" Makefile
	sed -i "/@install.*$/d" Makefile
	sed -i "/@-strip.*$/d" Makefile
}

src_compile() {
	emake
}

src_install() {
	insinto /etc/conf.d
	doins ${FILESDIR}/vdr.bitstreamout

	doman vdr-bitstreamout.5
	dodoc ChangeLog COPYING Description PROBLEMS
	dodoc ${S}/doc/*

	insinto /usr/lib/vdr
	insopts -m0755
	newins ${S}/mute/*

	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PV}
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PV} libvdr-${VDRPLUGIN}.so
}

pkg_postinst() {
	einfo
	einfo "you need to add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to activate it."
	einfo
}
