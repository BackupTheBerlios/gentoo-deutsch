# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/linuxtv-dvb/Attic/linuxtv-dvb-1.0.0_pre3-r20030608.ebuild,v 1.1 2003/06/10 10:03:30 mad Exp $

IUSE=""


# Use this for CVS HEAD Versions by Klaus S.
VERSION="2003-06-08"
DESCRIPTION="This is the standalone DVB driver for Kernel 2.4.x (CVS HEAD)"
SRC_URI="ftp://ftp.cadsoft.de/vdr/Developer/linux-dvb.${VERSION}.tar.bz2"

# Use this if it is a pre/stable release
#VERSION="1.0.0-pre2"
#DESCRIPTION="This is the standalone DVB driver for Kernel 2.4.x"
#SRC_URI="http://www.linuxtv.org/download/dvb/${PN}-${VERSION}.tar.gz"

HOMEPAGE="http://linuxtv.org"

S=${WORKDIR}/linux-dvb.${VERSION}
KEYWORDS="~x86"
SLOT="1"
LICENSE="GPL"

DEPEND="virtual/glibc
		virtual/linux-sources
		!media-video/linuxdvb"
RDEPEND="virtual/glibc"
	
pkg_setup() {
	if [ -z "$(modinfo -n input 2>/dev/null)" -o -z "$(modinfo -n evdev 2>/dev/null)" ]; then
	ewarn
	ewarn "If something goes wrong, make sure you have evdev,video, i2c and "
	ewarn "input support in your kernel. Check your Kernelconfiguration"
	ewarn "for input core support, event interface support, i2c support,"
	ewarn "and video for linux support. Be sure /usr/src/linux point's to"
	ewarn "your current kernel or make will die."
	ewarn
	fi
}

src_unpack() {
        unpack ${A} || die "unpack failed"
}

src_compile() {
	cd ${S}
        make || die "compile problem"
}

src_install() {
	cd ${S}/driver

	# no depmod now
	sed -i "s/depmod -a/#depmod -a/g" Makefile

	make -e DESTDIR=${D} install || die "make install problem"

	cd ${S}
	# clean cvs package 
	find -name CVS -type d | xargs rm -rf

	# install dvbnet
	dobin   apps/dvbnet/dvbnet
	insinto /usr/share/doc/${P}/dvbnet
	doins   apps/dvbnet/net_start.*


	# install av7110_loadkeys
	dobin   apps/av7110_loadkeys/av7110_loadkeys \
			apps/av7110_loadkeys/evtest
	insinto /usr/share/doc/${P}/av7110_loadkeys
	doins   apps/av7110_loadkeys/README \
			apps/av7110_loadkeys/*.rc5 \
			apps/av7110_loadkeys/*.rcmm

	# install scan
	dobin   apps/scan/scan

	# install szap
	dobin   apps/szap/[tsc]zap
	docinto zap
	dodoc   apps/szap/channels.conf-dvb*

	# install docs
	dodoc   doc/HOWTO* doc/README.* doc/channel driver/makedev.napi
	dodoc   BUGS CONTRIBUTORS COPYING NEWS INSTALL README
	insinto /usr/share/doc/${P}/dvbapi
	doins   doc/dvbapi/*

	# install headers
	insinto /usr/include/linux
	# conflict with em8300-libraries
	#doins   include/linux/em8300.h
	doins	driver/*.h

	insinto /usr/include/linux/dvb
	doins   include/linux/dvb/*.h
	
	sed -i "s/alps_bsru6 //" driver/modules.conf
	insinto /etc/modules.d
	newins  driver/modules.conf linuxtv-dvb
	insinto /etc/devfs.d
	newins  driver/devfsd.conf linuxtv-dvb
}

pkg_postinst() {
	[ -x /sbin/update-modules ] && /sbin/update-modules
}

pkg_postrm() {
	[ -x /sbin/update-modules ] && /sbin/update-modules
}
