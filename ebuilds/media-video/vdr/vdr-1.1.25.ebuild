# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdr/Attic/vdr-1.1.25.ebuild,v 1.3 2003/02/24 18:03:48 mad Exp $

IUSE="lirc rcu"

S=${WORKDIR}/${P}
DESCRIPTION="Video Disk Recorder"
HOMEPAGE="http://linvdr.org/"
SRC_URI="http://linvdr.org/download/vdr/Developer/${P}.tar.bz2"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc virtual/linux-sources >=linuxdvb-1.0.0_pre1-r2 media-libs/jpeg"


src_unpack() {
	unpack ${A}
}

src_compile() {
	local myconf
	use lirc && myconf="${myconf} REMOTE=LIRC"
	use rcu && myconf="${myconf} REMOTE=RCU"

	cd ${S}
	#fix wired includes
	for i in dvbdevice.c dvbdevice.h dvbosd.h eit.c remux.h ci.c channels.c; do 
		sed -i "s/#include <linux\/dvb\//#include <dvb\//" $i 
		done
	make ${myconf} || die "compile problem"
}

src_install() {
	insinto /etc/conf.d
	newins ${FILESDIR}/confd.${P} vdr
	insinto /etc/init.d
	insopts -m755
	newins ${FILESDIR}/rc.${P} vdr
	
	dodoc CONTRIBUTORS COPYING README INSTALL MANUAL HISTORY
	dohtml PLUGINS.html
	doman vdr.[15] 
	insinto /usr/include/vdr
	doins *.h
	exeinto /usr/bin
	doexe vdr
	insinto /etc/vdr
	doins *.conf
}
