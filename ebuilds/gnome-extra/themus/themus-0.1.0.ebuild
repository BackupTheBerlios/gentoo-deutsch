# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit gnome2

IUSE=""
S=${WORKDIR}/${P}
DESCRIPTION="Theme viewer for Nautilus"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/themus/${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND=">=gnome-base/gnome-vfs-2.2
	>=gnome-base/nautilus-2.2
	!<gnome-base/gnome-2.0.3-r1"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS  README"
