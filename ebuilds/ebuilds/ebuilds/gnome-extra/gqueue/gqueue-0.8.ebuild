# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

inherit gnome2

IUSE="gnome"

S=${WORKDIR}/gqueue
DESCRIPTION="A cups-printer-queue-frontend for Gnome 2"
SRC_URI="http://web.tiscali.it/diegobazzanella/${P}.tar.gz"
HOMEPAGE="http://web.tiscalinet.it/diegobazzanella"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"


DEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2"

RDEPEND="${DEPEND}
	>=dev-util/intltool-0.22
	sys-devel/gettext
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README"
