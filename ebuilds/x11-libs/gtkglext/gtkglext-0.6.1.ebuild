# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit gnome2 debug

S=${WORKDIR}/${P}
DESCRIPTION="GtkGLExt is an OpenGL extension to GTK 2.0 or later."
HOMEPAGE="http://gtkglext.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtkglext/${P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

RDEPEND=">=dev-libs/glib-2.0.6-r1
        >=x11-libs/gtk+-2.0.6-r1
        virtual/glu
        virtual/opengl"
 
DEPEND="${DEPEND}
         doc? ( >=dev-util/gtk-doc-0.9 )"
 
