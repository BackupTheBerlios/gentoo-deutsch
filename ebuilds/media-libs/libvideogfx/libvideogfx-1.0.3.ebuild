# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-libs/libvideogfx/Attic/libvideogfx-1.0.3.ebuild,v 1.1 2003/02/18 18:36:30 mad Exp $


S=${WORKDIR}/${P}
DESCRIPTION="LibVideoGfx - video processing library"
SRC_URI="http://rachmaninoff.informatik.uni-mannheim.de/libvideogfx/data/libvideogfx-1.0.3.tar.gz"
HOMEPAGE="http://rachmaninoff.informatik.uni-mannheim.de/private/index.html"

SLOT="0"
LICENSE="LGPL"
KEYWORDS="x86"

DEPEND="media-libs/libpng media-libs/jpeg x11-base/xfree"

src_unpack() {
	unpack ${A}
}

src_compile() {
	cd ${S}
	econf || die "configure problems"
	emake || die "compile problems"
}

src_install() {
	make \
		DESTDIR=${D} \
		MANPATH=/usr/share/man \
		install || die
}
