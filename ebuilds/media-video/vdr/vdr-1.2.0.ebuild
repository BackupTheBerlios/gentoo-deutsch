# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdr/Attic/vdr-1.2.0.ebuild,v 1.2 2003/06/04 11:26:13 mad Exp $

IUSE="lirc"

S=${WORKDIR}/${P}
DESCRIPTION="The Video Disk Recorder"
HOMEPAGE="http://linvdr.org/"
SRC_URI="ftp://ftp.cadsoft.de/vdr/${P}.tar.bz2
         http://www.akool.de/download/vdr-1.2.0.patch.bz2"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
		virtual/linux-sources
		>=linuxtv-dvb-1.0.0_pre2-r20030524
		media-libs/jpeg
		sys-libs/ncurses
		lirc? ( app-misc/lirc )
		"

function vdr_opts {
	#test -z $1 && return 1
	echo ${VDR_OPTS} | grep --silent $1 && return 0
	return 1
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff

	# needs app-admin/fam-oss
	vdr_opts akool && epatch ../vdr-1.2.0.patch
}

src_compile() {
	local myconf
	use lirc && myconf="${myconf} REMOTE=LIRC"
	vdr_opts rcu && myconf="${myconf} REMOTE=RCU"
	vdr_opts vdr_vfat && myconf="${myconf} VFAT=1"

	make ${myconf} || die "compile problem vdr"

	for i in $(ls ${S}/PLUGINS/src) ; do
		cd ${S}/PLUGINS/src/${i}
		make all ||die "compile problem plugin: ${i}"
	done
		
}

src_install() {
	insopts -m0644
	insinto /etc/conf.d
	newins ${FILESDIR}/confd vdr
	insinto /etc/init.d
	insopts -m0755
	newins ${FILESDIR}/rc.vdr vdr
	
	# need new watchdog
	#newins ${FILESDIR}/rc.vdrwatchdog vdrwatchdog
	# not tested
	#use lirc && newins ${FILESDIR}/rc.irexec irexec 
	
	dodoc CONTRIBUTORS COPYING README* INSTALL MANUAL HISTORY* UPDATE-1.2.0
	dodoc ${FILESDIR}/vdrshutdown.sh
	#dodoc ${FILESDIR}/sudo.txt
	dohtml PLUGINS.html
	doman vdr.[15] 

	dolib.a libdtv/libdtv.a
	dolib.a libdtv/liblx/liblx.a
	dolib.a libdtv/libsi/libsi.a
	dolib.a libdtv/libvdr/libvdr.a

	for i in $(ls ${S}/PLUGINS/src) ; do
		#cd ${i}
		insinto /usr/lib/vdr
		insopts -m0755
		newins ${S}/PLUGINS/src/${i}/libvdr-${i}.so libvdr-${i}.so
		dosym /usr/lib/vdr/libvdr-${i}.so /usr/lib/vdr/libvdr-${i}.so.1.2.0
	done
		

	insinto /usr/include/vdr
	doins *.h
	doins libdtv/liblx/liblx.h
	doins libdtv/libsi/si_debug_services.h
	doins libdtv/libsi/include/libsi.h
	doins libdtv/libsi/include/si_tables.h
	doins libdtv/libvdr/libvdr.h
	doins libdtv/libdtv.h

	exeinto /usr/bin
	doexe vdr
	doexe svdrpsend.pl
	#doexe ${FILESDIR}/vdrwatchdog.sh 

	rm Make.config.template
	insopts -m0644 -ovdr -gvideo
	insinto /etc/vdr
	doins [a-z]*.conf*
	fowners vdr /etc/vdr
}

pkg_preinst(){
	einfo "adding vdr user"
	# temp userid 270 until got one from gentoo.org
	if ! grep -q ^vdr: /etc/passwd ; then
		useradd -u 270 -g video -G audio,cdrom -d /video -s /bin/bash -c "VDR Daemon" vdr
	fi
}

pkg_postinst() {
	# test -d /video && mkdir /video
	einfo
	einfo "Congratulations, you have just installed VDR,"
	einfo "The Digital Video Recorder. To get started you"
	einfo "should read, read, read ..."
	einfo "A good starting point seems to be:"
	einfo "http://vdr.gentoo.de/ and "
	einfo "http://www.vdrportal.de/board/board.php?boardid=56"
	einfo
}

#pkg_postrm() {
	#einfo "removing vdr user"
	#userdel vdr
#}

