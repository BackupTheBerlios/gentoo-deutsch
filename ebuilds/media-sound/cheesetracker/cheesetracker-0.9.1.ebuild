# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-sound/cheesetracker/cheesetracker-0.9.1.ebuild,v 1.1 2003/12/12 12:32:33 rootshell Exp $


DESCRIPTION="Cheesetracker - a cool music tool"
HOMEPAGE="http://www.reduz.com.ar/cheesetronic/index.php"
SRC_URI="mirror://sourceforge/cheesetronic/cheesetracker-0.9.1.tar.gz"
LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="
	>=dev-util/scons-0.94
	dev-libs/libsigc++
	dev-util/pkgconfig
	x11-libs/qt
	media-sound/alsa-driver
	media-libs/alsa-oss"

src_compile() {
	unset CFLAGS CXXFLAGS
	emake || die "problem compiling cheesetracker"
}

src_install() {
	exeinto /usr/bin
	doexe program__QT/cheesetracker_qt
	dosym /usr/bin/cheesetracker_qt /usr/bin/cheesetracker
	dodoc AUTHORS COPYING INSTALL NEWS README
}

