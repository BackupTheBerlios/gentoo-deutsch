# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/hoerzu2vdr/hoerzu2vdr-0.4.3.ebuild,v 1.1 2004/07/14 00:22:12 austriancoder Exp $

DESCRIPTION="The Kaffeine media player for KDE3 based on xine-lib."
SRC_URI="http://www.wontorra.net/filemgmt_data/files/${P}.tar.gz"
HOMEPAGE="http://www.wontorra.net"
LICENSE="GPL-2"
IUSE=""
DEPEND=""
SLOT="0"
KEYWORDS="~x86"

src_unpack() {
	unpack ${A}
}

src_install() {
	# binary
	insinto /etc/vdr/hoerzu2vdr
	diropts -m0750
	doins *.jar *.sh

	# config files
	doins *.conf channels.conf.example

	# doku
	dodoc COPYING HISTORY README

	# data folder
	dodir /etc/vdr/hoerzu2vdr/data
}

pkg_postinst() {
	einfo
	einfo "hoerzu2vdr is ready to use :)"
	einfo "But first you must check the"
	einfo "configfiles in /etc/vdr/hoerzu2vdr"
	einfo
}