# Copyright 2002 Alexander Holler.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-mail/metamail/Attic/metamail-2.7.45.ebuild,v 1.1 2002/07/22 04:10:12 holler Exp $

DESCRIPTION="Metamail (with Debian patches) - Generic MIME package"
HOMEPAGE="ftp://thumper.bellcore.com/pub/nsb/"

S=${WORKDIR}/mm2.7/src
SRC_URI="ftp://thumper.bellcore.com/pub/nsb/mm2.7.tar.Z
	http://ftp.debian.org/debian/pool/main/m/metamail/metamail_2.7-45.diff.gz"
LICENSE="GPL-2"
SLOT="1"

RDEPEND="virtual/glibc
	sys-libs/ncurses
	sys-apps/sharutils
	net-mail/mailbase"

DEPEND="virtual/glibc
	sys-libs/ncurses
	sys-devel/automake"

src_unpack() {

	unpack mm2.7.tar.Z || die
	cd ${S}
	cat ${DISTDIR}/metamail_2.7-45.diff.gz | gzip -d  | patch -p1 || die

}

src_compile() {

	/bin/sh ./configure --prefix=/usr || die "configure problem"
	emake || die "compile problem"

}

src_install () {

	make install DESTDIR=${D}
	dodoc COPYING CREDITS README
	rm man/mmencode.1
	doman man/*
	doman debian/mimencode.1 debian/mimeit.1
	insinto /etc
	doins ${FILESDIR}/mime.types

}

