# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit gnome2 debug

S=${WORKDIR}/${P}
DESCRIPTION="The acronym Goal stands for Gnome Solo Halma. Solo Halma ist often called Solitaire."
HOMEPAGE="http://goal.berlios.de/"
SRC_URI="http://goal.berlios.de/download/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND=">=dev-libs/glib-2.0*
	>=x11-libs/gtk+-2.0*
	>=gnome-base/libgnomeui-2.0*
	>=gnome-base/libgnomecanvas-2.0* 
	>=gnome-base/gnome-desktop-2.0*
	>=media-libs/libart_lgpl-2.0* 
	>=gnome-base/libgnome-2.0*"

 
