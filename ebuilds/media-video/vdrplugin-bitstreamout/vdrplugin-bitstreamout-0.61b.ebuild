# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-bitstreamout/vdrplugin-bitstreamout-0.61b.ebuild,v 1.2 2004/08/11 13:58:42 austriancoder Exp $

IUSE=""

inherit vdrplugin

DESCRIPTION="Video Disk Recorder - BitStreamOut"
HOMEPAGE="http://bitstreamout.sourceforge.net"
SRC_URI="mirror://sourceforge/bitstreamout/vdr-${VDRPLUGIN}-${PV}.tar.bz2"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.6
	>=alsa-lib-0.9.8
	>=alsa-utils-0.9.8
	>=media-libs/libmad-0.14.2b-r2
	"

src_install() {
	vdrplugin_src_install

	doman vdr-bitstreamout.5
	dodoc ChangeLog Description PROBLEMS
	dodoc ${S}/doc/*

	insinto /usr/lib/vdr
	insopts -m0755
	doins ${S}/mute/*
}

