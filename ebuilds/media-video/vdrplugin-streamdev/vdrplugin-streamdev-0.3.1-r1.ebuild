# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /cvsroot/gentoo-deutsch/ebuilds/media-video/vdrplugin-streamdev/vdrplugin-streamdev-0.2.0.ebuild,v 1.1 2003/10/22 18:28:53 martini Exp

IUSE=""
VDRPLUGIN="streamdev"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder Client/Server streaming plugin"
HOMEPAGE="http://www.magoa.net/linusx/"
SRC_URI=" http://www.magoa.net/linux/files/vdr-${VDRPLUGIN}-${PV}.tgz
	http://www.akool.de/download/plugins/streamdev-0.1.0beta4.patch.bz2"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.3.6"

function vdr_opts {
	local x
	for x in ${VDR_OPTS}
	do
		if [ "${x}" = "${1}" ]
		then
			return 0
		fi
	done
	ewarn "No optional ${1} in VDR_OPTS"
	return 1
}

src_unpack() {
#	einfo
#	einfo "VDR_OPTS: $VDR_OPTS"
#	einfo
	unpack ${A}
#	if vdr_opts akool; then
#		cd ${S}/client
#		einfo "Apply streamdev patch"
#		patch < ../../streamdev-0.1.0beta4.patch
#	fi
	cd ${S}/server
	patch < ${FILESDIR}/vdr-1.3.6-${VDRPLUGIN}-0.3.1.patch
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
	newins libvdr-${VDRPLUGIN}-client.so libvdr-${VDRPLUGIN}-client.so.${PV}
	newins libvdr-${VDRPLUGIN}-server.so libvdr-${VDRPLUGIN}-server.so.${PV}
	dodoc COPYING HISTORY README
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}-client.so.${PV} libvdr-${VDRPLUGIN}-client.so
	ln -s libvdr-${VDRPLUGIN}-server.so.${PV} libvdr-${VDRPLUGIN}-server.so
}

pkg_postinst() {
	einfo
	einfo "you need add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to aktivate it."
	einfo
}
