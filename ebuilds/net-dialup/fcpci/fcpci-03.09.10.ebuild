# Copyright 2002 Alexander Holler
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-dialup/fcpci/Attic/fcpci-03.09.10.ebuild,v 1.1 2002/07/18 18:30:48 holler Exp $

DESCRIPTION="CAPI4Linux drivers for AVM Fritz!Card PCI"
HOMEPAGE="http://www.avm.de/"

#S=${WORKDIR}/${P}
S=${WORKDIR}/fritz
SRC_URI="ftp://ftp.avm.de/cardware/fritzcrd.pci/linux/fcpci-suse8.0-${PV}.tar.gz"
LICENSE="LGPL-2"
SLOT="1"

DEPEND="virtual/linux-sources"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 <${FILESDIR}/tools.c.diff
	krnlver=`uname -r`
	mv src.drv/makefile src.drv/makefile.orig
	cat src.drv/makefile.orig | sed -e "s/\`uname -r\`/${krnlver}/" \
	    -e 's/-DMODULE/-DMODULE -DMODVERSIONS/' \
	    -e "s:(DEFINES) -O2:(DEFINES) ${CFLAGS} -include /lib/modules/${krnlver}/build/include/linux/modversions.h:" \
	    >src.drv/makefile

}

src_compile() {

	emake || die "compile problem"

}

src_install () {

	insinto /lib/modules/`uname -r`/misc
	doins src.drv/fcpci.o
	dodoc CAPI* compile* license.bin pci.conf
	dohtml install_passive-d.html

}
