
DESCRIPTION="Port of the Emule to Linux"
HOMEPAGE="http://lmule.sourceforge.net/"
SRC_URI="mirror://sourceforge/lmule/lmule-${PV}.tar.gz"
S=${WORKDIR}/${P}

IUSE="gtk"
SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"

inherit flag-o-matic eutils
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
    local myconf=""

    myconf="--prefix=/usr --with-wx-config=/usr/bin/wx-config"

    use nls || myconf="${myconf} --disable-nls"

    econf ${myconf} || die
    emake || die
}

src_install() {
    emake install DESTDIR=${D} || die

    dodoc AUTHORS ABOUT-NLS COPYING ChangeLog README INSTALL TODO NEWS docs/*
}
