# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/ebuilds/ebuilds/net-dns/rbldnsd/Attic/rbldnsd-0.97b.ebuild,v 1.1 2003/08/22 15:27:27 fow0ryl Exp $

DESCRIPTION="Small Daemon for DNSBLs"
HOMEPAGE="http://www.corpit.ru/mjt/rbldnsd.html"
SRC_URI="http://www.corpit.ru/mjt/rbldnsd/rbldnsd_0.97b.tar.gz"


KEYWORDS="~x86 ~sparc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"


src_unpack() {
	unpack ${A}
}

src_compile() {
	make
}

src_install() {
	dosbin	rbldnsd
	dobin	*.pl
	dodoc CHANGES* NEWS TODO
	doman rbldnsd.8 
	dolib librbldnsd.a
	dodir /var/dnsbl/
	touch ${D}var/dnsbl/.keep
	fowners named /var/dnsbl/
	insinto /etc/conf.d
	newins ${FILESDIR}/confd rbldnsd
	insinto /etc/init.d
	newins ${FILESDIR}/rc rbldnsd
	fperms 755 /etc/init.d/rbldnsd
}
