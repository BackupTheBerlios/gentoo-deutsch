# Copyright 2003 Alexander Holler
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/dev-libs/firestring/firestring-0.1.23.ebuild,v 1.1 2003/03/21 17:50:34 holler Exp $


S=${WORKDIR}/${PN}

DESCRIPTION="FireString Library - libfirestring is a string handling library that provides
maximum length aware string handling functions to programs."
HOMEPAGE="http://ares.penguinhosting.net/~ian/"
SRC_URI="http://ares.penguinhosting.net/~ian/projects/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~alpha ~hppa ~arm"

DEPEND="virtual/glibc"

src_compile() {

	./configure
	make PREFIX="/usr" CONFDIR="/etc" || die "compile problem"

}

src_install () {

	make PREFIX="${D}usr" CONFDIR="${D}etc" install || die "install problem"
	dodoc README

}
