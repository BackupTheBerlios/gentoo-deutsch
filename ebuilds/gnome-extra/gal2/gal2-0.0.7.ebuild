# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit gnome2

DESCRIPTION="Gnome 2 Gnome Application libraries"
SRC_URI="mirror://gnome/2.0.1/sources/gal2/gal2-0-${PV}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 sparc "

MAKEOPTS="-j1"

DEPEND="virtual/glibc
	>=gnome-base/libgnomeprint-2.0.0
	>=gnome-base/libgnomeprintui-2.0.0
	>=gnome-base/libglade-2.0.0
	>=gnome-base/libgnomeui-2.0.3
	>=gnome-base/libgnomecanvas-2.0.2
	>=dev-libs/libxml2-2.4.23"

S=${WORKDIR}/gal2-0-${PV}

DOCS="AUTHORS BUGS ChangeLog COPYING COPYING.LIB FAQ INSTALL NEWS README* THANKS TODO"
 
