# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/app-misc/jaffm/jaffm-0.9.7.ebuild,v 1.1 2003/10/04 15:03:35 dertobi123 Exp $

DESCRIPTION="Just A Fucking File Manager"
HOMEPAGE="http://jaffm.binary.is/"

SRC_URI="http://www.binary.is/download/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-1.2
	>=x11-libs/wxGTK-2.4"
RDEPEND=""

S=${WORKDIR}/${P}

src_compile() {
	emake || die
}

src_install() {
	mkdir -p ${D}/usr/bin
	cp ${S}/jaffm ${D}/usr/bin/jaffm
}
