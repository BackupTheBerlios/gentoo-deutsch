# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-bitstreamout/vdrplugin-bitstreamout-0.46g.ebuild,v 1.1 2003/09/24 18:06:17 fow0ryl Exp $

IUSE=""
VDRPLUGIN="bitstreamout"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder - BitStreamOut"
HOMEPAGE="http://bitstreamout.sourceforge.net"
SRC_URI="http://osdn.dl.sourceforge.net/sourceforge/bitstreamout/vdr-${VDRPLUGIN}-${PV}.tar.bz2"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.0
	>=alsa-lib-0.9.2
	>=alsa-utils-0.9.2
	>=alsa-driver-0.9.2
	"

src_unpack() {
	unpack ${A}
}

src_compile() {
	sed -i "/cp.*LIBDIR/d" Makefile
	sed -i "s/^DVBDIR.*$/DVBDIR = \/usr/" Makefile
	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr/" Makefile
	make || die "compile problem"
}

src_install() {
	insinto /etc/conf.d
	doins ${FILESDIR}/vdr.bitstreamout

	doman vdr-bitstreamout.5
	dodoc ChangeLog COPYING Description PROBLEMS
	dodoc ${S}/doc/*

	insinto /usr/bin
	insopts -m0755
	newins ${S}/mute.sh vdr_mute.sh

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
