# Copyright 2004 Christian Gmeiner <christian at visual-page dot de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-pim/vdrplugin-pim-0.0.1.ebuild,v 1.2 2004/08/12 18:39:43 austriancoder Exp $

IUSE=""
inherit vdrplugin

DESCRIPTION="Video Disk Recorder PIM Plugin"
HOMEPAGE="http://tuffi.privat.t-online.de/vdr/"
SRC_URI="http://tuffi.privat.t-online.de/vdr/vdr-pim-${PV}.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.0"