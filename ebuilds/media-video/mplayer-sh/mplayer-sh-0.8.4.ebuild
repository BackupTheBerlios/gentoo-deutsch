# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/mplayer-sh/mplayer-sh-0.8.4.ebuild,v 1.3 2004/08/14 02:23:45 austriancoder Exp $

IUSE=""

S=${WORKDIR}/mplayer-sh-${PV}
DESCRIPTION="Video Disk Recorder Mplayer Script"
HOMEPAGE="http://batleth.sapienti-sat.org/"
SRC_URI="http://batleth.sapienti-sat.org/projects/VDR/mplayer.sh-${PV}.tar.gz"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.0
	>=media-video/mplayer-0.90_rc4"

# not needed - or?
#VDRVERSION=$(awk -F'"' '/VDRVERSION/ {print $2}' /usr/include/vdr/config.h )

src_unpack() {
	mkdir ${S}
	tar xfvz ${DISTDIR}/${A} -C ${S}
}

src_compile() {
	sed -i "s/^declare CFGFIL.*$/declare CFGFIL=\"\/etc\/vdr\/mplayer.sh.conf\"/"  mplayer.sh
	sed -i "s/^MPLAYER=.*$/MPLAYER=\/usr\/bin\/mplayer/"  mplayer.sh.conf
	sed -i "s/^LIRCRC.*$/LIRCRC=\/etc\/lircd.conf/"  mplayer.sh.conf
}

src_install() {
	insinto /etc/vdr
	doins mplayer.sh.conf
	exeinto	/usr/bin
	doexe mplayer.sh
}

pkg_postinst() {
	einfo
	einfo "for aditional info visit http://hierling.de/~martin/vdr/"
	einfo
	}
