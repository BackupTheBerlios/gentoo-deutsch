# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-sound/net-rhythmbox/Attic/net-rhythmbox-0.4.8.ebuild,v 1.1 2003/06/16 11:15:57 elefantenfloh Exp $

inherit eutils gnome2

#fixme
addwrite /var/lib/scrollkeeper/

S="${WORKDIR}/${P}"
DESCRIPTION="RhythmBox - an iTunes clone for GNOME"
SRC_URI="http://web.verbum.org/net-rhythmbox/${P}.tar.gz"
HOMEPAGE="http://web.verbum.org/net-rhythmbox/"

IUSE="X gnome"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND=">=x11-libs/gtk+-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/gnome-panel-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libbonobo-2
	>=gnome-base/bonobo-activation-2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/gconf-1.2.1
	>=gnome-base/ORBit2-2.4.1
	>=sys-devel/gettext-0.11.1
	>=media-libs/gstreamer-0.6.1
	>=media-libs/gst-plugins-0.6.1
	>=media-libs/musicbrainz-2.0
	"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	dev-util/intltool"

