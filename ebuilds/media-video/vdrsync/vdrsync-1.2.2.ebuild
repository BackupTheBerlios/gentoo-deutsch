# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrsync/vdrsync-1.2.2.ebuild,v 1.1 2003/11/09 09:38:05 fow0ryl Exp $

IUSE=""
S=${WORKDIR}/vdrsync-0.${PV}
DESCRIPTION="Video Disk Recorder VDRSYNC Script"
HOMEPAGE="http://vdrsync.vdr-portal.de/"
SRC_URI="http://vdrsync.vdr-portal.de/releases/vdrsync-0.${PV}.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.0
	>=perl-5.8.0-r12"


src_unpack() {
	unpack ${A}
}

src_compile() {
#	sed -i "s/^declare CFGFIL.*$/declare CFGFIL=\"\/etc\/vdr\/mplayer.sh.conf\"/"  mplayer.sh
#	sed -i "s/^MPLAYER.*$/MPLAYER=\/usr\/bin\/mplayer/"  mplayer.sh.conf
#	sed -i "s/^LIRCRC.*$/LIRCRC=\/etc\/lircd.conf/"  mplayer.sh.conf
	einfo "no compile needed"
}

src_install() {
	exeinto	/usr/bin
	doexe vdrsync.pl
}

pkg_postinst() {
	einfo
	einfo "for aditional info visit http://hierling.de/~martin/vdr/"
	einfo
	}
