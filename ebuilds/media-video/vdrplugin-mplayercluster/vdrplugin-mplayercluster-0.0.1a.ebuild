# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /cvsroot/gentoo-deutsch/ebuilds/media-video/vdrplugin-vcd/vdrplugin-vcd-0.0.5b.ebuild,v 1.1 2003/10/14 18:05:47 martini Exp 

IUSE=""
VDRPLUGIN="mplayercluster"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder ${VDRPLUGIN} Plugin"
HOMEPAGE="http://www.magoa.net/linux/"
SRC_URI=" http://www.magoa.net/linux/files/vdr-${VDRPLUGIN}-${PV}.tgz
	http://www.akool.de/download/plugins/mplayercluster-0.0.1a.patch.bz2"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.5"

src_unpack() {
	unpack ${A}
	epatch ${WORKDIR}/mplayercluster-${PV}.patch
}

src_compile() {
	sed -i "/cp.*LIBDIR/d" Makefile
	sed -i "s/^DVBDIR.*$/DVBDIR = \/usr\/include\/dvb/" Makefile
	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" Makefile
	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib\/vdr/" Makefile
	make all|| die "compile problem"
}

src_install() {
	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PV}
	dodoc COPYING HISTORY README mplayerclusterkeys.conf.sample mplayersources.conf.sample
	exeinto /usr/local/bin
	doexe ${S}/recode-server/recode-server
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PV} libvdr-${VDRPLUGIN}.so
}

pkg_postinst() {
	einfo
	einfo "you need add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to aktivate it."
	einfo
	einfo "for the mplayercluster plugin you must compile your"
	einfo "mplayer without dvb-support"
	einfo
}
