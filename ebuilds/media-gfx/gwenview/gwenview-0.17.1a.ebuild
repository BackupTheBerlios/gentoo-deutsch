# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-gfx/gwenview/Attic/gwenview-0.17.1a.ebuild,v 1.1 2003/07/07 14:59:49 longint Exp $

inherit kde-base
need-kde 3

newdepend ">=kde-base/kdebase-3.0"

DESCRIPTION="image viewer for KDE"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://gwenview.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86"
