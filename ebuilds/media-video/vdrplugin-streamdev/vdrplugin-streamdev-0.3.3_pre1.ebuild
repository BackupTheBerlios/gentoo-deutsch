# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

IUSE=""
VDRPLUGIN="streamdev"

#S=${WORKDIR}/${VDRPLUGIN}-${PV}-pre1
S=${WORKDIR}/${VDRPLUGIN}-0.3.3-pre1
DESCRIPTION="Video Disk Recorder Client/Server streaming plugin"
HOMEPAGE="http://www.magoa.net/linux/"
#SRC_URI=" http://www.magoa.net/linux/files/vdr-${VDRPLUGIN}-${PV}.tgz"
SRC_URI=" http://www.magoa.net/linux/contrib/vdr-${VDRPLUGIN}-0.3.3-pre1.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.3.7"

# include functions from eutils
inherit eutils

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
