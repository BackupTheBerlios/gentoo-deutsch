# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-alcd/vdrplugin-alcd-0.0.19.ebuild,v 1.1 2003/10/01 20:19:14 martini Exp $

IUSE=""
VDRPLUGIN="alcd"

S=${WORKDIR}/${VDRPLUGIN}
DESCRIPTION="Video Disk Recorder Activy 300 LCD PlugIn"
HOMEPAGE="http://home.primusnetz.de/mgeisler/alcd/"
SRC_URI="http://home.primusnetz.de/mgeisler/alcd/${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.0"

src_unpack() {
	unpack ${A}
}

src_compile() {
	sed -i "s/ifdef NEWSTRUCT/#ifdef NEWSTRUCT/" Makefile
	sed -i "s/DEFINEES += -NEWSTRUCT/DEFINES += -D_GNU_SOURCE/" Makefile
	sed -i "s/else/#else/" Makefile
	sed -i "s/DVBDIR = ..\/..\/..\/..\/DVB\/ost\/include/#DVBDIR = ..\/..\/..\/..\/DVB\/ost\/include/" Makefile
	sed -i "23s/endif/#endif/" Makefile
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
	dodoc COPYING HISTORY README
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PV} libvdr-${VDRPLUGIN}.so
}

pkg_postinst() {
	einfo
	einfo "you need add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to aktivate it."
	einfo
}
