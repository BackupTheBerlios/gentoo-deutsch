# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2


inherit debug

S=${WORKDIR}/${P}
DESCRIPTION="Film Gimp is a free open source image painting and retouching program with features similar to GIMP and Adobe Photoshop, but with a motion picture twist."
SRC_URI="mirror://sourceforge/filmgimp/${P}.tar.gz"
HOMEPAGE="http://filmgimp.sourceforge.net/"
SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

RDEPEND="=x11-libs/gtk+-1.2*"
	
DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.9 )"

src_install() {
        make DESTDIR=${D} prefix=/usr \
                sysconfdir=/etc \
                infodir=/usr/share/info \
                mandir=/usr/share/man \
                localstatedir=/var/lib \
                install || die
                                                                                                                                               
        dodoc AUTHORS COPYING ChangeL* HACKING INSTALL MAINTAINERS NEWS PLUGIN_MAINTAINERS README* TODO*
}