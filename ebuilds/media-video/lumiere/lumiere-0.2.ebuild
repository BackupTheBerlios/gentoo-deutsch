# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

IUSE="doc"

inherit gnome2

S=${WORKDIR}/lum/
DESCRIPTION="Gnome 2 frontend to mplayer"
HOMEPAGE="http://brain.shacknet.nu/lumiere.html"
SRC_URI="http://brain.shacknet.nu/lumiere-0.2.tar.gz"
SLOT="1"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

RDEPEND=">=x11-libs/gtk+-2*
	>=dev-libs/glib-2*
	>=gnome-base/libgnomeui-2*
	>=gnome-base/libbonoboui-2*
	>=gnome-base/bonobo-activation-2*
	>=gnome-base/gnome-vfs-2*
	>=media-video/mplayer-0.90_rc2
	>=dev-util/gob-2*
"



DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )
	>=dev-util/pkgconfig-0.12.0"

src_compile() {
  local myconf
	myconf="${myconf} --disable-gtk-doc"
}

DOC="AUTHORS COPYING ChangeL* INSTALL MAINTAINERS NEWS  README* TODO*"
 
