# Copyright 2002 Alexander Holler
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-dialup/capi4k-utils/Attic/capi4k-utils-20020701.ebuild,v 1.2 2002/07/18 21:53:48 holler Exp $

MY_P=capi4k-utils-2002-07-01
S=${WORKDIR}/${PN}
DESCRIPTION="Capi4Linux Utils"
SRC_URI="ftp://ftp.in-berlin.de/pub/capi4linux/${MY_P}.tar.gz"
HOMEPAGE="ftp://ftp-in-berlin.de/pub/capi4linux.de/"
SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND="virtual/glibc"

DEPEND="virtual/linux-sources
	virtual/glibc
	sys-devel/automake"

src_compile() {

	emake subconfig || die
	emake || die

}

src_install() {															 

	dodir /dev
	make install DESTDIR=${D} || die
	rm -rf ${D}dev
	newdoc rcapid/README README.rcapid
	newdoc pppdcapiplugin/README README.pppdcapiplugin
	docinto examples.pppdcapiplugin; dodoc pppdcapiplugin/examples/*

}
