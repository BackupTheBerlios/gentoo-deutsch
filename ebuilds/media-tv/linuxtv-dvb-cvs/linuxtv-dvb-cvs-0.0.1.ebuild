# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-tv/linuxtv-dvb-cvs/linuxtv-dvb-cvs-0.0.1.ebuild,v 1.1 2004/01/15 18:06:35 fow0ryl Exp $

VERSION="2003-11-08"

inherit cvs

ECVS_CVS_COMMAND="cvs"
ECVS_ANON="yes"
ECVS_SERVER="linuxtv.org:/cvs/linuxtv"
ECVS_MODULE="DVB"
ECVS_TOPDIR="${DISTDIR}/cvs-src/DVB"

S=${WORKDIR}/DVB
DESCRIPTION="This is the CVS standalone DVB driver for Kernel 2.4.x"
HOMEPAGE="http://linuxtv.org/"
LICENSE="GPL"
SLOT="1"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/glibc
	virtual/linux-sources
	!media-video/linuxdvb"
RDEPEND="virtual/glibc"

pkg_setup() {
	if [ -z "$(modinfo -n input 2>/dev/null)" -o -z "$(modinfo -n evdev 2>/dev/null)" ]; then
	ewarn
	ewarn "If something goes wrong, make sure you have evdev,video, i2c and "
	ewarn "input support in your kernel. Check your kernelconfiguration"
	ewarn "for input core support, event interface support, i2c support,"
	ewarn "and video for linux support. Be sure /usr/src/linux point's to"
	ewarn "your current kernel or make will die."
	ewarn
	fi
}

src_unpack() {
	cvs_src_unpack
	unpack ${A} || die "unpack failed"
	#einfo patching stillimage
	#cat ${FILESDIR}/stillimage.patch | patch ${S}/apps/test/test_stillimage.c

	#patch av7110 for loading keymaps as normal user
	cd ${S}/driver/av7110
	epatch ${FILESDIR}/av7110_ir-permission-666.diff
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

	newbin  apps/test/test_stillimage dvb_stillimage

	# install scan
	dobin   apps/scan/scan

	# install szap
	dobin   apps/szap/[tsc]zap
	docinto zap
	dodoc   apps/szap/channels.conf-dvb*

	# install docs
	dodoc   doc/HOWTO* doc/README.* driver/makedev.napi
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
	
	sed -i  "s/alps_bsru6 //" driver/modules.conf
	insinto /etc/modules.d
	newins  driver/modules.conf linuxtv-dvb
	insinto /etc/devfs.d
	newins  driver/devfsd.conf linuxtv-dvb

	insinto /usr/share/linuxtv-dvb/splash
	doins	${FILESDIR}/gentoo.mpg
}

pkg_postinst() {
	[ -x /sbin/update-modules ] && /sbin/update-modules
	[ -x /usr/bin/pkill ] && /usr/bin/pkill -HUP ^devfsd
}

pkg_postrm() {
	[ -x /sbin/update-modules ] && /sbin/update-modules
	[ -x /usr/bin/pkill ] && /usr/bin/pkill -HUP ^devfsd
}

