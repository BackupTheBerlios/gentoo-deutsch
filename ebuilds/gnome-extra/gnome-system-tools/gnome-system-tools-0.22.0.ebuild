# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/gnome-extra/gnome-system-tools/Attic/gnome-system-tools-0.22.0.ebuild,v 1.2 2003/02/01 23:55:02 wpbasti Exp $

inherit gnome2 debug

S=${WORKDIR}/${P}
DESCRIPTION="the GNOME System Tools are a set of cross-platform configuration utilities for Linux and other Unix systems"
HOMEPAGE=""
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/sources/gnome-system-tools/0.22/gnome-system-tools-0.22.0.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND=">=x11-libs/gtk+-2
	>=gnome-base/libgnomeui-1.109.0
	>=gnome-base/libglade-1.99.5
	>=dev-libs/libxml2-2.4.12
	>=gnome-base/gnome-2.0.0"

src_install() {
	make DESTDIR=${D} prefix=/usr \
		sysconfdir=/etc \
                infodir=/usr/share/info \
                mandir=/usr/share/man \
                localstatedir=/var/lib \
                install || die

        dodoc AUTHORS COPYING ChangeL* HACKING INSTALL MAINTAINERS NEWS PLUGIN_MAINTAINERS README* TODO*
}
 
