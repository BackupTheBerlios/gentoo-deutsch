# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-sleeptimer/vdrplugin-sleeptimer-0.5.ebuild,v 1.1 2004/07/14 10:16:16 austriancoder Exp $

IUSE=""
VDRPLUGIN="sleeptimer"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder MP3OSS PlugIn"
HOMEPAGE="hhttp://linvdr.org/download/vdr-sleeptimer"
SRC_URI="http://linvdr.org/download/vdr-sleeptimer/${VDRPLUGIN}-${PV}.tar.gz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.6"

# include functions from eutils
inherit eutils

src_unpack() {
	unpack ${A}

	if  
	has_version ">=media-video/vdr-1.3.7" ;
	then
		epatch ${FILESDIR}/sleeptimer-0.2.diff
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
	sed -i "s/@install.*$//" Makefile
	sed -i "/@install.*$/d" Makefile
	make all || die "compile problem"
}

src_install() {
	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PV}
	dodoc COPYING README HISTORY
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PV} libvdr-${VDRPLUGIN}.so
}

pkg_postinst() {
	einfo
	einfo "you need to add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to activate it."
	einfo 
}
