# Copyright 2003 Henning Ryll <henning.ryll@web.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-vdrcd/vdrplugin-vdrcd-0.0.9.ebuild,v 1.2 2004/08/11 16:21:19 austriancoder Exp ${VDRPLUGIN}/vdr-${VDRPLUGIN}-0.0.7.ebuild,v 1.3 2003/04/15 08:18:24 fow0ryl Exp $


IUSE=""

inherit vdrplugin

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder Media Detection Plugin"
HOMEPAGE="http://www.magoa.net/linux"
SRC_URI="http://www.magoa.net/linux/files/vdr-${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.0"
