# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/gnome-extra/gnome-system-tools/gnome-system-tools-0.28.0.ebuild,v 1.1 2003/10/17 12:40:42 elefantenfloh Exp $

# fixme
addwrite /usr/share/gnome-system-tools
addwrite /usr/share/setup-tool-backends

inherit gnome2

IUSE=""
DESCRIPTION="The Gnome-System-Tools are a fully integrated set of tools aimed to make easy the job that means the computer administration on an UNIX or Linux system."
HOMEPAGE="http://www.gnome.org/projects/gst/"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/sources/gnome-system-tools/0.28/${P}.tar.bz2"

SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"

RDEPEND=">=x11-libs/gtk+-2.2
	>=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/gnome-vfs-2.2
	>=dev-libs/libxml2-2.5.8
	>=gnome-base/gconf-2.2"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.20
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog COPYING*  README* INSTALL NEWS"



