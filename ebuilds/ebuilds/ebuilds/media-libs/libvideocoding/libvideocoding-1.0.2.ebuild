# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/ebuilds/ebuilds/media-libs/libvideocoding/Attic/libvideocoding-1.0.2.ebuild,v 1.1 2003/08/22 15:27:29 fow0ryl Exp $


S=${WORKDIR}/${P}
DESCRIPTION="LibVideoCoding - video coding library"
SRC_URI="http://rachmaninoff.informatik.uni-mannheim.de/libvideocoding/data/${P}.tar.gz"
HOMEPAGE="http://rachmaninoff.informatik.uni-mannheim.de/private/index.html"

SLOT="0"
LICENSE="LGPL"
KEYWORDS="x86"

DEPEND="media-libs/libpng media-libs/jpeg x11-base/xfree media-libs/libvideogfx media-sound/mad"

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
