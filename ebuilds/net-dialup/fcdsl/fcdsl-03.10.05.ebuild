# Copyright 2003 Alexander Holler
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-dialup/fcdsl/fcdsl-03.10.05.ebuild,v 1.1 2003/04/09 06:06:53 holler Exp $

DESCRIPTION="CAPI4Linux driver for AVM Fritz!Card DSL"
HOMEPAGE="http://www.avm.de/"
S="${WORKDIR}/fritz"
SRC_URI="ftp://ftp.avm.de/cardware/fritzcrd.dsl/linux/suse.81/fcdsl-suse8.1-${PV}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86"
DEPEND="virtual/linux-sources
        net-dialup/capi4k-utils"
RDEPEND="net-dialup/capi4k-utils"
IUSE=""

src_unpack() {

        unpack ${A}
        cd ${S}
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

	insinto /etc/modules.d
	doins ${FILESDIR}/fcdsl
	insinto /etc/drdsl
	doins drdsl.ini
	insinto /etc
	newins ${FILESDIR}/dsl.conf capi.conf
	insinto /usr/lib/isdn
	doins fdslbase.bin
	exeinto /usr/sbin
	doexe drdsl
        insinto /lib/modules/`uname -r`/misc
        doins src.drv/fcdsl.o
	dodoc CAPI* compile* license.bin release.txt src.sys/capi_modules.txt
	dohtml install_passive-*.html

}

pkg_postinst() {

	einfo "******************************************************************"
	einfo "* Read 4.2.6 of /usr/share/doc/${P}/html/install*.html *"
	einfo "* In short: you have to modify /etc/modules.d/fcdsl with the     *"
	einfo "* options drdsl will give you, e.g.:                             *"
	einfo "*   depmod -ae                                                   *"
	einfo "*   capiinit start                                               *"
	einfo "*   drdsl -n                                                     *"
	einfo "*   vim /etc/modules.d/fcdsl                                     *"
	einfo "*   update-modules                                               *"
	einfo "* After that do a 'man capiplugin'.                              *"
	einfo "******************************************************************"

}
