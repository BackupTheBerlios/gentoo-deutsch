# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vamps/vamps-0.95.ebuild,v 1.1 2003/12/30 17:06:51 jay Exp $

inherit eutils

DESCRIPTION="eVAporate Mpeg-2 Program Stream"
HOMEPAGE="http://www.heise.de/ct/ftp/04/01/094/"
SRC_URI="ftp://ftp.heise.de/pub/ct/listings/0401-094.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="media-libs/libdvdread"

src_unpack() {
	unpack ${A}
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	insinto /usr
	dodoc COPYING INSTALL README
	dobin vamps vamps-play_title lsdvd

}
