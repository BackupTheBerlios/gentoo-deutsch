# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Martin Hierling <mad@cc.fh-lippe.de>
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-mail/LinuxTaRT/LinuxTaRT-3.04.ebuild,v 1.1 2004/03/17 17:34:36 mad Exp $

# This ebuild was generated by Ebuilder v0.4.

S="${WORKDIR}/${P}"
DESCRIPTION="LinuxTaRT - generates email signatures"
SRC_URI="http://mvgrafx.dyn.ca/~vmark/files/${P}.tar.gz"
HOMEPAGE="http://mvgrafx.dyn.ca/~vmark/LT/"
LICENSE="GPL-2"
DEPEND=""

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
	#make || die
}

src_install () {
	#make DESTDIR=${D} install || die
	# If the above installs anything outside of DESTDIR, try the following.

	mkdir -p 	${D}/usr/bin \
			${D}/usr/share/man/man{1,5} \
			${D}/usr/share/LinuxTaRT

	make -e \
		prefix=${D}/usr \
		MANDIR=${D}/usr/share/man \
		datadir=${D}/usr/share/LinuxTaRT \
		install || die

	# Install documentation.
	dodoc ChangeLog COPYING INSTALL README
}
