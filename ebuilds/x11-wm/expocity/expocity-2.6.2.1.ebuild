# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/x11-wm/expocity/expocity-2.6.2.1.ebuild,v 1.2 2004/01/05 18:31:26 dertobi123 Exp $

inherit gnome2

DESCRIPTION="Gnome default windowmanager"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="http://www.pycage.de/download/expocity-2.6.2-1.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

S=${WORKDIR}/${PN}-2.6.2-1

# not parallel-safe; see bug #14405
MAKEOPTS="${MAKEOPTS} -j1"

# sharp gtk dep is for a certain speed patch
RDEPEND="
	>=x11-libs/pango-1.2
	>=x11-libs/gtk+-2.2.0-r1
	>=gnome-base/gconf-2
	>=x11-libs/startup-notification-0.4"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.21
	!x11-wm/metacity"

DOCS="AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README README.expocity"
