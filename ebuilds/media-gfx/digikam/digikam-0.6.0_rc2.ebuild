# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-gfx/digikam/Attic/digikam-0.6.0_rc2.ebuild,v 1.1 2004/02/07 01:22:34 ripclaw Exp $

inherit kde-base
need-kde 3

IUSE=""
DESCRIPTION="A KDE frontend for gPhoto 2"
HOMEPAGE="http://digikam.sourceforge.net/"
SRC_URI="http://digikam.free.fr/Tarballs/${PN}-0.6.0-rc2.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86"

newdepend ">=kde-base/kdelibs-3.0
	>=kde-base/kdesdk-3.0
	>=media-gfx/gphoto2-2.0-r1"

S=${WORKDIR}/${PN}-0.6.0-rc2
