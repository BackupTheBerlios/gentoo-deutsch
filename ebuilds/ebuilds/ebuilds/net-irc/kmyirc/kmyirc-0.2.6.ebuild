# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/ebuilds/ebuilds/net-irc/kmyirc/Attic/kmyirc-0.2.6.ebuild,v 1.1 2003/08/22 15:27:27 fow0ryl Exp $

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

 
