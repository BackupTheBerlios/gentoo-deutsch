# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/noad/noad-0.4.1.ebuild,v 1.2 2004/03/30 18:40:17 austriancoder Exp $


S=${WORKDIR}/${P}
DESCRIPTION="removes advertisings from vdr recordings"
HOMEPAGE="http://http://www.rgob.com/members/theNoad/"
SRC_URI="http://www.freepgs.com/noad/noad-${PV}.tar.bz2"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="media-libs/libmpeg2  
		media-video/vdr
		"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {

	./configure --with-mpeginclude=/usr/include/mpeg2dec
	make || die "compile problem vdr"

}

src_install() {

	dodoc COPYING README INSTALL HISTORY
	# example scripts are installed as dokumentation
	dodoc allnewnoad allnoad allnoadnice clearlogos noadifnew stat2html

	exeinto /usr/bin
	doexe noad
}

pkg_postinst() {

	einfo
	einfo "Congratulations, you have just installed noad!,"
	einfo "To integrate noad in VDR you should do this:"
	einfo
	einfo "In /etc/conf.d/vdr:"
	einfo "-- cut here ---"
	einfo "RECORD=\"noad nice --statisticfile=/video/noad.stat\" "
	einfo "--- cut here ---"
	einfo
	einfo "More infos can be found on vdr.gentoo.de"
	einfo
	einfo "Note: You can use here all pararmeters for noad, please"
	einfo "look in the documentation of noad."
	einfo
}
