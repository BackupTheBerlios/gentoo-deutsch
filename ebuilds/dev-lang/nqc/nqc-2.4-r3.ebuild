# Copyright 2002 Alexander Holler
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/dev-lang/nqc/nqc-2.4-r3.ebuild,v 1.2 2003/02/01 23:55:01 wpbasti Exp $

# The revision number of this ebuild is not used gentoo-specific!


S=${WORKDIR}/${P}.${PR}
DESCRIPTION="Not Quite C - C-like compiler for Lego Mindstorms"
SRC_URI="http://www.baumfamily.org/nqc/release/${P}.${PR}.tgz"
HOMEPAGE="http://www.baumfamily.org/nqc/"

SLOT="0"
LICENSE="MPL-1.0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

src_compile() {

	${#NQC_SERIAL} && NQC_SERIAL="/dev/ttyS0"
	sed -e "s:/usr/local/bin:${D}usr/bin:" -e "s:/usr/local/man:${D}usr/share/man:" -e "s:-O6:${CFLAGS}:" < Makefile >makefile
	# emake doesn't work
	DEFAULT_SERIAL_NAME=\"${NQC_SERIAL}\" make || die

}

src_install() {

	make DESTDIR=${D} install
	dodoc history.txt readme.txt scout.txt test.nqc
}

pkg_postinst() {

	einfo "***************************************************************"
	einfo "* To change the default serial name for nqc (/dev/ttyS0)set   *"
	einfo "* the environment variable NQC_SERIAL and reemerge nqc, e.g.: *"
	einfo "*  NQC_SERIAL='/dev/ttyS1' emerge nqc                         *"
	einfo "***************************************************************"
	
}
 
