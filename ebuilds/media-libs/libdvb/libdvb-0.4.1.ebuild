# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-libs/libdvb/libdvb-0.4.1.ebuild,v 1.2 2003/10/28 14:02:31 martini Exp $

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
	dodoc README
	dodoc samplerc/*
	insinto /usr/include/libdvb/
	doins include/*
}
