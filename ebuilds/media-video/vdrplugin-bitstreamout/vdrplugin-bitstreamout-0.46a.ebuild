# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-bitstreamout/Attic/vdrplugin-bitstreamout-0.46a.ebuild,v 1.1 2003/06/21 11:01:44 fow0ryl Exp $

IUSE=""
VDRPLUGIN="bitstreamout"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder - Console PlugIn"
HOMEPAGE="http://bitstreamout.sourceforge.net"
SRC_URI="http://osdn.dl.sourceforge.net/sourceforge/bitstreamout/vdr-${VDRPLUGIN}-${PV}.tar.bz2"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.0
	>=alsa-lib-0.9.0_rc6
	>=alsa-util-0.9.0_rc6
	>=alsa-driver-0.9.0_rc6
	"

src_unpack() {
	unpack ${A}
}

src_compile() {
	sed -i "/cp.*LIBDIR/d" Makefile
	sed -i "s/^DVBDIR.*$/DVBDIR = \/usr/" Makefile
	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" Makefile
	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib\/vdr/" Makefile
	cp mute.sh vdr_mute.sh
	make all|| die "compile problem"
}

src_install() {
	insinto /etc/conf.d
	doins ${FILESDIR}/vdr.bitstreamout

	doman vdr-bitstreamout.5
	dodoc ChangeLog COPYING Description PROBLEMS
	dodoc ${S}/doc/*

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