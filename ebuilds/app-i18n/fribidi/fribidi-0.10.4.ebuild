# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2


S=${WORKDIR}/${P}/
DESCRIPTION="FriBidi is a free library that implements the Unicode Bidirectional Algorithm"
SRC_URI="http://download.sourceforge.net/fribidi/${P}.tar.bz2"
HOMEPAGE="http://sourceforge.net/projects/fribidi"
KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"
DEPEND=""

src_install () {
	make DESTDIR=${D} install || die
}