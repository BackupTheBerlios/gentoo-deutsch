# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

inherit gnome2

IUSE="gnome"

S=${WORKDIR}/${P}
DESCRIPTION="Rubrica is an addressbook for Gnome desktop. Rubrica store personal data, web urls and emails, notes etc."
SRC_URI="http://digilander.libero.it/nfragale/download/rubrica/${P}.tar.bz2"
HOMEPAGE="http://digilander.iol.it/nfragale/index.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"


DEPEND=">=gnome-base/libgnomeui-2"

RDEPEND="${DEPEND}
	>=dev-util/intltool-0.24
	sys-devel/gettext
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README"
