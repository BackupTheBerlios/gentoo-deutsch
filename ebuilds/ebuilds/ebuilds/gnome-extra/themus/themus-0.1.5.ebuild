# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit gnome2

IUSE=""
S=${WORKDIR}/${P}
DESCRIPTION="Theme viewer for Nautilus"
SRC_URI="ftp://ftp.acc.umu.se/pub/GNOME/sources/themus/0.1/themus-0.1.5.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND=">=gnome-base/gnome-vfs-2.2
	>=gnome-base/nautilus-2.2
	>=gnome-base/gnome-2.2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS  README"
