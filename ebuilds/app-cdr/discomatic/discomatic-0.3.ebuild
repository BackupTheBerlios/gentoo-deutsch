# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/app-cdr/discomatic/Attic/discomatic-0.3.ebuild,v 1.1 2003/10/19 09:00:15 dertobi123 Exp $

inherit gnome2

DESCRIPTION="GTK+ CD-ROM archiving tool for mastering and burning multiple CD-ROM"
HOMEPAGE="http://discomatic.sourceforge.net"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2"

DEPEND="${RDEPEND}
	 dev-util/pkgconfig"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README* TODO"

