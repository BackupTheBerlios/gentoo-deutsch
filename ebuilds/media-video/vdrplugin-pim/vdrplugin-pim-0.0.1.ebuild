# Copyright 2004 Christian Gmeiner <christian at visual-page dot de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-pim/vdrplugin-pim-0.0.1.ebuild,v 1.1 2004/07/15 23:24:52 austriancoder Exp $

IUSE=""

S=${WORKDIR}/pim-${PV}
DESCRIPTION="Video Disk Recorder PIM Plugin"
HOMEPAGE="http://tuffi.privat.t-online.de/vdr/"
SRC_URI="http://tuffi.privat.t-online.de/vdr/vdr-pim-${PV}.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.0"

src_unpack() {
	unpack ${A}
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
	make all|| die "compile problem"
}

src_install() {
	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-pim.so libvdr-pim.so.${VERSION}
	dodoc COPYING README 
#	touch ${D}etc/vdr/plugins/prefermenu.conf
#	fowners vdr ${D}etc/vdr/plugins/prefermenu.conf
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-pim.so.${VERSION} libvdr-pim.so
}

pkg_postinst() {
	einfo
	einfo "you need to to add the module to /etc/conf.d/vdr and"
	einfo "restart vdr to activate it."
	einfo
}
