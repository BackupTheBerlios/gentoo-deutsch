# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-www/netscape-plugger/netscape-plugger-5.0.ebuild,v 1.1 2003/10/03 23:59:16 ripclaw Exp $

inherit nsplugins

MYP=${P#netscape-}
S=${WORKDIR}/plugger-5.0
DESCRIPTION="Plugger 5.0 streaming media plugin"
SRC_URI="http://fredrik.hubbe.net/plugger/"${MYP}.tar.gz
HOMEPAGE="http://fredrik.hubbe.net/plugger.html"
SLOT="0"
KEYWORDS="x86 -ppc ~sparc "
LICENSE="GPL-2"
DEPEND="virtual/glibc"
RDEPEND="!virtual/plugger"
PROVIDE="virtual/plugger"
IUSE=""

src_compile() {
    cd ${S}
    make linux
}

src_install() {
	cd ${S}
	dodir /opt/netscape/plugins /etc
	insinto /opt/netscape/plugins
	doins plugger.so
	insinto /etc
	doins pluggerrc
	dodoc README COPYING
	doman plugger.7
	insinto /usr/bin
	dobin plugger-5.0
	dosym plugger-5.0 /usr/bin/plugger

	inst_plugin /opt/netscape/plugins/plugger.so

	dodoc README
}
