# Copyright 2003 Sascha Rusch
# Distributed under the terms of the GNU General Public License v2

S=${WORKDIR}/sfftobmp_2_2/
DESCRIPTION="The Notebook for Tuxfreaks"
SRC_URI="http://heanet.dl.sourceforge.net/sourceforge/sfftools/sfftobmp_2_2.tgz"
HOMEPAGE="http://sfftools.sourceforge.net/sfftobmp.html"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

src_compile() {
    cd ${S}
    emake
}

src_install() {
    exeinto /usr/bin
    doexe ${S}/exe/sfftobmp
}
