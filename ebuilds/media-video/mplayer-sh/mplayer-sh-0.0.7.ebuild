# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/mplayer-sh/mplayer-sh-0.0.7.ebuild,v 1.3 2004/08/14 02:23:45 austriancoder Exp $

IUSE=""

S=${WORKDIR}/mplayer-sh-0.0.7
DESCRIPTION="Video Disk Recorder Mplayer Script"
HOMEPAGE="http://batleth.sapienti-sat.org/"
SRC_URI="http://batleth.sapienti-sat.org/projects/VDR/old/mplayer.sh-007.tar.gz"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="media-video/vdr media-video/mplayer"

# not needed - or?
#VDRVERSION=$(awk -F'"' '/VDRVERSION/ {print $2}' /usr/include/vdr/config.h )

src_unpack() {
	mkdir ${S}
	tar xfvz ${DISTDIR}/${A} -C ${S}
}

src_compile() {
	sed -i "s/^declare CFGFIL.*$/declare CFGFIL=\"\/etc\/vdr\/mplayer.sh.conf\"/"  mplayer.sh
	sed -i "s/^MPLAYER.*$/MPLAYER=\/usr\/bin\/mplayer/"  mplayer.sh.conf
}

src_install() {
	insinto /etc/vdr
	doins mplayer.sh.conf
	exeinto	/usr/bin
	doexe mplayer.sh
}
