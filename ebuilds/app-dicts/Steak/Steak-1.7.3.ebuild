# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/app-dicts/Steak/Steak-1.7.3.ebuild,v 1.2 2003/10/03 14:42:53 dertobi123 Exp $

DESCRIPTION="EN => DE Dictionary"
HOMEPAGE="http://www.tm.informatik.uni-frankfurt.de/~razi/steak"

SRC_URI="( http://www.tm.informatik.uni-frankfurt.de/~razi/steak/program/Steak.1.7.3.tar.gz
	http://tobias.scherbaum.info/gentoo/patches/Steak-1.7.3-patch.bz2)"
LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE=""

DEPEND="app-text/ispell"
RDEPEND=""
S="${WORKDIR}"

src_compile() {
	cd ${S}/Steak
	make
}

src_install() {
	mv ${S}/Steak-1.7.3-patch ${S}/Steak
	cd ${S}/Steak
	patch -i Steak-1.7.3-patch
	mkdir -p ${D}/usr/share/Steak
	mkdir -p ${D}/usr/bin
	mkdir -p ${D}/usr/share/Steak/Datensatz
	cp ${S}/Steak/Datensatz/ger-eng.txt ${D}/usr/share/Steak/Datensatz/ 
	cp ${S}/Steak/mini_steak_icon.xpm  ${D}/usr/share/Steak/
	cp ${S}/Steak/pinguin_steak_icon.xpm ${D}/usr/share/Steak/
	cp ${S}/Steak/copyrights.txt ${D}/usr/share/Steak/
	cp ${S}/Steak/help.txt ${D}/usr/share/Steak/
	cp ${S}/Steak/version.txt ${D}/usr/share/Steak/
	cp ${S}/Steak/README ${D}/usr/share/Steak/
	cp ${S}/Steak/README.eng ${D}/usr/share/Steak/
	cp ${S}/Steak/.Steakconfig ${D}/usr/share/Steak/
	cp ${S}/Steak/woerterbuch ${D}/usr/bin/steak
	cp ${S}/Steak/woerterbuch ${D}/usr/bin/woerterbuch
	cp ${S}/Steak/printbuffer ${D}/usr/bin/
	cp ${S}/Steak/iso2txt ${D}/usr/bin/
	cp ${S}/Steak/spacefilter ${D}/usr/bin/
	cp ${S}/Steak/poll ${D}/usr/bin/
	}
