# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-analyzer/flow-tools/flow-tools-0.67.ebuild,v 1.1 2004/07/14 18:17:48 mad Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Flow-tools is a software package for collecting and processing NetFlow data from Cisco and Juniper routers."
HOMEPAGE="http://www.splintered.net/sw/flow-tools/"
SRC_URI="ftp://ftp.eng.oar.net/pub/flow-tools/flow-tools-${PV}.tar.gz"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

PROVIDE=""

src_unpack() {
	unpack ${A}
}

src_compile() {
	local myconf
	use mysql && myconf="${myconf} --with-mysql"

		cd ${S}
		./configure \
			--prefix=/usr \
			--mandir=/usr/share/man \
			--infodir=/usr/share/info \
			--sysconfdir=/etc/flow-tools \
			--localstatedir=/etc/flow-tools \
			${myconf} || die

	aclocal
	make || die "compile problem"
}

src_install() {
	make prefix=${D}/usr datadir=${D}/usr/share mandir=${D}/usr/share/man \
		localstatedir=${D}/etc/flow-tools libdir=${D}/usr/lib install || die
	insinto /etc/init.d
	insopts -m0755
	newins ${FILESDIR}/rc.0.67 flow-tools
	dodir /var/netflows


}

