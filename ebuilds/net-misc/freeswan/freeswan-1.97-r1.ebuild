# Copyright 2002 Alexander Holler
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-misc/freeswan/Attic/freeswan-1.97-r1.ebuild,v 1.2 2002/07/06 19:29:34 holler Exp $

S=${WORKDIR}/${P}
DESCRIPTION="FreeS/WAN IPSec Userspace Utilities with X.509 Patches"
SRC_URI="ftp://ftp.xs4all.nl/pub/crypto/freeswan/${P}.tar.gz
	http://www.strongsec.com/freeswan/x509patch-0.9.12-${P}.tar.gz"

HOMEPAGE="http://www.freeswan.org"
DEPEND="virtual/glibc
        virtual/linux-sources"
LICENSE="GPL-2"
RDEPEND=""
SLOT="0"

pkg_setup() {
    [ -d /usr/src/linux/net/ipsec ] || {
		echo You need to have the crypto-enabled version of Gentoo Sources
		echo with a symlink to it in /usr/src/linux in order to have IPSec
		echo kernel compatibility.  Please emerge sys-kernel/crypto-sources, 
		echo compile an IPSec-enabled kernel and attempt this ebuild again.
		exit 1
	}
}

src_compile() {

    patch -p1 < ${FILESDIR}/freeswan-libdes-location.patch || die
    patch -p1 < ${WORKDIR}/x509patch-0.9.12-${P}/freeswan.diff
	make	 						   	\
		DESTDIR=${D}					\
		USERCOMPILE="${CFLAGS}"			\
		FINALCONFDIR=/etc/ipsec			\
		INC_RCDEFAULT=/etc/init.d		\
		INC_USRLOCAL=/usr				\
		INC_MANDIR=share/man			\
		confcheck programs || die
}

src_install () {
	
	# try make prefix=${D}/usr install

	make 								\
		DESTDIR=${D}					\
		USERCOMPILE="${CFLAGS}"			\
		FINALCONFDIR=/etc/ipsec			\
		INC_RCDEFAULT=/etc/init.d		\
		INC_USRLOCAL=/usr				\
		INC_MANDIR=share/man			\
		install || die

	newdoc ${WORKDIR}/x509patch-0.9.12-${P}/README README.x509
	newdoc ${WORKDIR}/x509patch-0.9.12-${P}/CHANGES CHANGES.x509
	newdoc ${WORKDIR}/x509patch-0.9.12-${P}/ipsec.secrets.template ipsec.secrets.x509
	dodoc INSTALL COPYING CREDITS BUGS CHANGES README doc/*
}

