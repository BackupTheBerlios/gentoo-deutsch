# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdr/Attic/vdr-1.2.6-r2.ebuild,v 1.1 2003/12/12 12:58:22 rootshell Exp $

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
		http://www.muempf.de/down/${AC3_OVER_DVB}.diff.gz						http://www.vdr-portal.de/download/patches/Komplettpatch-1.2.6.diff.bz2
		http://linvdr.org/download/VDR-AIO/vdr-${ELCHI_VN}-ElchiAIO3c.diff.gz
		"
#		http://www.akool.de/download/vdr-${AKOOL_VN}.patch.bz2


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
# function to implement a "local" use variable called VDR_OPTS
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
do_patch() {
	if [ -z $1 ]
	then
		echo "No parameters passed to do_patch() - bad."
		return 1
	else
		case $1 in
			ac3)
				einfo "Apply AC3 patch ..."
				epatch ../${AC3_OVER_DVB}.diff
				;;
			akool)
				einfo "Apply akool patch ..."
				patch -p1 < ../Komplettpatch-1.2.6.diff
				;;
			elchi)
				cd ${S}
				einfo "Apply ElchiAOI3c patch ..."
				patch < ../vdr-${ELCHI_VN}-ElchiAIO3c.diff
				;;
			*)
				einfo "Don't know, what to do"
		esac
	fi
}

src_unpack() {
	echo
	einfo "Please note that we do not use C[XX]FLAGS from /etc/make.conf"
	einfo "or the environment from now on."
	einfo "some Gentoo C[XX]FLAGS are known to break the build, so this is safer"
	echo
	echo -ne "\a" ; sleep 0.1 &>/dev/null ; sleep 0,1 &>/dev/null
	echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 &>/dev/null ; sleep 0,1 &>/dev/null
	echo -ne "\a" ; sleep 1
	sleep 4
	einfo
	einfo "VDR_OPTS: $VDR_OPTS"
	einfo
	unpack ${A}
	cd ${S}
###
	if vdr_opts ac3
	then
		if ! vdr_opts akool
		then
			do_patch ac3
		else
			ewarn "ac3 patch is already part of akool patch - skipping"
		fi
	fi
	if vdr_opts akool
	then
		if ! vdr_opts elchi
		then
			do_patch akool
		else
			eerror "elchi patch is already part of akool patch"
			eerror "You should give me elchi or akool; not both"
			exit 1
		fi
	fi
	if vdr_opts elchi
	then
		if ! vdr_opts akool;
		then
			do_patch elchi
		else
			eerror "akool patch is already part of elchi patch"
			eerror "You should give me elchi or akool, not both"
			exit 1
		fi
	fi
	# AC3 over DVB Patch
	# needs app-admin/fam-oss

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
	unset CFLAGS CXXFLAGS
	local myconf
	use lirc && myconf="${myconf} REMOTE=LIRC"
	vdr_opts rcu && myconf="${myconf} REMOTE=RCU"
	vdr_opts vfat && myconf="${myconf} VFAT=1"

	make ${myconf} || die "compile problem vdr"

	# solves different weird behaviour, and is generally a good idea...
	einfo "setting up modules build environment"
	mkdir -p include/vdr
	(cd include/vdr; for i in ../../*.h; do ln -sf $i .; done)
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