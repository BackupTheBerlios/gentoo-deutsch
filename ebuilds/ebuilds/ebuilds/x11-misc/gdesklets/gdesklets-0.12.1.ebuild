# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/ebuilds/ebuilds/x11-misc/gdesklets/Attic/gdesklets-0.12.1.ebuild,v 1.1 2003/08/22 15:27:23 fow0ryl Exp $

#fixme
addwrite /usr/share

inherit gnome2

DESCRIPTION="gDesklets provides an advanced architecture for desktop applets - tiny displays sitting on your desktop in a symbiotic relationship of eye candy and usefulness"
HOMEPAGE="http://www.pycage.de/software_gdesklets.html"
LICENSE="GPL-2"

MY_P=gDesklets
S=${WORKDIR}/${MY_P}-${PV}


SRC_URI="http://www.pycage.de/download/gdesklets/${MY_P}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND=">=gnome-base/gconf-1.2
	>=x11-libs/gtk+-2
	>=dev-lang/python-2.2
	>=dev-python/gnome-python-1.99.14
	>=dev-python/pygtk-1.99.14
"

DEPEND="${RDEPEND}
	sys-devel/autoconf
	dev-util/pkgconfig"

src_unpack() {
	unpack ${MY_P}-${PV}.tar.gz
	cd ${S}
}

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README TODO"
