# Copyright 2003 Sascha Rusch
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="The Notebook for Tuxfreaks"
SRC_URI="http://www.tifskom.de/tux/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.tuxcards.de"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=x11-libs/qt-3"
RDEPEND=">=x11-libs/qt-3"

src_compile() {
    cd ${S}; epatch ${FILESDIR}/${P}.patch
    make || die
}

src_install() {
    make INSTALL_ROOT=${D} install || die
}
