# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/app-misc/wptray/wptray-0.4.2.ebuild,v 1.1 2003/10/06 10:47:55 dertobi123 Exp $

inherit gnome2

DESCRIPTION="Wallpaper Manager for the Gnome Desktop"
HOMEPAGE="http://earthworm.no-ip.com/wp_tray/"

SRC_URI="http://earthworm.no-ip.com/wp_tray/wp_tray-0.4.2.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2
	>=x11-libs/gtk+-2
	>=gnome-base/libglade-2"

DEPEND="${RDEPEND}
	 dev-util/pkgconfig"

S="${WORKDIR}/wp_tray-0.4.2"

DOCS="AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README* TODO"

