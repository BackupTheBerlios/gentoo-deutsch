# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-wireless/airsnort/airsnort-0.2.3c.ebuild,v 1.1 2004/01/21 14:40:03 rootshell Exp $

S=${WORKDIR}/${P}
DESCRIPTION="802.11b Wireless Packet Sniffer/WEP Cracker"
HOMEPAGE="http://airsnort.shmoo.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=sys-devel/autoconf-2.13
	=x11-libs/gtk+-2*
	>=net-libs/libpcap-0.7.1
	>=gnome-base/libgnomeui-2*
	pcmcia? ( >=sys-apps/pcmcia-cs-3.1.33 )"

src_compile() {
	./autogen.sh \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./autogen failed"
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README README.decrypt Authors ChangeLog TODO
}
pkg_postinst() {
	einfo "Make sure to emerge linux-wlan-ng if you want support"
	einfo "for Prism2 based cards in airsnort."
}
