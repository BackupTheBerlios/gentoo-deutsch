# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/ebuilds/ebuilds/media-video/vdrplugin-mplayer/Attic/vdrplugin-mplayer-0.7.15.ebuild,v 1.1 2003/08/22 15:27:34 fow0ryl Exp $

IUSE=""
PVERSION="0.7.15"
S=${WORKDIR}/mp3-${PVERSION}
DESCRIPTION="Video Disk Recorder MPlayer Plugin"
HOMEPAGE="http://www.muempf.de/"
SRC_URI="http://www.muempf.de/down/vdr-mp3-${PVERSION}.tar.gz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.0
		>=media-video/mplayer-0.90_rc4"

src_unpack() {
	unpack ${A}
}

src_compile() {
	sed -i "/cp.*LIBDIR/d" Makefile 
	sed -i "s/^DVBDIR.*$/DVBDIR = \/usr\/include\/linux\/dvb/" Makefile
	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" Makefile
	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib/" Makefile
	sed -i "s/^#WITHOUT_MP3=1$/WITHOUT_MP3=1/" Makefile
	make all|| die "compile problem"
}

src_install() {
	insinto /etc/conf.d
	doins ${FILESDIR}/vdr.mplayer
	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-mplayer.so libvdr-mplayer.so.${PVERSION}
	dodoc COPYING HISTORY README MANUAL
	dodoc examples/mplayer.sh.example
	dodoc examples/mount.sh.example
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-mplayer.so.${PVERSION} libvdr-mplayer.so
}

pkg_postinst() {
	einfo
	einfo "you need to add the module to /etc/conf.d/vdr" 
	einfo "and restart vdr to activate it."
	einfo
}
