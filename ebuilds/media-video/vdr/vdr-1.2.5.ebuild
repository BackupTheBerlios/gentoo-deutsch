# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdr/Attic/vdr-1.2.5.ebuild,v 1.3 2003/09/23 18:22:20 martini Exp $

IUSE="lirc"
#ANALOGTV_VN="0.9.8"
#AC3_OVER_DVB="vdr-1.2.0-AC3overDVB-0.2.0"
AKOOL_VN="1.2.5"
ELCHI_VN="1.2.5"

S=${WORKDIR}/vdr-${PV}
DESCRIPTION="The Video Disk Recorder"
HOMEPAGE="http://linvdr.org/"
SRC_URI="
		ftp://ftp.cadsoft.de/vdr/vdr-${PV}.tar.bz2
		http://www.akool.de/download/vdr-${AKOOL_VN}.patch.bz2
		http://linvdr.org/download/VDR-AIO/vdr-${ELCHI_VN}-ElchiAIO3b.diff.gz
		"


KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
		virtual/linux-sources
		>=linuxtv-dvb-1.0.0
		media-libs/jpeg
		sys-libs/ncurses
		app-admin/sudo
		app-admin/fam-oss
		lirc? ( app-misc/lirc )
		"

#
# function to implement a "local" use variable called VDR_OPTS
#
function vdr_opts {
	local x
	for x in ${VDR_OPTS}
	do
		if [ "${x}" = "${1}" ]
		then
			return 0
		fi
	done
	ewarn "No optional ${1} in VDR_OPTS"
	return 1
}


src_unpack() {
	einfo
	einfo "VDR_OPTS: $VDR_OPTS"
	einfo

	unpack ${A}
	cd ${S}

#
# no ac3oDVB yet, commented out by mad
#	# AC3 over DVB Patch
#	# needs app-admin/fam-oss
#	if vdr_opts ac3; then
#		if vdr_opts akool; then
#			ewarn "ac3 patch is already part of akool patch ... skipping"
#		fi
#		einfo "Apply AC3 patch ..."
#		epatch ../${AC3_OVER_DVB}.diff
#	fi

	# Akool Patch
	if vdr_opts akool; then
		if vdr_opts elchi; then
			ewarn "elchi patch is already part of akool patch ... skipping"
		fi
		einfo "Apply akool patch ..."
		epatch ../vdr-${AKOOL_VN}.patch
	fi

	# Elchi Patch
	if vdr_opts elchi; then
		if ! vdr_opts akool; then
		cd ${S}
			einfo "Apply ElchiAOI3b patch ..."
			patch < ../vdr-${ELCHI_VN}-ElchiAIO3b.diff
		fi
	fi


#
# by mad, no yet ready
#	# AnalogTV Patch
#	if vdr_opts analogtv; then
#		einfo "Apply AnalogTV patch ..."
#		patch -p1 < ${WORKDIR}/analogtv-${ANALOGTV_VN}/patches/vdr.patch
#	fi

	epatch ${FILESDIR}/vdr-${PV}-gentoo.diff
}

src_compile() {
	local myconf
	use lirc && myconf="${myconf} REMOTE=LIRC"
	vdr_opts rcu && myconf="${myconf} REMOTE=RCU"
	vdr_opts vfat && myconf="${myconf} VFAT=1"

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
		newins ${S}/PLUGINS/src/${i}/libvdr-${i}.so libvdr-${i}.so.${PV}
		dosym /usr/lib/vdr/libvdr-${i}.so.${PV} /usr/lib/vdr/libvdr-${i}.so
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

	rm Make.config.template
	insopts -m0644 -ovdr -gvideo
	insinto /etc/vdr
	doins [a-z]*.conf*
	fowners vdr /etc/vdr
	insinto /etc/vdr/plugins/.keep
	fowners vdr /etc/vdr/plugins
}

pkg_setup(){
	# temp userid 270 until got one from gentoo.org
	if ! grep -q "^vdr:" /etc/passwd ; then
		useradd -u 270 -g video -G audio,cdrom -d /video -s /bin/bash -c "VDR Daemon" vdr
		einfo "adding vdr user"
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