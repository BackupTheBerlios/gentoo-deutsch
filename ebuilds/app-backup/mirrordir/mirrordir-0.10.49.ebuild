# Copyright 2002 Jan Gehring
# Distributed under the terms of the GNU General Public License v2
# $Header: 


S="${WORKDIR}/${P}"
DESCRIPTION="Mirroring tool"
SRC_URI="http://mirrordir.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://mirrordir.sf.net"
DEPEND="virtual/glibc
        sys-libs/zlib"
REDEPEND="virtual/glibc"

LICENSE="GPL-2"
SLOT="0"

src_unpack() {
    unpack ${A}
#    einfo "huhu: ${S}"
#    die
    einfo "Patching pam/Makefile.am"
    cp ${S}/pam/Makefile.am ${S}/pam/Makefile.am.orig
    sed 's:/etc:${S}/etc:' ${S}/pam/Makefile.am.orig > ${S}/pam/Makefile.am
    einfo "Patching pam/Makefile.in"
    cp ${S}/pam/Makefile.in ${S}/pam/Makefile.in.orig
    sed 's:/etc:${S}/etc:' ${S}/pam/Makefile.in.orig > ${S}/pam/Makefile.in
}

src_compile() {
    ./configure \
	--quiet \
	--host=${CHOST} \
	--mandir=/usr/share/man \
	--infodir=/usr/share/info \
	--prefix=/usr || die "bad ./configure"

    emake || die "compile problem"
}

src_install() {
    einstall || die
#    make DESTDIR=${D} install || die
#    make install || die
}
