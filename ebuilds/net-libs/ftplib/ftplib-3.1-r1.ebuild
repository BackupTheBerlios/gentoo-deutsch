# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: 

S=${WORKDIR}/${P}
DESCRIPTION="ftplib is a set of routines that implement the FTP protocol"
HOMEPAGE="http://nbpfaus.net/~pfau/ftplib/"
SRC_URI="http://www.nbpfaus.net/~pfau/ftplib/ftplib-3.1-src.tar.gz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/ftplib-3.1-1.patch
}

src_compile() {
	cd ${S}/linux
	make all || die "compile problem"
}

src_install() {
	cd ${S}/linux
	exeinto /usr/local/bin
	newexe ${S}/linux/qftp qftp
	insinto /usr/local/lib
	insopts -m0755
	doins libftp.so.3.1 
	insinto /usr/local/include
	insopts -m0644
	doins ftplib.h 
	cd ${D}/usr/local/lib
	ln -s libftp.so.3.1 libftp.so.3
	ln -s libftp.so.3.1 libftp.so
	cd ${S}
	dodoc CHANGES NOTES README.ftplib_v3.1 README.qftp RFC959.txt
}
