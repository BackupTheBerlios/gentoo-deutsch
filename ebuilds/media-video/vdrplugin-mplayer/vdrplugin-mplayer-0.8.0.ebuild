# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-mplayer/Attic/vdrplugin-mplayer-0.8.0.ebuild,v 1.1 2003/06/07 21:55:16 fow0ryl Exp ${VDRPLUGIN}/vdrplugin-${VDRPLUGIN}-0.7.15.ebuild,v 1.1 2003/06/05 09:39:40 mad Exp $

IUSE=""
VDRPLUGIN="mplayer"

S=${WORKDIR}/mp3-${PV}
DESCRIPTION="Video Disk Recorder ${VDRPLUGIN} Plugin"
HOMEPAGE="http://www.muempf.de/"
SRC_URI="http://www.muempf.de/down/vdr-mp3-${PV}.tar.gz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.0
	>=media-video/${VDRPLUGIN}-0.90_rc4
	media-sound/mad
	sys-libs/zlib
	media-libs/libsndfile"

src_unpack() {
	unpack ${A}
}

src_compile() {
	sed -i "/cp.*LIBDIR/d" Makefile
	sed -i "s/^DVBDIR.*$/DVBDIR = \/usr\/include\/linux\/dvb/" Makefile
	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" Makefile
	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib/" Makefile
	make all|| die "compile problem"
}

src_install() {
	insinto /etc/conf.d
	doins ${FILESDIR}/vdr.${VDRPLUGIN}
	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PV}
	newins libvdr-mp3.so libvdr-mp3.so.${PV}
	dodoc COPYING HISTORY README MANUAL
	dodoc examples/${VDRPLUGIN}.sh.example
	dodoc examples/mount.sh.example
	dodoc examples/mp3sources.conf.example
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PV} libvdr-${VDRPLUGIN}.so
	ln -s libvdr-mp3.so.${PV} libvdr-mp3.so
}

pkg_postinst() {
	einfo
	einfo "you need to add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to activate it."
	einfo
}
