# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-irc/kmyirc/kmyirc-0.2.7.ebuild,v 1.2 2003/02/01 23:55:03 wpbasti Exp $

inherit kde-base

need-kde 3

DESCRIPTION="${PV} - KDE3 irc client"

HOMEPAGE="http://kmyirc.sf.net"

SRC_URI="http://download.sourceforge.net/sourceforge/kmyirc/${P}.tar.gz"

LICENSE="GPL"

SLOT="0"

KEYWORDS="x86"

newdepend " >=kde-base/kdelibs-3.0.3
	    >=sys-apps/portage-2.0.26"

 
