# Copyright 2003 Alexander Holler
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/dev-libs/firedns/firedns-0.1.30.ebuild,v 1.2 2003/03/23 09:56:31 holler Exp $


S=${WORKDIR}/${PN}

DESCRIPTION="FireDNS Library - libfiredns is a library for handling asynchronous DNS requests."
HOMEPAGE="http://ares.penguinhosting.net/~ian/"
SRC_URI="http://ares.penguinhosting.net/~ian/projects/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~alpha ~hppa ~arm"

DEPEND="virtual/glibc
	dev-libs/firestring"

src_compile() {

	./configure
	make PREFIX="/usr" CONFDIR="/etc" || die "compile problem"

}

src_install () {

	make PREFIX="${D}usr" CONFDIR="${D}etc" install || die "install problem"
	dodoc README CREDITS

}
