# Copyright 2003 Alexander Holler
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-dialup/fcpci/fcpci-03.10.02.ebuild,v 1.2 2003/02/01 23:55:03 wpbasti Exp $

DESCRIPTION="CAPI4Linux drivers for AVM Fritz!Card PCI"
HOMEPAGE="http://www.avm.de/"
S="${WORKDIR}/fritz"
SRC_URI="ftp://ftp.avm.de/cardware/fritzcrd.pci/linux/suse.81/fcpci-suse8.1-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
DEPEND="virtual/linux-sources"

src_unpack() {

        unpack ${A}
        cd ${S}

}

src_compile() {

        emake || die "compile problem"

}

src_install () {

        insinto /lib/modules/`uname -r`/misc
        doins src.drv/fcpci.o
        dodoc CAPI* src.sys/capi* release.txt
        dohtml install_passive*.html
        insinto /etc
        newins ${FILESDIR}/capi.conf capi.conf

}

 
