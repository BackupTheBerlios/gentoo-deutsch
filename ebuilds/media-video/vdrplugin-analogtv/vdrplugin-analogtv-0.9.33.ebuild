# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-analogtv/vdrplugin-analogtv-0.9.33.ebuild,v 1.1 2004/07/14 21:56:21 austriancoder Exp ${VDRPLUGIN}/vdr-${VDRPLUGIN}-0.5.0.ebuild,v 1.1 2003/05/03 14:48:26 fow0ryl Exp $

IUSE=""
VDRPLUGIN="analogtv"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder ${VDRPLUGIN} Plugin"
HOMEPAGE="http://akool.bei.t-online.de/"
SRC_URI="http://akool.bei.t-online.de/vdr/analogtv/download/vdr-${VDRPLUGIN}-${PV}.tar.bz2
	http://akool.bei.t-online.de/vdr/analogtv/download/rte-10mar03.tar.bz2"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.5
	=media-libs/libdvb-0.5.0"

src_unpack() {
	unpack ${A}

	cd ${S}
	ln -s ../rte rte

	cd ${S}/..
	patch -p0 < ${S}/patches/mp1e.patch
	#patch -d ${S}/rte -p1 < ${FILESDIR}/mp1e.patch.new
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
	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib\/vdr/" Makefile
	make all || die "compile problem"
	cd ${S}/rte/mp1e
	econf
	emake
}

src_install() {
	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PV}
	dodoc COPYING README HISTORY
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PV} libvdr-${VDRPLUGIN}.so

	cd ${S}/rte/mp1e
	doman mp1e.1
	dodoc COPYING README BUGS ChangeLog
	insinto /usr/bin
	dobin mp1e
}

pkg_postinst() {
	einfo
	einfo "you need to add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to activate it."
	einfo
}
