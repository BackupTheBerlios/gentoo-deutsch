# Copyright 2002
# Distributed under the terms of the GNU General Public License, v2 or later

S=${WORKDIR}/xmms-kj/
DESCRIPTION="A xmms remote that allows users to use K-Jofol skins"
SRC_URI="http://www.dgs.monash.edu.au/~timf/kint_xmms-${PV}.tar.gz"
HOMEPAGE="http://www.csse.monash.edu.au/~timf/xmms.html"

DEPEND=">=media-sound/xmms-1.2.7"

src_compile() {
        emake || die
}

src_install() {
        dobin kj
        dodir /usr/share/xmms/kjofol
        cp *.zip ${D}usr/share/xmms/kjofol
        dodoc readme.txt COPYING
}

pkg_postinst() {
echo 'This plugin works as a remote for XMMS. Start XMMS before'
echo 'using this plugin with kj'
echo 'Place K-Jofol skins in ~/.xmms/kjofol/'
} 