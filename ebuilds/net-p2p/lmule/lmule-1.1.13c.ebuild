# Copyright 2003 Stefan Knoblich
# Distributed under the terms of the GNU General Public License, v2 or later

DESCRIPTION="Port of the Emule to Linux"
HOMEPAGE="http://lmule.sourceforge.net/"
SRC_URI="mirror://sourceforge/lmule/lmule-${PV}.tar.gz"
S=${WORKDIR}/${P}

IUSE="gtk"
SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

# replace "-O3" because lmule doesn't like it
inherit flag-o-matic
replace-flags "-O3" "-O2"

RDEPEND=">=x11-libs/wxGTK-2.4.0
	 >=sys-libs/zlib-1.1.4
	 >=sys-devel/gettext-0.11.5
	 >=dev-libs/expat-1.95"

DEPEND="${RDEPEND}"

src_unpack() {

    unpack ${A}
}


src_compile() {

    local myconf

    myconf="--prefix=/usr --with-wx-config=/usr/bin/wx-config"

    use nls || myconf="${myconf} --disable-nls"

    econf ${myconf} || die
    emake || die
}


src_install() {

    emake install DESTDIR=${D} || die

    dodoc AUTHORS ABOUT-NLS COPYING ChangeLog README INSTALL TODO NEWS docs/*
}


pkg_postinst() {

    ewarn "Be sure to have your router/firewall configured properly!"
    ewarn "See http://www.emule-project.net/faq/ports.htm for a list of ports"
    ewarn "that have to be opened for lmule to work right"
}
