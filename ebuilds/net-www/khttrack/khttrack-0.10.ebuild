# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-www/khttrack/Attic/khttrack-0.10.ebuild,v 1.3 2003/07/06 11:58:29 ripclaw Exp $

inherit kde-base
need-kde 3

IUSE=""
LICENSE="GPL-2"
RDEPEND="net-www/httrack"
KEYWORDS="x86 ppc"
DESCRIPTION="Khttrack is a easy-to-use offline browser utility with Kde Wizard Interface."
SRC_URI="http://freesoftware.fsf.org/download/khttrack/stable.pkg/${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.nongnu.org/khttrack/"

src_install() {

    kde_src_install

}