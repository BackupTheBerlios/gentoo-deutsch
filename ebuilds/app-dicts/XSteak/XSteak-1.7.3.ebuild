# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/app-dicts/XSteak/XSteak-1.7.3.ebuild,v 1.2 2003/10/03 15:36:52 dertobi123 Exp $

DESCRIPTION="GTK+ based GUI for the steak Dictionary"
HOMEPAGE="http://www.tm.informatik.uni-frankfurt.de/~razi/steak"

SRC_URI="http://www.tm.informatik.uni-frankfurt.de/~razi/steak/program/Steak.1.7.3.tar.gz"
LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE=""

DEPEND="app-text/ispell
	app-dicts/Steak
	x11-libs/gtk+"
RDEPEND=""
S="${WORKDIR}"

src_compile() {
	cd ${S}/Steak/Xsteak
	make -f Makefile_gtk_1.2
}

src_install() {
	mkdir -p ${D}/usr/bin
	mkdir -p ${D}/usr/share/Steak/
	cp ${S}/Steak/Xsteak/steak.xpm ${D}/usr/share/Steak/steak.xpm 
	cp ${S}/Steak/Xsteak/xsteak ${D}/usr/bin
}
