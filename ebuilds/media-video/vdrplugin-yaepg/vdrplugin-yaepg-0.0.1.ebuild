# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-yaepg/vdrplugin-yaepg-0.0.1.ebuild,v 1.1 2004/07/27 20:33:46 austriancoder Exp $

IUSE=""
VDRPLUGIN="yaepg"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder ${VDRPLUGIN} Plugin"
HOMEPAGE="http://cube.snickers.org/~skhosla/yaepg"
SRC_URI="http://cube.snickers.org/~skhosla/yaepg/vdr-${VDRPLUGIN}-${PV}.tar.gz
	  http://htpc.at/public/vdr/yaepg/yaepg-pal.diff.bz2"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.6"

# include functions from eutils
inherit eutils


src_unpack() {
	unpack ${A}
	
	cd ${S}
	epatch ../yaepg-pal.diff
}

src_compile() {
	sed -i "/cp.*LIBDIR/d" Makefile

	# if we are using a 2.6 Kernel the dvb includes are in the /usr/src/linux dir (fix by Christian Gmeiner)
	if [ "${KV:0:3}" == "2.6" ] ; then
		sed -i "s/^DVBDIR.*$/DVBDIR = \/usr\/src\/linux/" Makefile
	fi
	if [ "${KV:0:3}" == "2.4" ] ; then
		sed -i "s/^DVBDIR.*$/DVBDIR = \/usr/" Makefile
	fi

	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" Makefile
	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib/" Makefile

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
