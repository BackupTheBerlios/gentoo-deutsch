# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit gnome2 debug

S=${WORKDIR}/${P}
DESCRIPTION="COnfigurator for Gnome"
HOMEPAGE=""
SRC_URI="http://www.daimi.au.dk/~maxx/progs/cog/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND=">=dev-libs/glib-2.0.4
	>=x11-libs/gtk+-2.0.5
	>=gnome-base/libgnomeui-2.0.1
	>=gnome-base/libglade-2.0.0
	>=gnome-base/gconf-1.2.0"

src_install() {
	make DESTDIR=${D} prefix=/usr \
		sysconfdir=/etc \
                infodir=/usr/share/info \
                mandir=/usr/share/man \
                localstatedir=/var/lib \
                install || die

        dodoc AUTHORS COPYING ChangeL* INSTALL NEWS README* TODO*
}
 
