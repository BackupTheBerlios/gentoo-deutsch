# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-vcd/vdrplugin-vcd-0.0.6c-r1.ebuild,v 1.2 2004/08/11 13:32:12 austriancoder Exp ${VDRPLUGIN}/vdr-${VDRPLUGIN}-0.0.4i.ebuild,v 1.1 2003/05/12 18:01:14 fow0ryl Exp $

IUSE=""

inherit vdrplugin

HOMEPAGE="http://vdr.heiligenmann.de/"
SRC_URI=" http://vdr.heiligenmann.de/download/vdr-${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.6"

src_unpack() {
	vdrplugin_src_unpack

	if has_version ">=media-video/vdr-1.3.7" ;
	then
		einfo "Applying ${VDRPLUGIN}-${PV}-1.3.7 patch"
		cd ${S}
		patch -R < ${FILESDIR}/${VDRPLUGIN}-${PV}-1.3.7.diff

	fi
}

