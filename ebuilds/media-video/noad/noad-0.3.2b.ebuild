# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/noad/noad-0.3.2b.ebuild,v 1.1 2004/02/15 12:49:26 mad Exp $


S=${WORKDIR}/${P}
DESCRIPTION="removes advertisings from vdr recordings"
HOMEPAGE="http://http://www.rgob.com/members/theNoad/"
SRC_URI="http://www.freepgs.com/noad/noad-0.3.2b.tgz"


KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="media-libs/libmpeg2  
		media-video/vdr
		"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "/^INCLUDES/s/local\///" Makefile 
}

src_compile() {

	make || die "compile problem vdr"

}

src_install() {

	dodoc COPYING README INSTALL HISTORY
	# example scripts are installed as dokumentation
	dodoc allnewnoad allnoad allnoadnice clearlogos noadifnew stat2html

	exeinto /usr/bin
	doexe noad

}
