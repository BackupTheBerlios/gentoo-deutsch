# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Diagram Creation Program"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/dia/0.91/dia-0.91-pre1.tar.bz2"
HOMEPAGE="http://www.gnome.org/gnome-office/dia.shtml"

S=${WORKDIR}/dia-0.91-pre1

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="nls gnome truetype png"

RDEPEND=">=dev-libs/libxml2-2.5*
	>=x11-libs/gtk+-2*
	>=dev-libs/glib-2*
	dev-libs/popt
	dev-libs/libunicode
	truetype? ( >=media-libs/freetype-2.0.9 )
	png? ( media-libs/libpng
		>=gnome-base/gnome-libs-1.4 )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	python? ( >=dev-lang/python-2.0 )"

src_compile() {
	local myconf

	use gnome && myconf="--enable-gnome" \
		|| myconf="--disable-gnome"

	use python && myconf="${myconf} --with-python"

	use truetype && myconf="${myconf} --enable-freetype" \
		|| myconf="${myconf} --enable-freetype"

	use nls || myconf="${myconf} --disable-nls"
 
	econf ${myconf}
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog README NEWS TODO KNOWN_BUGS
}
