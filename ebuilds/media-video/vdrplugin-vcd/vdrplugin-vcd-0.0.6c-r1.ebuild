# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-vcd/vdrplugin-vcd-0.0.6c-r1.ebuild,v 1.1 2004/07/24 22:43:06 austriancoder Exp ${VDRPLUGIN}/vdr-${VDRPLUGIN}-0.0.4i.ebuild,v 1.1 2003/05/12 18:01:14 fow0ryl Exp $

IUSE=""
VDRPLUGIN="vcd"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder ${VDRPLUGIN} Plugin"
HOMEPAGE="http://vdr.heiligenmann.de/"
SRC_URI=" http://vdr.heiligenmann.de/download/vdr-${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.6"

src_unpack() {
	unpack ${A}

	if has_version ">=media-video/vdr-1.3.7" ;
	then
		einfo "Applying ${VDRPLUGIN}-${PV}-1.3.7 patch"
		cd ${S}
		patch -R < ${FILESDIR}/${VDRPLUGIN}-${PV}-1.3.7.diff

	fi

       # if we are using a 2.6 Kernel the dvb includes are in the /usr/src/linux dir (fix by Christian Gmeiner)
	if [ "${KV:0:3}" == "2.6" ] ; then
		sed -i "s/^DVBDIR.*$/DVBDIR = \/usr\/src\/linux/" ${S}/Makefile
	fi
	if [ "${KV:0:3}" == "2.4" ] ; then
		sed -i "s/^DVBDIR.*$/DVBDIR = \/usr/" ${S}/Makefile
	fi

	sed -i "/cp.*LIBDIR/d" Makefile
	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" Makefile
	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib\/vdr/" Makefile
	sed -i "s/^INCLUDES.*$/INCLUDES = -I$\(VDRDIR\)\/include -I$\(DVBDIR\)\/include/" Makefile
}

src_compile() {
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
	einfo "you need add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to aktivate it."
	einfo
}
