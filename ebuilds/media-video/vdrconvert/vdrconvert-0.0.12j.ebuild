# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrconvert/vdrconvert-0.0.12j.ebuild,v 1.3 2004/08/03 12:55:40 austriancoder Exp $

IUSE=""
SCRIPT="vdrconvert"
PANTELTJE="tcmplex-panteltje-0.3"
CONV_DIR="/var/vdr/vdrconvert"

S=${WORKDIR}/${SCRIPT}-${PV}
DESCRIPTION="Video Disk Recorder VDRconvert Script"
HOMEPAGE="http://vdrconvert.vdr-portal.de/"
SRC_URI="http://vdrconvert.vdr-portal.de/releases/${SCRIPT}-${PV}.tar.bz2
	 http://www.ibiblio.org/pub/Linux/apps/video/${PANTELTJE}.tgz"
	 
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.0
	>=mplayer-0.91
	>=vdrsync-1.2.2
	>=dvdauthor-0.5.0
	>=gozer-0.7
	>=lame-3.93.1-r2
	>=transcode-0.6.5
	>=mjpegtools-1.6.1
	>=requant-0.0.1
	>=alsa-utils-0.9.2
    	>=sudo-1.6.5
	>=at-3.1.8
	>=cdrtools-1.1
	>=imlib2-1.0.6-r1
	>=libdvb-0.5.0-r1
	>=mpg123-0.59r-r3
	>=netpbm-9.12-r4
	>=freetype-2.1.4
	>=tosvcd-0.9-r2
"
	
# not needed - or?
#VDRVERSION=$(awk -F'"' '/VDRVERSION/ {print $2}' /usr/include/vdr/config.h )

src_unpack() {
	unpack ${A}
}

src_compile() {
	cd ${WORKDIR}/${PANTELTJE}
	epatch ${S}/patches/${PANTELTJE}.patch
	einfo ${S}
	cd ${S}
#	sed -i "s/^VDRCONVERTDIR=\/etc\/vdr\/vdrconvert *$/VDRCONVERTDIR=${CONV_DIR}/"  ./init/vdrvonvert.gentoo
#	sed -i "s/. .\/vdrconvert.env/\/etc\/conf.d\/vdrconvert.env/" vdrconvert.sh
	sed -i "s/\/vdrconvert\/etc/\/vdrconvert/"  ./etc/vdrconvert.env
	cd ${WORKDIR}/${PANTELTJE}
	make
}

src_install() {
	exeinto /usr/bin
	doexe ${WORKDIR}/${PANTELTJE}/tcmplex-panteltje
	exeinto /etc/init.d
	doexe ${FILESDIR}/vdrconvert
	exeinto	${CONV_DIR}
	doexe add.sh
	doexe burn.sh
	doexe cap.sh
	doexe cdlabelgen
	doexe del.sh
	doexe dvd2one.sh
	doexe dvdauthor_helperfunctions.sh
	doexe grab.sh
	doexe ins.sh
	doexe nq.sh
	doexe preview.sh
	doexe status.sh
	doexe vdr2ac3.sh
	doexe vdr2divx.sh
	doexe vdr2dvd.sh
	doexe vdr2mp3.sh
	doexe vdr2mpg.sh
	doexe vdr2svcd.sh
	doexe vdr2vcd.sh
	doexe vdrconvert.sh
	doexe writedvd.sh
	insinto /etc/vdr
	doins etc/commands.conf
	doins ${FILESDIR}/reccmds.conf
	insinto /etc/conf.d
	doins ./etc/vdrconvert.env
	insinto ${CONV_DIR}
	doins ./etc/silence-1s.mp2
	doins ./etc/vdrconvert.env.template
	insinto ${CONV_DIR}/fonts/truetype
	doins ./fonts/truetype/* 
	insinto ${CONV_DIR}/postscript
	doins ./postscript/*
	dodoc README README.EN README.GR minihowto
}

pkg_postinst() {
	einfo "setting rights in vdrconvert dir"
	chown vdr:video ${CONV_DIR}
	ln -s ${CONV_DIR} /etc/vdr/vdrconvert
	ln -s /etc/conf.d/vdrconvert.env ${CONV_DIR}/vdrconvert.env
	einfo
	einfo "you have to create a destination directory and to set DESTDIR in"
	einfo "/etc/vdr/vdrconvert/vdrconvert.env"
	einfo "accordingly"
	einfo "Please make sure, that the usr vdr can write to the destination directory"
	einfo "You should also run 'rc-update add /etc/init.d/vdrconvert default'"
	einfo
	}
