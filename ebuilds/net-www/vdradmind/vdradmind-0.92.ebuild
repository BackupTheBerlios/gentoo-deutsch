# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-www/vdradmind/vdradmind-0.92.ebuild,v 1.1 2003/07/07 17:33:20 mad Exp $

IUSE=""

S=${WORKDIR}/vdradmin-0.92
DESCRIPTION="WWW Admin for the Video Disk Recorder"
HOMEPAGE="http://linvdr.org/"
SRC_URI="http://linvdr.org/download/vdradmin/vdradmin-0.92.tar.gz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="dev-lang/perl
		dev-perl/Compress-Zlib
		media-video/vdr"

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

