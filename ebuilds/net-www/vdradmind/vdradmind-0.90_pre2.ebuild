# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-www/vdradmind/Attic/vdradmind-0.90_pre2.ebuild,v 1.1 2003/05/30 15:01:28 mad Exp $

IUSE=""

S=${WORKDIR}/vdradmin-0.90-pre2
DESCRIPTION="WWW Admin for the Video disk Recorder"
HOMEPAGE="http://linvdr.org/"
SRC_URI="http://linvdr.org/download/vdradmin/vdradmin-0.90-pre2.tar.gz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="dev-lang/perl
		dev-perl/Compress-Zlib
		virtual/vdr"

RESTRICT="nostrip"


src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "45s/0/1/" vdradmind.pl
}

src_compile() {
	einfo "no need to compile"
}

src_install() {
	#cp ${FILESDIR}/Makefile ${S}
	make DESTDIR=${D} install
	insinto /etc/init.d
	insopts -m755
	newins ${FILESDIR}/rc.vdradmind vdradmind
}

pkg_postinst() {
	einfo
	einfo "start \"vdradmind.pl -c\" to setup ..."
	einfo
}

