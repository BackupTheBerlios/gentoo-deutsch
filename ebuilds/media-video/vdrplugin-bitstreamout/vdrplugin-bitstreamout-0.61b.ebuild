# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-bitstreamout/vdrplugin-bitstreamout-0.61b.ebuild,v 1.1 2004/07/19 21:22:27 austriancoder Exp $

IUSE=""
VDRPLUGIN="bitstreamout"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder - BitStreamOut"
HOMEPAGE="http://bitstreamout.sourceforge.net"
SRC_URI="mirror://sourceforge/bitstreamout/vdr-${VDRPLUGIN}-${PV}.tar.bz2"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.6
	>=alsa-lib-0.9.8
	>=alsa-utils-0.9.8
	>=media-libs/libmad-0.14.2b-r2
	"

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -i "/cp.*LIBDIR/d" Makefile

	# if we are using a 2.6 Kernel the dvb includes are in the /usr/src/linux dir (fix by Christian Gmeiner)
	if [ "${KV:0:3}" == "2.6" ] ; then
		sed -i "s/^DVBDIR.*$/DVBDIR = \/usr\/src\/linux/" Makefile
	fi
	if [ "${KV:0:3}" == "2.4" ] ; then
		sed -i "s/^DVBDIR.*$/DVBDIR = \/usr/" Makefile
	fi

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
	doins ${S}/mute/*

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
