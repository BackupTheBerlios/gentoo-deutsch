# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-image/vdrplugin-image-0.0.8_pre5.ebuild,v 1.1 2004/02/28 23:25:01 fow0ryl Exp ${VDRPLUGIN}/vdr-${VDRPLUGIN}-0.0.5a.ebuild,v 1.2 2003/04/15 08:17:08 fow0ryl Exp $

IUSE=""
VDRPLUGIN="image"

S=${WORKDIR}/${VDRPLUGIN}-0.0.8-pre-5
#S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder ${VDRPLUGIN} Plugin"
HOMEPAGE="http://vdr-image.kreuzinger.biz/"
SRC_URI="http://vdr-image.kreuzinger.biz/vdr-${VDRPLUGIN}-0.0.8-pre-5.tar.gz"
#SRC_URI="http://vdr-image.kreuzinger.biz/vdr-${VDRPLUGIN}-${PV}-pre-5.tar.gz"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.0
	>=media-gfx/imagemagick-5.5.6-r1
	>=media-video/mpeg2vidcodec
	>=media-libs/netpbm-9.12-r4"

src_unpack() {
	unpack ${A}
}

src_compile() {
	sed -i "/cp.*LIBDIR/d" Makefile
	sed -i "s/^DVBDIR.*$/DVBDIR = \/usr/" Makefile
	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" Makefile
	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib/" Makefile

	make all|| die "compile problem"
}

src_install() {
	cd ${S}
	insinto /etc/vdr/plugins
	insopts -m0744
	newins examples/imagesources.conf.example imagesources.conf
	
	exeinto /usr/bin
	newbin examples/convert_jump.sh.example convert_jump.sh
	newbin examples/convert.sh.background convert.sh.background
	newbin examples/convert.sh.example convert.sh
	newbin examples/convert_zoom.sh.example convert_zoom.sh
	newbin examples/image_pregen.sh.example image_pregen.sh
	newbin examples/mount.sh.example mount.sh

	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PV}
	dodoc COPYING README HISTORY README.SCRIPTS
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PV} libvdr-${VDRPLUGIN}.so
}

pkg_postinst() {
	echo
	einfo "you need add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to aktivate it."
	echo
}
