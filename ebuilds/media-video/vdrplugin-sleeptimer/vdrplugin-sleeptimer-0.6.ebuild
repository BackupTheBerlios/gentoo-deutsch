# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-sleeptimer/vdrplugin-sleeptimer-0.6.ebuild,v 1.1 2004/08/11 19:04:48 austriancoder Exp $

IUSE=""

inherit vdrplugin

DESCRIPTION="Video Disk Recorder Sleeptimer PlugIn"
HOMEPAGE="hhttp://linvdr.org/download/vdr-sleeptimer"
SRC_URI="http://linvdr.org/download/vdr-sleeptimer/${VDRPLUGIN}-${PV}.tar.gz"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.6"
