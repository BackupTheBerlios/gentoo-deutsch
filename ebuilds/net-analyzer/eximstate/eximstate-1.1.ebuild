# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-analyzer/eximstate/eximstate-1.1.ebuild,v 1.1 2003/10/29 06:18:33 mad Exp $


S=${WORKDIR}/${P}
DESCRIPTION="eximstate monitors the size of the queue on an Exim mail server"
HOMEPAGE="http://www.olliecook.net/projects/eximstate/"
SRC_URI="${HOMEPAGE}releases/${P}.tar.gz"

KEYWORDS="~x86 ~sparc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="rrdtool"
IUSE=""
PROVIDE=""

src_unpack() {
	unpack ${A}
}

src_compile() {
	#if [ "$EXIMSTATE_OPTS" == "server" ] ; then
	#	myconf="--with-rrdtool"
	#else
	#	myconf=" --without-server"
	#fi
	myconf="--with-rrdtool"

	cd ${S}
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var/eximstate \
		${myconf} || die

	make || die "compile problem"
}

src_install() {
	make -e DESTDIR=${D} install || die
}

