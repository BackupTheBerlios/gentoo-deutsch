# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/dev-libs/mdsplib/mdsplib-0.11.ebuild,v 1.1 2003/10/15 20:08:37 martini Exp ${VDRPLUGIN}/vdr-${VDRPLUGIN}-0.5.0.ebuild,v 1.1 2003/05/03 14:48:26 fow0ryl Exp $

S=${WORKDIR}/${P}
DESCRIPTION="METAR Decoder Software Package Library"
HOMEPAGE="http://http://limulus.net/mdsplib/"
SRC_URI="http://limulus.net/mdsplib/mdsplib-0.11.tar.gz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
}

src_compile() {
	cd ${S}
	make all || die "compile problem"
}

src_install() {
	insinto /usr/local/include
	insopts -m0644
	newins ${S}/metar.h metar.h
	insinto /usr/local/lib
	insopts -m0644
	newins ${S}/libmetar.a libmetar.a 
	dodoc README README.MDSP HISTORY
}
