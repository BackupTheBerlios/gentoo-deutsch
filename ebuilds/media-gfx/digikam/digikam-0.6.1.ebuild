# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-gfx/digikam/digikam-0.6.1.ebuild,v 1.2 2004/04/06 21:55:09 fow0ryl Exp $

inherit kde-base
need-kde 3

IUSE=""
S=${WORKDIR}/${PN}3
DESCRIPTION="A KDE frontend for gPhoto 2"
HOMEPAGE="http://digikam.sourceforge.net/"
#SRC_URI="mirror://sourceforge/digikam/${P}.tar.bz2"
#RESTRICT="nomirror"
SRC_URI="http://digikam.free.fr/Tarballs/${PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="x86"

newdepend "
	>=kde-base/kdelibs-3.1
	>=kde-base/kdesdk-3.1
	>=media-libs/libgphoto2-2.1.2
	>=media-libs/libexif-0.5.7
	>=media-libs/imlib-1.9.0
	"
