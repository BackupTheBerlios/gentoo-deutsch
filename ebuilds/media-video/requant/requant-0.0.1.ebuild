# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /cvsroot/gentoo-deutsch/ebuilds/media-video/requant

IUSE=""
REQUANT="M2VRequantizer"
REQUANT_VN="20030925"
JAU_FILE="repackmpeg2-v0.9"

S=${WORKDIR}/${JAU_FILE}
DESCRIPTION="Video Disk Recorder Mplayer Script"
HOMEPAGE="http://www.jausoft.com"
SRC_URI="http://www.jausoft.com/Files/vdr/repackmpeg2/${JAU_FILE}.tar.bz2
	"
	 
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=""
	
# not needed - or?
#VDRVERSION=$(awk -F'"' '/VDRVERSION/ {print $2}' /usr/include/vdr/config.h )

src_unpack() {
	unpack ${A}
	tar xjfv ${S}/${REQUANT}-${REQUANT_VN}.tar.bz2
}

src_compile() {
#	einfo ${CFLAGS}
	cd ${WORKDIR}/${REQUANT}-${REQUANT_VN}/src
	gcc -c ${CFLAGS} main.c -o requant.o
	gcc ${CFLAGS} requant.o -o requant -lm
}

src_install() {
	exeinto /usr/bin
	doexe ${WORKDIR}/${REQUANT}-${REQUANT_VN}/src/requant
}

pkg_postinst() {
	einfo
	einfo "requant has been installed in /usr/bin"
	einfo ""
	einfo
	}
