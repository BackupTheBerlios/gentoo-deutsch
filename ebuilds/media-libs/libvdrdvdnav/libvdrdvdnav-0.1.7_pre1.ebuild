# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-libs/libvdrdvdnav/libvdrdvdnav-0.1.7_pre1.ebuild,v 1.1 2003/04/28 20:22:10 mad Exp $

S=${WORKDIR}/libdvdnav-0.1.7
DESCRIPTION="Library for DVD navigation tools (patched Version)."
HOMEPAGE="http://sourceforge.net/projects/dvd/"
#SRC_URI="http://www.cs.uni-magdeburg.de/~aschultz/dvd/libdvdnav-0.1.4note2-vdr-as2.tar.gz"
SRC_URI="http://heanet.dl.sourceforge.net/sourceforge/dvd/libdvdnav-0.1.7.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=" media-libs/libdvdread
         !media-libs/libdvdnav
		 >=sys-devel/automake-1.7.0
		 "

src_unpack() {
	unpack ${A}
}

src_compile() {
	econf --enable-shared --libdir=/usr/lib --includedir=/usr/include || die "./configure failed"
	sed -i "s/^SUBDIRS.*/SUBDIRS = src/" Makefile
	make || die "make failed"
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
}

pkg_postinst() {
	einfo
	einfo "Please remove old versions of libdvdnav manually,"
	einfo "having multiple versions installed can cause problems."
	einfo
}
