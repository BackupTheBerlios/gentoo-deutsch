# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit gnome2 debug

S=${WORKDIR}/${P}
DESCRIPTION="You can use gjots to organise your jottings into a tree structure, adding thoughts and miscellany as you go."
HOMEPAGE="http://bhepple.freeshell.org/gjots/"
SRC_URI="http://bhepple.freeshell.org/gjots/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND=">=dev-libs/glib-1.2*
	>=x11-libs/gtk+-1.2*"

 
