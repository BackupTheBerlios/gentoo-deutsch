# Copyright 2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/sys-apps/util-vserver/util-vserver-0.28.ebuild,v 1.1 2004/02/14 16:25:27 mad Exp $

DESCRIPTION="Linux-VServer Project general purpose virtual servers"
SRC_URI="http://www.13thfloor.at/vserver/s_release/v1.26/${P}.tar.bz2"
HOMEPAGE="http://www.13thfloor.at/vserver/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

#RDEPEND=""
S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {

	./configure \
		--sysconfdir=/etc/ \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		|| die "./configure failed"
	emake || die "make failed"
}

src_install () {
	# remove installation of rc scripts
	sed -i -e '2074s/install-sysvSCRIPTS//' Makefile
	make DESTDIR=${D} install || die "make install failed"
}



