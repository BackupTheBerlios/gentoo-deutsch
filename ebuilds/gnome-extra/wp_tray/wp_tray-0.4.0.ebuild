# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/gnome-extra/wp_tray/Attic/wp_tray-0.4.0.ebuild,v 1.1 2003/10/02 22:40:44 dertobi123 Exp $

inherit gnome2

DESCRIPTION="Wallpaper Manager for the Gnome Desktop"
HOMEPAGE="http://earthworm.no-ip.com/wp_tray/"

SRC_URI="http://earthworm.no-ip.com/wp_tray/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2
	>=x11-libs/gtk+-2
	>=gnome-base/libglade-2"

DEPEND="${RDEPEND}
	 dev-util/pkgconfig"

DOCS="AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README* TODO"
