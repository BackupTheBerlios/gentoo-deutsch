# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-femon/vdrplugin-femon-0.1.4.ebuild,v 1.2 2004/08/11 13:34:57 austriancoder Exp $

inherit vdrplugin

DESCRIPTION="DVB Frontend Status Monitor plugin for VDR"
HOMEPAGE="http://www.saunalahti.fi/~rahrenbe/vdr/femon/"
SRC_URI="http://www.saunalahti.fi/~rahrenbe/vdr/femon/files/vdr-${VDRPLUGIN}-${PV}.tgz"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.7"

