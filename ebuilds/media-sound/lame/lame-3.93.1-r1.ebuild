# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-sound/lame/Attic/lame-3.93.1-r1.ebuild,v 1.1 2003/01/16 18:49:53 holler Exp $

IUSE="gtk"

inherit libtool eutils

DESCRIPTION="LAME Ain't an Mp3 Encoder"
SRC_URI="mirror://sourceforge/lame/${P}.tar.gz"
HOMEPAGE="http://www.mp3dev.org/mp3/"

DEPEND="virtual/glibc
	x86? ( dev-lang/nasm )
	>=sys-libs/ncurses-5.2
	gtk? ( =x11-libs/gtk+-1.2* )"
# this release completely removed oggvorbis support as it was too outdated.

RDEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	gtk? ( =x11-libs/gtk+-1.2* )"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc sparc alpha"

replace-flags k6-3 i586
replace-flags k6-2 i586
replace-flags k6 i586

src_compile() {
	elibtoolize

	# Fix configure borking on detecting gtk-config
	export WANT_AUTOMAKE_1_5=1
	export WANT_AUTOCONF_2_5=1
	autoreconf

	local myconf=""
	if [ "`use gtk`" ] ; then
		myconf="${myconf} --enable-mp3x"
	fi
	if [ "${DEBUG}" ] ; then
		myconf="${myconf} --enable-debug=yes"
	else
		myconf="${myconf} --enable-debug=no"
	fi
	
	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--enable-shared \
		--enable-nasm \
		--enable-mp3rtp \
		--enable-extopt=full \
		${myconf} || die
		
	emake || die
}

src_install () {

	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		pkghtmldir=${D}/usr/share/doc/${PF}/html \
		install || die

	dodoc API COPYING HACKING PRESETS.draft LICENSE README* TODO USAGE
	dohtml -r ./
}
