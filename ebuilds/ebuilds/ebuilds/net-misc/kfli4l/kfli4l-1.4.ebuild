# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/ebuilds/ebuilds/net-misc/kfli4l/Attic/kfli4l-1.4.ebuild,v 1.1 2003/08/22 15:27:33 fow0ryl Exp $
inherit kde-base 

DESCRIPTION="KDE-based frontend to fli4l"
SRC_URI="http://prdownloads.sourceforge.net/kfli4l/${P}.tar.gz"
HOMEPAGE="http://kfli4l.sourceforge.net/"

KEYWORDS="x86"
LICENSE="GPL"
SLOT="0"

inherit kde-base
need-kde 3

src_unpack()  {
	unpack ${A}
}

src_compile() {
        ./configure || die "configure failed"
        make || die "make failed"
}

src_install() {
	make DESTDIR=${D} install
}

#pkg_postinst() {
#echo 'Kfli4l the imonc for fli4l.'
#}
