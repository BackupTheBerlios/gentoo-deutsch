# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2


S=${WORKDIR}/${P}/
DESCRIPTION="Gnome SuperUser is an easy way to run a program as root in the Gnome environment."
SRC_URI="mirror://sourceforge/xsu/${P}.tar.gz"
HOMEPAGE="http://xsu.sourceforge.net/"
KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"
DEPEND=">=x11-libs/gtk+-2*
	>=gnome-base/libgnomeui-2*
	>=gnome-base/libglade-2*
	>=x11-libs/libzvt-2*
"

src_install () {
	make DESTDIR=${D} install || die
}