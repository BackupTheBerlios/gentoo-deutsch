# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-image/vdrplugin-image-0.0.5a.ebuild,v 1.1 2003/06/06 18:13:47 fow0ryl Exp ${VDRPLUGIN}/vdr-${VDRPLUGIN}-0.0.5a.ebuild,v 1.2 2003/04/15 08:17:08 fow0ryl Exp $

IUSE=""
VDRPLUGIN="image"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder ${VDRPLUGIN} Plugin"
HOMEPAGE="http://www.burwieck.net/"
SRC_URI="http://www.burwieck.net/vdr/vdr-${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.0
	media-gfx/imagemagick
	media-video/mpeg2vidcodec"

src_unpack() {
	unpack ${A}
}

src_compile() {
	sed -i "/cp.*LIBDIR/d" Makefile
	sed -i "s/^DVBDIR.*$/DVBDIR = \/usr/" Makefile
	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" Makefile
	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib/" Makefile
	echo -e "22a23\n> #include <string.h>" | patch setup-${VDRPLUGIN}.c

	make all|| die "compile problem"
}

src_install() {
	newlib.so libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${VDRVERSION}
	dodoc COPYING README HISTORY
	insinto /etc/vdr/plugins
	insopts -m0744
	newins examples/imagesources.conf.example imagesources.conf
	newbin examples/convert.sh.example convert.sh

	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PVERSION}
	dodoc COPYING HISTORY README
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PVERSION} libvdr-${VDRPLUGIN}.so
}

pkg_postinst() {
	echo
	einfo "you need add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to aktivate it."
	echo
}
