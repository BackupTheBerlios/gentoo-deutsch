# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

IUSE="nls"

S=${WORKDIR}/sodipodi-0.29pre/
DESCRIPTION="Vector illustration application for GNOME"
SRC_URI="mirror://sourceforge/${PN}/sodipodi-0.29pre.tar.gz"
HOMEPAGE="http://sodipodi.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

RDEPEND=">=gnome-base/libgnomeprintui-2*
	 >=gnome-base/libgnome-2.0.4
	 >=x11-libs/xft-2*
"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
        unpack ${A}
        
        cd ${S}
        export WANT_AUTOCONF_2_5=1
        autoconf --force
}

src_compile() {
	local myconf
	econf \
		--enable-gnome \
		--enable-gnome-print \
		${myconf} || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}
