# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

IUSE="doc"

inherit gnome2

S=${WORKDIR}/stickynotes_applet-1.0.1/
DESCRIPTION="A Gnome 2.0 applet that allows you to create, view and manage sticky notes on your desktop"
HOMEPAGE="http://loban.caltech.edu/stickynotes"
SRC_URI="http://loban.caltech.edu/stickynotes/packages/stickynotes_applet-1.0.1.tar.gz"
SLOT="1"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

RDEPEND=">=x11-libs/gtk+-2*
	>=x11-libs/pango-1*
	>=dev-libs/glib-2*
	>=gnome-base/libgnomeui-2*
	>=gnome-base/gnome-panel-2*
"

DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )
	>=dev-util/pkgconfig-0.12.0"

DOC="AUTHORS COPYING ChangeL* INSTALL MAINTAINERS NEWS  README* TODO*"
 
