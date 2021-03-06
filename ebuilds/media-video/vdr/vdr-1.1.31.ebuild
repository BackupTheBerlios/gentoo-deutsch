# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdr/vdr-1.1.31.ebuild,v 1.2 2003/05/15 16:57:37 mad Exp $

IUSE="lirc rcu vdr_vfat"

S=${WORKDIR}/${P}
DESCRIPTION="The Video Disk Recorder (vanilla)"
HOMEPAGE="http://linvdr.org/"
SRC_URI="ftp://ftp.cadsoft.de/vdr/Developer/${P}.tar.bz2"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc virtual/linux-sources >=linuxdvb-1.0.0.20030510 media-libs/jpeg"

PROVIDE="virtual/vdr"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "2912s/=\ false//" menu.c
}

src_compile() {
	local myconf
	use vdr_vfat && myconf="${myconf} VFAT=1"
	use lirc && myconf="${myconf} REMOTE=LIRC"
	use rcu && myconf="${myconf} REMOTE=RCU"

	make ${myconf} || die "compile problem"
}

src_install() {
	insinto /etc/conf.d
	newins ${FILESDIR}/confd.${P} vdr
	insinto /etc/init.d
	insopts -m755
	newins ${FILESDIR}/rc.${P} vdr
	newins ${FILESDIR}/rc.vdrwatchdog vdrwatchdog
	use lirc && newins ${FILESDIR}/rc.irexec irexec 
	
	dodoc CONTRIBUTORS COPYING README INSTALL MANUAL HISTORY
	dohtml PLUGINS.html
	doman vdr.[15] 

	dolib.a libdtv/libdtv.a
	dolib.a libdtv/liblx/liblx.a
	dolib.a libdtv/libsi/libsi.a
	dolib.a libdtv/libvdr/libvdr.a

	insinto /usr/include/vdr
	doins *.h
	doins libdtv/liblx/liblx.h
	doins libdtv/libsi/si_debug_services.h
	doins libdtv/libsi/include/libsi.h
	doins libdtv/libsi/include/si_tables.h
	doins libdtv/libvdr/libvdr.h
	doins libdtv/libdtv.h

	exeinto /usr/bin
	doexe vdr
	doexe ${FILESDIR}/vdrwatchdog.sh 
	insinto /etc/vdr
	doins [a-z]*.conf*
	use lirc && doins ${FILESDIR}/irexec.conf
}

pkg_postinst() {

	einfo "Congratulations, you have just installed VDR,"
	einfo "The Digital Video Recorder. To get started you"
	einfo "should read, read, read ..."
	einfo "A good starting point seems to be:"
	einfo "http://hierling.de/~martin/vdr/ and "
	einfo "http://www.vdrportal.de/board/board.php?boardid=56"
	einfo
    ewarn "Be aware that you have to recompile ALL your"
	ewarn "vdr plugins! You can search them with"
	ewarn "epm -qa| grep \"^vdr-\""
	ewarn
}
