# Copyright 2004 Frederik Kunz <frederik.kunz@web.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-screenshot/vdrplugin-screenshot-0.0.5.ebuild,v 1.2 2004/08/11 13:40:42 austriancoder Exp $

IUSE=""
inherit vdrplugin

DESCRIPTION="Video Disk Recorder Screenshot PlugIn"
HOMEPAGE="http://www.joachim-wilke.de/vdr.html"
SRC_URI="http://www.stud.uni-karlsruhe.de/~upi9/vdr/vdr-${VDRPLUGIN}-${PV}.tar.bz2"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.9"

