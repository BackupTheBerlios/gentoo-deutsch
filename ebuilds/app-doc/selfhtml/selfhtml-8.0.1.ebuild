# Copyright 2004 Stefan Nickl <snickl@snickl.freaks.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/app-doc/selfhtml/selfhtml-8.0.1.ebuild,v 1.1 2004/01/21 11:58:26 snickl Exp $

IUSE=""

SELFDIR=/usr/share/doc/${P}
DESCRIPTION="german html reference: HTML-Dateien selbst erstellen"
SRC_URI="http://www.stud.uni-goettingen.de/software/${PN}80.zip
         http://selfaktuell.teamone.de/extras/${PN}8err01.zip"
HOMEPAGE="http://selfhtml.teamone.de/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

src_install() {
	dodir ${SELFDIR}
	cp -R ${WORKDIR}/* ${D}/${SELFDIR}
	dosym index.htm ${SELFDIR}/index.html
	dosym index.htm ${SELFDIR}/selfhtml.html
}
