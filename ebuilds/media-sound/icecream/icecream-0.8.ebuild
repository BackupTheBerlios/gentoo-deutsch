# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-sound/icecream/icecream-0.8.ebuild,v 1.2 2003/10/04 15:11:10 dertobi123 Exp $

DESCRIPTION="Stream downloading utility"
HOMEPAGE="http://icecream.sourceforge.net/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${P}

src_install() {
	mkdir -p ${D}/usr/bin
	cp ${S}/icecream ${D}/usr/bin/icecream
	}
