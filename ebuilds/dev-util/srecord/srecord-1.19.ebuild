# Copyright 2004 Stefan Nickl <snickl@snickl.freaks.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/dev-util/srecord/srecord-1.19.ebuild,v 1.1 2004/01/20 14:49:22 snickl Exp $

inherit eutils flag-o-matic

IUSE="doc"

DESCRIPTION="A collection of powerful tools for manipulating EPROM load files"
HOMEPAGE="http://srecord.sourceforge.net/"
SRC_URI="mirror://sourceforge/srecord/${P}.tar.gz
         doc? http://srecord.sourceforge.net/${P}.pdf"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"


DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc README LICENSE MANIFEST etc/srecord.lsm
	if use doc
	then
		dodoc ${DISTDIR}/${P}.pdf
	fi
}
