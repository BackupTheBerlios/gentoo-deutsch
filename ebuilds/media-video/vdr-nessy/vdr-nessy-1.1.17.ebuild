# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdr-nessy/vdr-nessy-1.1.17.ebuild,v 1.1 2003/04/22 18:26:22 mad Exp $

IUSE="lirc rcu vdr_vfat"


S=${WORKDIR}/VDR-Easter-Pre-Release/VDR

DESCRIPTION="The Video Disk Recorder (nessy)"
HOMEPAGE="http://linvdr.org/"
SRC_URI="http://hotchevy.future.easyspace.com/vdr/progs/nessy/VDR-Easter-Pre-Release.tar.bz2"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	virtual/linux-sources
	>=linuxdvb-1.0.0_pre1-r3
	media-libs/jpeg"

PROVIDE="virtual/vdr"

src_unpack() {
	unpack ${A}
	cd ${S}
	
	# beauty
	sed -i "s/\$(INCLUDES)//" Makefile 
	sed -i "s/\(VDRVERSION\ \"1\.1\.[0-9][0-9]\)\"/\1-nessy\"/" config.h
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
	insinto /etc/vdr
	rm Make.config.template
	doins [a-z]*.conf*
}

pkg_postinst() {

	einfo
	einfo "Congratulations, you have just installed VDR,"
	einfo "The Digital Video Recorder. To get started you"
	einfo "should read, read, read ..."
	einfo "try http://hierling.de/~martin/vdr/"
	einfo 
	ewarn "Be aware that you have to recompile ALL your"
	ewarn "vdr plugins! You can search them with"
	ewarn "epm -qa| grep \"^vdr-\""
	ewarn
}
