# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrconvert/vdrconvert-0.1.1.ebuild,v 1.3 2004/08/03 12:55:40 austriancoder Exp $

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

VDRCONVERTUSER=vdr


DEPEND=">=media-video/vdr-1.2.0
	>=mplayer-0.91
	>=vdrsync-1.2.2
	>=dvdauthor-0.6.0
	>=gozer-0.7
	>=lame-3.93.1-r2
	>=transcode-0.6.5
	>=mjpegtools-1.6.1
	>=requant-0.0.1
	>=alsa-utils-0.9.2
    	>=sudo-1.6.5
	>=cdrtools-1.1
	>=imlib2-1.1.0
	>=libdvb-0.5.0-r1
	>=mpg123-0.59r-r3
	>=netpbm-9.12-r4
	>=freetype-2.1.4
	>=tosvcd-0.9-r2
	>=cdlabelgen-0.3.0
	>=app-cdr/dvd+rw-tools-5.13.4.7.4
"

# not needed - or?
#VDRVERSION=$(awk -F'"' '/VDRVERSION/ {print $2}' /usr/include/vdr/config.h )

src_unpack() {
	unpack ${A}
	#getting some configuration variables
	if [ "$(grep VIDEO /etc/conf.d/vdr)" ]; then
	    VDRDATADIR=$(grep VIDEO /etc/conf.d/vdr|cut -d "\"" -f 2)
	else
    	    VDRDATADIR="/video"
	fi
	einfo Video- Directory is: $VDRDATADIR
	HOMEDIR=`cat /etc/passwd|grep "^${VDRCONVERTUSER}:"|cut -f6 -d ':'`
	einfo "home dirctory of vdrconvert-user $VDRCONVERTUSER is $HOMEDIR"
	cp ${FILESDIR}/${SCRIPT}-${PV}.env	${S}/etc/vdrconvert.env
	cd ${S}/bin
	patch -i ${FILESDIR}/vdr2dvd-0.1.1-fix-label.diff vdr2dvd.sh
	patch -i ${FILESDIR}/vdr2divx-0.1.1-fix.diff vdr2divx.sh
}

src_compile() {
	cd ${WORKDIR}/${PANTELTJE}
	patch -i ${S}/doc/patches/${PANTELTJE}.patch
	einfo ${S}
	cd ${S}
	sed -i "s:VDRCONVERTDIR=/etc/vdr/vdrconvert:VDRCONVERTDIR=${CONV_DIR}:" ./doc/init/vdrconvert.gentoo
	sed -i 's:# su - $CONV_USER -c "(cd $VDRCONVERTDIR;./bin/vdrconvert.sh)" > $LOGFILE 2>&1 &: su - $CONV_USER -c "(cd $VDRCONVERTDIR;./bin/vdrconvert.sh)" > $LOGFILE 2>\&1 \&:' ./doc/init/vdrconvert.gentoo
	sed -i 's:su - $CONV_USER -c "(cd $VDRCONVERTDIR;./bin/vdrconvert.sh 2>/dev/null) &>/dev/tty2 &":# su - $CONV_USER -c "(cd $VDRCONVERTDIR;./bin/vdrconvert.sh 2>/dev/null) \&>/dev/tty2 \&":' ./doc/init/vdrconvert.gentoo

	mv ./doc/init/vdrconvert.gentoo ./doc/init/vdrconvert
	sed -i "s:VDRCONVERTDIR=/var/vdr/vdrconvert:VDRCONVERTDIR=${CONV_DIR}:"  ./etc/vdrconvert.env 
	sed -i "s:VDRROOT=/video:VDRROOT=${VDRDATADIR}:" ./etc/vdrconvert.env
	cp ${FILESDIR}/VDRconvert-reccmds.conf ./etc/reccmds.conf
	cp ${FILESDIR}/VDRconvert-en-reccmds.conf ./etc/reccmds-en.conf
	sed -i "s:/var/tmp/vdrconvert:${CONV_DIR}:g" ./etc/reccmds.conf
	sed -i "s:/var/tmp/vdrconvert:${CONV_DIR}:g" ./etc/reccmds-en.conf
	cp ${FILESDIR}/VDRConvert-commands.conf ./etc/commands.conf
	sed -i "s:/var/tmp/vdrconvert:${CONV_DIR}:g" ./etc/commands.conf
	cd ${WORKDIR}/${PANTELTJE}
	make
}
	
src_install() {
	exeinto /usr/bin
	doexe ${WORKDIR}/${PANTELTJE}/tcmplex-panteltje
	exeinto /etc/init.d
	doexe ./doc/init/vdrconvert
	exeinto	${CONV_DIR}/bin
	doexe bin/*
	insinto /etc/vdr
	doins etc/commands.conf
	doins etc/reccmds.conf
	doins etc/reccmds-en.conf
	insinto /etc/conf.d
	doins etc/vdrconvert.env
	insinto ${CONV_DIR}/share/vdrconvert/fonts/truetype
	doins ./share/vdrconvert/fonts/truetype/* 
	insinto ${CONV_DIR}/share/vdrconvert/images
	doins ./share/vdrconvert/images/* 
	insinto ${CONV_DIR}/share/vdrconvert/postscript
	doins ./share/vdrconvert/postscript/* 
	insinto ${CONV_DIR}/share/vdrconvert/pva
	doins ./share/vdrconvert/pva/* 
	insinto ${CONV_DIR}/share/pX
	doins ./share/vdrconvert/pX/* 
	dodir /var/run/vdrconvert
	keepdir /var/run/vdrconvert
	fowners vdr:video /var/run/vdrconvert
	dodir /var/log/vdrconvert
	keepdir /var/log/vdrconvert
	fowners vdr:video /var/log/vdrconvert
	dodir /var/spool/vdrconvert
	keepdir /var/spool/vdrconvert
	fowners vdr:video /var/spool/vdrconvert
#	dodoc README README.EN README.GR minihowto
}

pkg_postinst() {
	einfo "setting rights in vdrconvert dir"
#	[ -d /var/run/vdrconvert ] || mkdir /var/run/vdrconvert && fowners vdr:video /var/run/vdrconvert
#	[ -d /var/spool/vdrconvert ] || mkdir /var/spool/vdrconvert && fowners vdr:video /var/spool/vdrconvert
#	[ -d /var/log/vdrconvert ] || mkdir /var/log/vdrconvert && fowners vdr:video /video

	fowners vdr:video ${CONV_DIR}
	fowners vdr:video /var/log/vdrconvert
#	ln -s ${CONV_DIR} /etc/vdr/vdrconvert
	[ -d $HOMEDIR/.vdrconvert ]  ||  mkdir $HOMEDIR/.vdrconvert
	[ -f $HOMEDIR/.vdrconvert/vdrconvert.env ] && mv $HOMEDIR/.vdrconvert/vdrconvert.env $HOMEDIR/.vdrconvert/vdrconvert.env.bak
	[ -h $HOMEDIR/.vdrconvert/vdrconvert.env ] || ln -s /etc/conf.d/vdrconvert.env $HOMEDIR/.vdrconvert/vdrconvert.env
	einfo
	einfo "you have to create a destination directory and to set DESTDIR in"
	einfo "/etc/conf.d/vdrconvert.env"
	einfo "accordingly"
	einfo "Please make sure, that the user vdr can write to the destination directory"
	einfo "You should also run 'rc-update add /etc/init.d/vdrconvert default'"
	einfo
}
