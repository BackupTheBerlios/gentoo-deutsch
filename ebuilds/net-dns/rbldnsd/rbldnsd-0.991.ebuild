# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-dns/rbldnsd/rbldnsd-0.991.ebuild,v 1.1 2004/01/31 14:59:19 mad Exp $

DESCRIPTION="Small Daemon for DNSBLs"
HOMEPAGE="http://www.corpit.ru/mjt/rbldnsd.html"
SRC_URI="http://www.corpit.ru/mjt/rbldnsd/${PN}_${PV}.tar.gz"
IUSE=""

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"


src_unpack() {
	unpack ${PN}_${PV}.tar.gz
}

src_compile() {
	./configure
	emake
}

src_install() {
	dosbin	rbldnsd
	dodoc CHANGES* NEWS TODO
	doman rbldnsd.8
	dolib librbldnsd.a
	dodir /var/rbldnsd/
	touch ${D}var/rbldnsd/.keep
	fowners named:named /var/rbldnsd/
	insinto /etc/conf.d
	newins ${FILESDIR}/confd rbldnsd
	insinto /etc/init.d
	newins ${FILESDIR}/rc rbldnsd
	fperms 755 /etc/init.d/rbldnsd
}
