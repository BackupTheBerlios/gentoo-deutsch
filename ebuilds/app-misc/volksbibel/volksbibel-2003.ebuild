# Copyright 1999-2003 Mario Scheel
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/app-misc/volksbibel/volksbibel-2003.ebuild,v 1.1 2003/11/22 18:19:35 zweistein12 Exp $

#inherit eutils

A="volksbibel.tar.gz"
S=${WORKDIR}/volksbibel

DESCRIPTION="A good german bible-program"
HOMEPAGE="http://www.volksbibel.de"
SRC_URI="http://home.arcor.de/efsdon/${A}"

LICENSE="GPL2"
SLOT="0"
KEYWORDS="x86"
RESTRICT="nostrip"
IUSE="X"

DEPEND="virtual/glibc
	virtual/x11"

src_unpack() {
	unpack ${A}
}

src_install() {
	dodir /opt/volksbibel/
	echo ${WORKDIR}
	echo "\n\n\n\n"
	cp -ar ${WORKDIR}/linux/* ${D}/opt/volksbibel
	chmod a+x -R ${D}/opt/volksbibel/*
	chmod a+x ${D}/opt/volksbibel/volksbib.2
	chmod a+x ${D}/opt/volksbibel/zusatz
	
	dodir /usr/bin
	cp ${FILESDIR}/volksbibel ${D}/usr/bin/volksbibel
}


