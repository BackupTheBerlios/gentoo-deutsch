# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/app-misc/xbiso/xbiso-0.6.0.ebuild,v 1.1 2004/02/15 11:27:40 longint Exp $
DESCRIPTION="iso extraction utillity for xdvdfs images (used for xbox)"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/xbiso"

LICENSE="GPL"
KEYWORDS="~x86 ~amd64"
RESTRICT="nomirror"
IUSE=""
SLOT="0"

src_install() {
	#make install will install in /usr/local/bin, so use dobin (no automake yet)
	dobin ${PN}
}
