# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrskin-egalsnxt/vdrskin-egalsnxt-0.0.0-r4.ebuild,v 1.1 2004/07/25 01:18:27 austriancoder Exp $

IUSE=""

SKINNAME=EgalsNxt
SKINDIR=/usr/share/vdr/skins/${PN}
USERID=10007

S=${WORKDIR}/${SKINNAME}
DESCRIPTION="Video Disk Recorder ${VDRPLUGIN} Plugin"
HOMEPAGE="http://moldaner.de"
SRC_URI="http://web.vdrskins.org/vdrskins/albums/userpics/${USERID}/Skin-EgalsNxt-Pre4.tar.gz"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdrplugin-text2skin-0.0.7"

src_unpack() {
	unpack ${A}
}

src_install() {
	# copy skin content to SKINDIR
	dodir /etc/vdr/plugins/text2skin
	dodir ${SKINDIR}
	cp -r ${S}/* ${D}${SKINDIR}
}

pkg_postinst() {
	
	# create symbolic link
	ln -s ${SKINDIR} /etc/vdr/plugins/text2skin/${SKINNAME}

	einfo
	einfo "Skin was installed to:"
	einfo ${SKINDIR}
	einfo
	echo
	einfo
	einfo "You need now the (re)start vdr and select the"
	einfo "in the osd-setting menu."
	einfo
	echo
}
