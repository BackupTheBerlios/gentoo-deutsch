# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-gfx/digikamplugins/digikamplugins-0.6.1.ebuild,v 1.2 2004/04/26 00:00:17 ripclaw Exp $

inherit kde-base
need-kde 3

IUSE="opengl"

S=${WORKDIR}/${PN}
DESCRIPTION="Digikam (A KDE frontend for gPhoto 2) plugins"
HOMEPAGE="http://digikam.sourceforge.net/"
#SRC_URI="mirror://sourceforge/digikam/${P}.tar.bz2"
#RESTRICT="nomirror"
SRC_URI="http://digikam.free.fr/Tarballs/${PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="x86"

newdepend "
	>=digikam-${PV}
	>=kde-base/kdelibs-3.0
	>=media-libs/libgphoto2-2.0
	>=media-libs/imlib-1.9.0
	>=media-libs/libexif-0.5.7
	>=media-gfx/imagemagick-5.5.4
	>=media-video/mjpegtools-1.6.0
	>=media-gfx/dcraw-5.72
	virtual/opengl
	"

src_unpack() {
	unpack ${A}
	if ! [ `use opengl` ]; then
	   ewarn "slideshow disabled, because there is no opengl USE Flag"
	   cd ${S}
	   /bin/sed -i configure.in.in \
            -e 's:#DO_NOT_COMPILE="$DO_NOT_COMPILE slideshow":DO_NOT_COMPILE="$DO_NOT_COMPILE slideshow":'
	   /bin/sed -i configure.in \
            -e 's:#DO_NOT_COMPILE="$DO_NOT_COMPILE slideshow":DO_NOT_COMPILE="$DO_NOT_COMPILE slideshow":'
	fi
	if ! [ `use cdr` ]; then
	   ewarn "cdarchiving disabled, because there is no cdr USE Flag"
	   cd ${S}
	   /bin/sed -i configure.in.in \
            -e 's:#DO_NOT_COMPILE="$DO_NOT_COMPILE cdarchiving":DO_NOT_COMPILE="$DO_NOT_COMPILE scdarchiving":'
	   /bin/sed -i configure.in \
            -e 's:#DO_NOT_COMPILE="$DO_NOT_COMPILE cdarchiving":DO_NOT_COMPILE="$DO_NOT_COMPILE scdarchiving":'
	fi
}
