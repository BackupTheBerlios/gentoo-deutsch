# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-pilot/vdrplugin-pilot-0.0.6-r2.ebuild,v 1.1 2004/07/27 00:32:01 austriancoder Exp $

IUSE=""
VDRPLUGIN="pilot"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder Clock PlugIn"
HOMEPAGE="http://famillejacques.free.fr/vdr/"
SRC_URI="http://famillejacques.free.fr/vdr/pilot/vdr-${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.0"

# include functions from eutils
inherit eutils

src_unpack() {
	unpack ${A}
	if has_version ">=media-video/vdr-1.3.7" ;
	then
		epatch ${FILESDIR}/${VDRPLUGIN}-${PV}-1.3.7.diff
	fi
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
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PV}
	dodoc COPYING README
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PV} libvdr-${VDRPLUGIN}.so
}

pkg_postinst() {
	einfo
	einfo "you need to add the module to /etc/conf.d/vdr"
	einfo "and change butto in keymacros.conf i.e. -> Red       @pilot"
	einfo "and restart vdr to activate it."
}
