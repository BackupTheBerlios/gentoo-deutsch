# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/x11-wm/Attic/fvwm-2.4.9.ebuild,v 1.1 2002/09/05 14:13:31 irohlfs Exp $

S=${WORKDIR}/${P}
DESCRIPTION="an extremely powerful ICCCM-compliant multiple virtual desktop window manager"
SRC_URI="ftp://ftp.fvwm.org/pub/fvwm/version-2/${P}.tar.bz2
	 http://www.igs.net/~tril/fvwm/configs/fvwm-patch"
HOMEPAGE="http://www.fvwm.org/"

SLOT="0"
KEYWORDS="x86 sparc sparc64"
LICENSE="GPL-2 FVWM"

RDEPEND=">=dev-libs/libstroke-0.4
	gtk? ( =x11-libs/gtk+-1.2* )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
	ncurses? ( >=sys-libs/readline-4.1 )"
DEPEND="${RDEPEND} sys-devel/automake"

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}
	patch -p0 < ${DISTDIR}/fvwm-patch || die
}

src_compile() {
	local myconf

	use gnome \
		&& myconf="--with-gnome" \
		|| myconf="--without-gnome" \

	automake

	econf \
		--libexecdir=/usr/lib \
		${myconf} || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	echo "#!/bin/bash" > fvwm2
	echo "/usr/bin/fvwm2" >> fvwm2

	exeinto /etc/X11/Sessions
	doexe fvwm2
}
