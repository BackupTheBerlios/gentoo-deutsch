# Copyright 2002 Alexander Holler
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/app-arch/arc/Attic/arc-5.21.ebuild,v 1.1 2002/08/15 21:57:42 holler Exp $

S=${WORKDIR}
DESCRIPTION="ARC - File Archive utility"
SRC_URI="ftp://ftp.metalab.unc.edu/pub/Linux/utils/compress/${PN}521.tar.Z"
HOMEPAGE="ftp://ftp.metalab.unc.edu/pub/Linux/utils/compress/"
SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc"

RDEPEND="virtual/glibc"
DEPEND="virtual/glibc"

src_unpack() {

        unpack ${A}
	# Change the CFLAGS
	sed -e "s/CFLAGS = -O \$(SYSTEM)/CFLAGS = ${CFLAGS} \$(SYSTEM)/" Makefile > makefile
	# Patches
	mv tmclock.c tmclock.c.orig
	sed -e 's/#if\tBSD/#if BSD\n#include <time.h>/' tmclock.c.orig > tmclock.c	
	mv arcdos.c arcdos.c.orig
	sed -e 's/struct timeval {/struct timeval_not_used {/' arcdos.c.orig > arcdos.c	

}

		
src_compile() {

        emake || die
        emake marc || die

}

src_install() {                                                                                                                  

	dobin arc marc
	dodoc Arc521.doc Arcinfo Read*
	doman arc.1

}
