# Copyright 2003 Stefan Knoblich <stefan.knoblich@t-online.de>
# Distributed under the terms of the GNU General Public License v2

S=${WORKDIR}/${P}
DESCRIPTION="Igloo FTP Client"
HOMEPAGE="http://www.littleigloo.org/"
SRC_URI="http://www.chez.com/littleigloo/files/IglooFTP-${PV}.src.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

RDEPEND="virtual/x11
	 =x11-libs/gtk+-1.2*"
DEPEND="${RDEPEND}"

src_unpack() {

    unpack ${A}

    # apply (necessary) bugfix
    cd ${S}
    patch -p1 < ${FILESDIR}/fix-IglooFTP-${PV}.diff

    cd ${S}/src

    # comment DESTDIR, will be set manually later...
    cat Makefile | sed -e "s/^DESTDIR/#DESTDIR/" > Makefile.tmp
    mv -f Makefile.tmp Makefile

    # set cflags
    cat Makefile | sed -e "s/^C_FLAGS.*/C_FLAGS\ =\ ${CFLAGS}/" > Makefile.tmp
    mv -f Makefile.tmp Makefile
}

src_compile() {

    cd ${S}/src
    emake DESTDIR="/usr" || die
}

src_install() {

    cd ${S}/src
    mkdir -p ${D}/usr/share    
    mkdir -p ${D}/usr/bin
    einstall DESTDIR="${D}/usr" || die

    # install docs
    cd ${S}
    dodoc AUTHORS COPYRIGHT ChangeLog INSTALL IglooFTP.lsm LICENSE NEWS README
}


