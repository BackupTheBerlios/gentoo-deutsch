# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdr/Attic/vdr-1.2.6-r3.ebuild,v 1.3 2003/12/14 11:47:45 fow0ryl Exp $

IUSE="lirc"
#ANALOGTV_VN="0.9.8"
AC3_OVER_DVB="vdr-1.2.6-AC3overDVB-0.2.3"
AKOOL_VN="1.2.6"
ELCHI_VN="1.2.6"

S=${WORKDIR}/vdr-${PV}
DESCRIPTION="The Video Disk Recorder"
HOMEPAGE="http://linvdr.org/"
SRC_URI="
		ftp://ftp.cadsoft.de/vdr/vdr-${PV}.tar.bz2
		http://www.muempf.de/down/${AC3_OVER_DVB}.diff.gz
		http://www.vdr-portal.de/download/patches/KomplettPatch-1.2.6-C.diff.bz2
		http://linvdr.org/download/VDR-AIO/vdr-${ELCHI_VN}-ElchiAIO3c.diff.gz
		http://www.magoa.net/linux/files/improvedosd-1a.diff.gz
		http://www.magoa.net/linux/files/icons.tar.gz
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
		app-admin/fam
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

	# AC3 over DVB Patch
	# needs app-admin/fam-oss
	if vdr_opts ac3
	then
		if vdr_opts akool
		then
			ewarn "ac3 patch is already part of akool patch ... skipping"
		else
			einfo "Apply AC3 patch ..."
			epatch ../${AC3_OVER_DVB}.diff
		fi
	fi

	# Elchi Patch
	if vdr_opts elchi
	then
		if vdr_opts akool
		then
			ewarn "elchi patch is already part of akool patch ... skipping"
		else
			cd ${S}
			einfo "Apply ElchiAOI3b patch ..."
			patch < ../vdr-${ELCHI_VN}-ElchiAIO3c.diff
			if vdr_opts iosd
			then
				epatch ../improvedosd-1a.diff
				ln -s ${WORKDIR}/icons/ ${S}/icons
			fi
		fi
	fi

	# Akool Patch
	if vdr_opts akool
	then
		einfo "Apply akool patch ..."
		patch -p1 < ../KomplettPatch-1.2.6-C.diff
		epatch ${FILESDIR}/vdr-${PV}-scanner-gentoo.diff
	fi

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
	newins ${FILESDIR}/rc.vdrwatchdog vdrwatchdog

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
	doexe ${FILESDIR}/vdrwatchdog.sh

	rm Make.config.template
	insopts -m0644 -ovdr -gvideo
	insinto /etc/vdr
	doins [a-z]*.conf*
	fowners vdr /etc/vdr
	insinto /etc/vdr/plugins/.keep
	fowners vdr /etc/vdr/plugins
	insinto /etc/vdr/icons
	doins ${S}/icons/*.logo
	fowners vdr /etc/vdr/icons
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
	# add fam to /etc/init.d/vdr if patched with akool
	if vdr_opts akool; then
		sed -i '/need fam/d' /etc/init.d/vdr
		sed -i '/^depend/a\
		need fam' /etc/init.d/vdr
	fi

	einfo
	einfo "Congratulations, you have just installed VDR,"
	einfo "The Digital Video Recorder. To get started you"
	einfo "should read, read, read ..."
	einfo "A good starting point seems to be:"
	einfo "http://vdr.gentoo.de/ and "
	einfo "http://www.vdrportal.de/board/board.php?boardid=56"
	einfo "Remeber that you have to recompile plugins, if you are"
	einfo "upgrading your vdr version, i.e. 1.2.5 to 1.2.6 "
	einfo
}
