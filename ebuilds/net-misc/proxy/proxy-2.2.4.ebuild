# Copyright 2002 Alexander Holler
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-misc/proxy/proxy-2.2.4.ebuild,v 1.1 2002/07/17 15:44:04 holler Exp $

DESCRIPTION="Proxy - Simple port redirector (nice for port forwarding without iptables)"
HOMEPAGE="http://proxy.sourceforge.net/"

S=${WORKDIR}/${P}
SRC_URI="http://download.sourceforge.net/proxy/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="1"

RDEPEND="virtual/glibc"
DEPEND="virtual/glibc"

src_compile() {

	mv Makefile Makefile.orig
	cat Makefile.orig | sed "s/-Wall -O6/${CFLAGS}/" >Makefile
	emake || die "compile problem"

}

src_install () {

	dobin proxy
	dodoc INSTALL LICENSE README proxy.filters_example
	dodoc ${FILESDIR}/gentoo_init.d_vncproxy_example
	
}

pkg_postinst() {

	einfo "*************************************************************"
	einfo "* NOTE: check                                               *"
	einfo "* /usr/share/doc/${P}/gentoo_init.d_vncproxy_example *"
	einfo "* for an example startup-script.                            *"
	einfo "*************************************************************"

}
