# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdr/Attic/vdr-1.1.25-r1.ebuild,v 1.1 2003/02/27 18:35:25 mad Exp $

IUSE="lirc rcu"

S=${WORKDIR}/${P}
DESCRIPTION="The Video Disk Recorder"
HOMEPAGE="http://linvdr.org/"
SRC_URI="http://linvdr.org/download/vdr/Developer/${P}.tar.bz2"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc virtual/linux-sources >=linuxdvb-1.0.0_pre1-r3 media-libs/jpeg"


src_unpack() {
	unpack ${A}
}

src_compile() {
	local myconf
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
	insinto /usr/include/vdr
	doins *.h
	exeinto /usr/bin
	doexe vdr
	insinto /etc/vdr
	doins *.conf
}
