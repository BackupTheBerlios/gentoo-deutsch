# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

IUSE="doc"

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="A xpdf based PDF viewer for GNOME 2"
HOMEPAGE="http://www.gnome.org/"
#SRC_URI="ftp://ftp.gnome.org/pub/gnome/desktop/2.1/2.1.5/sources/${P}.tar.bz2"
SLOT="1"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

RDEPEND=">=x11-libs/gtk+-2.2*
	>=x11-libs/pango-1.1.6
	>=dev-libs/glib-2.2*
	>=gnome-base/libbonoboui-2.1.0
	>=gnome-base/libgnome-2.1.5
	>=gnome-base/libgnomeui-2.1.5
	>=gnome-base/ORBit2-2.5.0
	>=gnome-base/libglade-2.0.1
	>=app-text/xpdf-2.0"

DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )
	>=dev-util/pkgconfig-0.14.0"

src_compile() {
        local myconf
        myconf="${myconf} --enable-a4-paper"
        econf ${myconf}
        emake || die
}

G2CONF="${G2CONF} --disable-install-schemas"
DOC="AUTHORS COPYING ChangeL* INSTALL MAINTAINERS NEWS  README* TODO*"
