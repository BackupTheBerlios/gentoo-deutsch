# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

# Fix me!!!
addwrite /root/
addwrite /etc/gconf/
addwrite /var/lib/scrollkeeper/

DESCRIPTION="gnome front end to gnupg"
SRC_URI="mirror://sourceforge/seahorse/${P}.tar.gz"
HOMEPAGE="http://seahorse.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

DEPEND="virtual/x11
	>=app-crypt/gnupg-1.2.1
	>=app-crypt/gpgme-0.3.14
	>=gnome-base/libglade-2*
	>=gnome-base/libgnomeui-2*"

src_compile() {                           
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} \
	localedir=${D}/usr/share/locale \
	install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}

#	     gnulocaledir=${D}/usr/share/locale 
