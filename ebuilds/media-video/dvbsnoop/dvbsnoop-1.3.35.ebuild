# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Matthias Schwarzott <zzam@gmx.de>
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/dvbsnoop/dvbsnoop-1.3.35.ebuild,v 1.1 2004/08/08 22:52:16 austriancoder Exp $

DESCRIPTION="DVB/MPEG stream analyzer program"
SRC_URI="mirror://sourceforge/dvbsnoop/${P}.tar.gz"
HOMEPAGE="http://dvbsnoop.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="~x86"
DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	sed -i -e 's/^.*FE_CAN_CLEAN_SETUP.*$//' ${S}/src/dvb_api/fe_misc.c
}

src_compile() {

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README
}
