# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-gfx/dcraw/dcraw-5.72.ebuild,v 1.1 2004/04/06 15:20:42 fow0ryl Exp $

IUSE=""
S=${WORKDIR}
DESCRIPTION="Raw Digital Photo Decoder"
HOMEPAGE="http://www.cybercom.net/~dcoffin/dcraw/"
SRC_URI="http://www.cybercom.net/~dcoffin/dcraw/dcraw.c
	http://www.cybercom.net/~dcoffin/dcraw/dcraw.1
	"

LICENSE=""
KEYWORDS="x86"


src_unpack() {
	cd ${S}
	cp ${DISTDIR}/dcraw.c dcraw.c
	cp ${DISTDIR}/dcraw.1 dcraw.1
}

src_compile() {
	cd ${S}
	gcc -o dcraw -O3 dcraw.c -lm -ljpeg
}

src_install() {
	exeinto /usr/bin
	doexe dcraw
	
	dodoc dcraw.1
}
