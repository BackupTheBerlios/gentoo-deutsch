# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/dev-libs/xmlrpc-c/xmlrpc-c-0.9.10.ebuild,v 1.1 2004/04/15 19:21:26 martini Exp $

inherit eutils

DESCRIPTION="A lightweigt RPC library based on XML and HTTP"
SRC_URI="mirror://sourceforge/xmlrpc-c/${P}.tar.gz"
HOMEPAGE="http://xmlrpc-c.sourceforge.net/"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc
	net-libs/libwww"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gentoo-0.9.10.patch || die "patching failed !" 
}

src_install() {
	make prefix=${D}/usr mandir=${D}/usr/share install || die "make failed !"
}
