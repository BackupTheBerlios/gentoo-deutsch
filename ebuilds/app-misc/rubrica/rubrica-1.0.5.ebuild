# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/app-misc/rubrica/rubrica-1.0.5.ebuild,v 1.1 2003/10/04 15:06:00 dertobi123 Exp $

inherit gnome2

DESCRIPTION="PIM for the Gnome Desktop"
HOMEPAGE="http://digilander.libero.it/nfragale"

SRC_URI="http://digilander.libero.it/nfragale/download/rubrica/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2.0
	>=dev-libs/libxslt-1.0"

DEPEND="${RDEPEND}
	 dev-util/pkgconfig"

DOCS="AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README* TODO"

