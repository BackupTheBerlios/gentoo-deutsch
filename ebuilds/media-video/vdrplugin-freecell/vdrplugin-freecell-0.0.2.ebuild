# Copyright 2003 Frederik Kunz <frederik.kunz@web.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-freecell/vdrplugin-freecell-0.0.2.ebuild,v 1.1 2004/08/14 15:50:10 austriancoder Exp $

IUSE=""
inherit vdrplugin

DESCRIPTION="Video Disk Recorder Freecell PlugIn"
HOMEPAGE="http://www.magoa.net/linux/index.php?view=freecell"
SRC_URI="http://www.magoa.net/linux/files/vdr-${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.6"

