# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-misc/kwhois/kwhois-1.1.7-r1.ebuild,v 1.1 2003/03/30 08:35:05 shermann Exp $

inherit kde-base

need-kde 3

DESCRIPTION="${PV} - KDE3 whois client"
HOMEPAGE="http://sf.net/projects/kwhois"
SRC_URI="http://osdn.dl.sourceforge.net/sourceforge/kwhois/kwhois-1.1.7rc1.tar.gz"

LICENSE="GPL"

SLOT="0"

KEYWORDS="~x86"
S=${WORKDIR}/${PN}-1.1.7rc1
newdepend " >=kde-base/kdelibs-3.1
	    >=sys-apps/portage-2.0.26"

