# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrskin-elchi/vdrskin-elchi-0.0.1.ebuild,v 1.1 2004/08/02 12:45:27 austriancoder Exp $

IUSE=""

SKINNAME=elchi
SKINDIR=/usr/share/vdr/skins/${PN}
USERID=10019

S=${WORKDIR}/${SKINNAME}
DESCRIPTION="Video Disk Recorder ${SKINNAME} skin"
HOMEPAGE="http://www.vdrskins.org"
SRC_URI="http://web.vdrskins.org/vdrskins/albums/userpics/${USERID}/vdrskin-elchi-0.0.1pre6a.tar.gz"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdrplugin-text2skin-0.0.8"

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
