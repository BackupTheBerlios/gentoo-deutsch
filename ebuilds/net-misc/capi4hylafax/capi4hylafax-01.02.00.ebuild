# Copyright 2002 Alexander Holler
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-misc/capi4hylafax/Attic/capi4hylafax-01.02.00.ebuild,v 1.1 2002/07/18 21:53:48 holler Exp $

S=${WORKDIR}/${P}
DESCRIPTION="CAPI4HylaFAX - CAPI driver for HylaFAX"
SRC_URI="ftp://ftp.avm.de/cardware/fritzcrd.pci/linux/${P}.tar.gz"
HOMEPAGE="http://www.avm.de/"
SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND="virtual/glibc
	media-libs/tiff
	net-dialup/capi4k-utils"

DEPEND="virtual/glibc
	media-libs/tiff
	net-dialup/capi4k-utils
	sys-devel/automake"

src_compile() {

	./configure || die
	emake || die

}

src_install() {															 

	dobin src/faxrecv/c2faxrecv src/faxsend/c2faxsend
#	./install -s -p ${D}var/spool/hylafax -d ${D}usr/bin
	dodoc AUTHORS COPYING Liesmich* Readme_C* sample* Generate*
	insinto /var/spool/hylafax/etc
	doins ${FILESDIR}/config.faxCAPI

}
