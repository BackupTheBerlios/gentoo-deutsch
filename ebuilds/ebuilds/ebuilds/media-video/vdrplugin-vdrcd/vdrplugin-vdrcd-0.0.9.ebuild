# Copyright 2003 Henning Ryll <henning.ryll@web.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/ebuilds/ebuilds/media-video/vdrplugin-vdrcd/Attic/vdrplugin-vdrcd-0.0.9.ebuild,v 1.1 2003/08/22 15:27:34 fow0ryl Exp ${VDRPLUGIN}/vdr-${VDRPLUGIN}-0.0.7.ebuild,v 1.3 2003/04/15 08:18:24 fow0ryl Exp $

IUSE=""
VDRPLUGIN="vdrcd"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder Media Detection Plugin"
HOMEPAGE="http://www.magoa.net/linux"
SRC_URI="http://www.magoa.net/linux/files/vdr-${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.0"


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
	insinto /etc/conf.d
	doins ${FILESDIR}/vdr.${VDRPLUGIN}

	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PV}
	dodoc COPYING HISTORY README
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PV} libvdr-${VDRPLUGIN}.so
}

pkg_postinst() {
	einfo
	einfo "you need to add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to aktivate it."
	einfo "you also have to modify /etc/conf.cd/vdr.${VDRPLUGIN}"
	einfo "so it fits to your needs"
	einfo
}
