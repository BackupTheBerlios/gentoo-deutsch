# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/sys-apps/gportage/gportage-0.2.1.ebuild,v 1.1 2003/12/03 12:42:38 dertobi123 Exp $                                                                                                 

DESCRIPTION="gportage is a simple gtk-based portage package browser"
HOMEPAGE="http://www.stacken.kth.se/~foo/gentoo/"
SRC_URI="http://www.stacken.kth.se/~foo/gentoo/files/${PN}-${PV}.py"
                                                                                                 
LICENSE="BSD"
                                                                                                 
SLOT="0"
KEYWORDS="~x86"
IUSE=""
                                                                                                 
DEPEND=">=dev-python/pygtk-2.0.0"
RDEPEND="${DEPEND}"
                                                                                                 

src_unpack() {
	cp ${DISTDIR}/${PN}-${PV}.py ${WORKDIR}/${PN}
}

src_install() {
        dobin ${WORKDIR}/${PN}
}
