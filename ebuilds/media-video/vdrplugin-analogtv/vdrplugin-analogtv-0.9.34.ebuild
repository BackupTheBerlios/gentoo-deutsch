# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-analogtv/vdrplugin-analogtv-0.9.34.ebuild,v 1.1 2004/08/15 21:23:32 austriancoder Exp ${VDRPLUGIN}/vdr-${VDRPLUGIN}-0.5.0.ebuild,v 1.1 2003/05/03 14:48:26 fow0ryl Exp $

IUSE=""
VDRPLUGIN="analogtv"
inherit vdrplugin eutils

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder ${VDRPLUGIN} Plugin"
HOMEPAGE="http://akool.bei.t-online.de/"
SRC_URI="http://akool.bei.t-online.de/vdr/analogtv/download/vdr-${VDRPLUGIN}-${PV}.tar.bz2
	http://akool.bei.t-online.de/vdr/analogtv/download/rte-10mar03.tar.bz2"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.6
	>=media-libs/libdvb-0.5.4"

src_unpack() {
        vdrplugin_src_unpack

	cd ${S}
	ln -s ../rte rte

	cd ${S}/..
        epatch ${S}/patches/mp1e.patch

}

src_compile() {
	vdrplugin_src_compile
        cd ${S}/rte/mp1e
        econf
        emake
}

src_install() {
        vdrplugin_src_install

        cd ${S}/rte/mp1e
        doman mp1e.1
	docinto mp1e
        dodoc COPYING README BUGS ChangeLog
        insinto /usr/bin
        dobin mp1e
}
