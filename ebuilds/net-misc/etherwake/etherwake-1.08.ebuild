# Copyright 2003 Alexander Holler
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-misc/etherwake/Attic/etherwake-1.08.ebuild,v 1.2 2003/04/26 15:45:17 holler Exp $

DESCRIPTION="This program generates and transmits a Wake-On-LAN (WOL) \"Magic Packet\", used for restarting machines that have been soft-powered-down (ACPI D3-warm state)."
SRC_URI="ftp://ftp.scyld.com/pub/diag/ether-wake.c
		ftp://ftp.scyld.com/pub/diag/etherwake.8"
HOMEPAGE="http://www.scyld.com/expert/wake-on-lan.html"
SLOT="0"
LICENSE="GPL"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND=""

src_compile() {
	gcc ${CFLAGS} -o etherwake ${DISTDIR}/ether-wake.c
}

src_install() {                               
	dosbin etherwake
	doman ${DISTDIR}/etherwake.8
	dodoc ${FILESDIR}/readme
}
