# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/ebuilds/ebuilds/media-gfx/kimagemapeditor/Attic/kimagemapeditor-1.0.ebuild,v 1.1 2003/08/22 15:27:27 fow0ryl Exp $
inherit kde-base

DESCRIPTION="An imagemap editor for KDE"
SRC_URI="http://savannah.nongnu.org/download/kimagemap/${P}.tar.bz2"
HOMEPAGE="http://kimagemapeditor.sourceforge.net/"

need-kde 3.1.2

LICENSE="GPL-2"
KEYWORDS="~x86"

src_compile(){
        ./configure --prefix=$KDEDIR||die
        emake||die
}

src_install(){
        emake DESTDIR=${D} install || die "emake install failed"
}
