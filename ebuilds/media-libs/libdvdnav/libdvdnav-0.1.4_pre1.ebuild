# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-libs/libdvdnav/Attic/libdvdnav-0.1.4_pre1.ebuild,v 1.1 2003/02/19 21:00:59 mad Exp $

S=${WORKDIR}/libdvdnav-0.1.4note2-vdr-as2
DESCRIPTION="Library for DVD navigation tools (patched Version)."
HOMEPAGE="http://sourceforge.net/projects/dvd/"
SRC_URI="http://www.cs.uni-magdeburg.de/~aschultz/dvd/libdvdnav-0.1.4note2-vdr-as2.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="media-libs/libdvdread"

src_unpack() {

	unpack ${A}
	cd ${S}/src

}

src_compile() {

	econf || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING INSTALL NEWS README
}

pkg_postinst() {
	einfo
	einfo "Please remove old versions of libdvdnav manually,"
	einfo "having multiple versions installed can cause problems."
	einfo
}
