# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/x11-themes/gnome-themes-extras/gnome-themes-extras-0.1.ebuild,v 1.1 2003/06/13 15:14:40 elefantenfloh Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Some extra gnome 2 meta-themes"
HOMEPAGE="http://www.gnome.org/~uraeus/"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/gnome-themes-extras/${PV}/${P}.tar.bz2"

SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"

RDEPEND=">=x11-libs/gtk+-2.2"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.23"

DOC="AUTHORS COPY* README INSTALL NEWS ChangeLog"
