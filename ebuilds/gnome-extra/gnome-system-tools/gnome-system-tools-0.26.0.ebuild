# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit gnome2 debug

#Fixme
addwrite /root
addwrite /etc/gconf

S=${WORKDIR}/${P}
DESCRIPTION="the GNOME System Tools are a set of cross-platform configuration utilities for Linux and other Unix systems"
HOMEPAGE=""
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/sources/gnome-system-tools/0.26/gnome-system-tools-0.26.0.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND=">=x11-libs/gtk+-2.2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libglade-2
	>=dev-libs/libxml2-2.4.12
	>=gnome-base/gnome-2.2
	>=x11-libs/vte-0.10.20"

src_compile() {
        local myconf
        myconf="${myconf} --enable-platform-gnome-2"
                                                                                                                                               
        econf ${myconf}
        emake || die
}

src_install() {
	make DESTDIR=${D} prefix=/usr \
		sysconfdir=/etc \
                infodir=/usr/share/info \
                mandir=/usr/share/man \
                localstatedir=/var/lib \
                install || die

        dodoc AUTHORS COPYING ChangeL* HACKING INSTALL MAINTAINERS NEWS PLUGIN_MAINTAINERS README* TODO*
}
 
