# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-libs/libdvb/Attic/libdvb-0.2.3.ebuild,v 1.1 2003/04/26 12:15:06 mad Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="LIBDVB - DVB library"
HOMEPAGE="http://www.metzlerbros.org/dvb/"
SRC_URI="http://www.metzlerbros.org/dvb/${P}.tar.gz"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL"

DEPEND="media-video/linuxdvb virtual/linux-sources"
	
src_unpack() {
	unpack ${A} || die "unpack failed"
}

src_compile() {
	make || die "compile problem"
}

src_install() {
	dolib.a libdvb.a
	dodoc README
	insinto /usr/include/libdvb/
	doins *.h*
}
