# Copyright 2003 Stefan Knoblich <stefan.knoblich@t-online.de>
# Distributed under the terms of the GNU General Public License v2
#

DESCRIPTION="Yet another free Raytracer"
SRC_URI="http://www.coala.uniovi.es/~jandro/noname/downloads/${P}.tar.gz"
HOMEPAGE="http://www.coala.uniovi.es/~jandro/noname/"
S=${WORKDIR}/${P}

SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"

RDEPEND="virtual/glibc
         >=media-libs/jpeg-6b
         >=sys-libs/zlib-1.1"

DEPEND="${RDEPEND}
	sys-devel/libtool"

src_compile() {

    local myconf=""
    
    myconf="${myconf} --prefix=/usr --sysconfdir=/etc"
    
    econf ${myconf} || die
    emake || die
}

src_install() {

    dodoc INSTALL AUTHORS COPYING ChangeLog LICENSE NEWS README doc/*

    einstall || die
}
