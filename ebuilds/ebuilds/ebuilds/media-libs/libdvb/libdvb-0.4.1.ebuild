# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/ebuilds/ebuilds/media-libs/libdvb/Attic/libdvb-0.4.1.ebuild,v 1.1 2003/08/22 15:27:29 fow0ryl Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="LIBDVB - DVB library"
HOMEPAGE="http://www.metzlerbros.org/dvb/"
SRC_URI="http://www.metzlerbros.org/dvb/${P}.tar.gz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND="media-video/linuxtv-dvb
		virtual/linux-sources"
	
src_unpack() {
	unpack ${A} || die "unpack failed"
}

src_compile() {
	make || die "compile problem"
}

src_install() {
	dolib.a libdvb.a
	dolib.a libdvbci.a
	dodoc README astrarc hotbirdrc
	insinto /usr/include/libdvb/
	doins *.h*
}
