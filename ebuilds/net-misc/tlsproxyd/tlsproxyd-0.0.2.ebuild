# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.8 2002/05/30 01:54:49 sandymac Exp

# Source Maintainer:	Chris Lightfoot <chris@ex-parrot.com>
# .ebuild Maintainer:  	Martin Klebermass <klebermass@LimTec.de>
S=${WORKDIR}/${P}
DESCRIPTION="An TLS Tunneling Tool."
SRC_URI="http://www.ex-parrot.com/~chris/tlsproxyd/${P}.tar.gz"
HOMEPAGE="http://www.ex-parrot.com/~chris/tlsproxyd/"

LICENSE="GPL-2"

DEPEND="    virtual/glibc
			>=dev-libs/openssl-0.9.6
			"

src_compile() {
	emake || die
}

src_install () {

	dosbin tlsproxyd
	doman tlsproxyd.8
	dodir /etc/tlsproxyd
}
pkg_postinst() {
	einfo "Read the tlsproxyd MAN-Page"
	einfo "Please create /etc/tlsproxyd/tlsproxyd.conf to fit your Configuration"
	einfo "init Script not included in this distribution. Shouldnt be to hard to create one on your own!"
}				
