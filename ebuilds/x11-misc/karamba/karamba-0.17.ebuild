# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/x11-misc/karamba/Attic/karamba-0.17.ebuild,v 1.1 2003/04/16 09:47:35 shermann Exp $

inherit kde-base

need-kde 3

DESCRIPTION="A KDE program that displays a lot of various information right on your desktop."
HOMEPAGE="http://www.efd.lth.se/~d98hk/karamba/"
SRC_URI="http://www.efd.lth.se/~d98hk/karamba/src/${P}.tar.gz"

LICENSE="GPL"

SLOT="0"

KEYWORDS="~x86"

newdepend " >=kde-base/kdelibs-3.1
			>=media-sound/xmms-1.2.7
	    >=sys-apps/portage-2.0.26"
