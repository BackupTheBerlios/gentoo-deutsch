# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdr/vdr-1.3.9.ebuild,v 1.1 2004/06/01 12:49:11 austriancoder Exp $

IUSE="lirc"
#AC3_OVER_DVB="vdr-1.3.6-AC3overDVB-0.2.4"
#AKOOL="vdr-1.3.6.patch"
#ELCHI="vdr-1.3.6-ElchiAIO4d"

S=${WORKDIR}/vdr-${PV}
DESCRIPTION="The Video Disk Recorder"
HOMEPAGE="http://www.cadsoft.de/vdr/"
SRC_URI="
		ftp://ftp.cadsoft.de/vdr/Developer/vdr-${PV}.tar.bz2"

KEYWORDS="~x86 ~ppc"
SLOT="0"
LICENSE="GPL-2"

if [ "${KV:0:3}" == "2.6" ]
then
	einfo "Kernel 2.6.x detected"
	DEPEND="virtual/glibc
		media-libs/jpeg
		sys-libs/ncurses
		app-admin/sudo
		fam? ( app-admin/fam )
		lirc? ( app-misc/lirc )
		app-portage/gentoolkit
		"
fi

if [ "${KV:0:3}" == "2.4" ]
then
	einfo "Kernel 2.4.x detected"
	DEPEND="virtual/glibc
		virtual/linux-sources
		>=linuxtv-dvb-1.0.0
		media-libs/jpeg
		sys-libs/ncurses
		app-admin/sudo
		fam? ( app-admin/fam )
		lirc? ( app-misc/lirc )
		app-portage/gentoolkit
		"
fi

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
	[ -z $2 ] && ewarn "No optional ${1} in VDR_OPTS; Fine."
	return 1
}


src_unpack() {
	einfo
	einfo "VDR_OPTS: $VDR_OPTS"
	einfo

	unpack ${A}
	cd ${S}

	# vanilla vdr-1.3.8
	#ewarn "Applying libsi patch"
	#epatch ${DISTDIR}/libsi.diff
	
	# AC3 over DVB Patch
	# needs app-admin/fam-oss
	#if vdr_opts ac3
	#then
	#	if vdr_opts akool
	#	then
	#		ewarn "AC3 patch is already part of akool/complete patch ... skipping"
	#	else
	#		ewarn "Applying native AC3_OVER_DVB patch now"
	#		epatch ../${AC3_OVER_DVB}.diff
	#	fi
	#fi

	# Elchi Patch
	#if vdr_opts elchi
	#then
	#	if vdr_opts akool
	#	then
	#		ewarn "Elchi patch is already part of akool/complete patch ... skipping"
	#	else
	#		ewarn "Applying native Elchi patch now"
	#		cd ${S}
	#		epatch ../${ELCHI}.diff
	#	fi
	#fi

	# Andreas Akools Komplett Patch
	#if vdr_opts akool
	#then
	#	if use-disabled fam
	#	then
	#		ewarn "akool patch enabled but fam is disabaled"
	#		ewarn "remove -fam from use flag"
	#	else
	#		ewarn "akool patch is somewhat buggy when using VDR 1.3.6"
	#		patch  -p1 < ../${AKOOL}
	#	fi
	#fi

	# here comes the linux 2.6 specific stuff (by fsteinel)
	if [ "${KV:0:3}" == "2.6" ] ; then
	  mkdir linuxtv
	  mkdir linuxtv/include
	  mkdir linuxtv/include/linux
	  ln -s /lib/modules/$(uname -r)/build/include/linux/dvb/ ${S}/linuxtv/include/linux/dvb
	fi

	# here comes the gentoo specific stuff ( also called the "fun part")
	# for Makefile...
	/bin/sed -i Makefile \
	  -e 's:PLUGINDIR= ./PLUGINS:PLUGINDIR= /usr/lib/vdr:' \
	  -e 's:$(PLUGINDIR)/lib:$(PLUGINDIR):' \
	  -e '/Make.config/d' \
	  -e '51iCONFIGDIR = /etc/vdr' \
	  -e '51iDEFINES += -DCONFIGDIR=\\\"$(CONFIGDIR)\\\"'
        # (by fsteinel)
	if [ "${KV:0:3}" == "2.4" ] ; then
	  /bin/sed -i Makefile \
	    -e '/DVBDIR/d'
	fi
	if [ "${KV:0:3}" == "2.6" ] ; then
	  /bin/sed -i Makefile \
	    -e 's:DVBDIR   = ../DVB:DVBDIR   = ./linuxtv:'
	fi

	# now for ci.c
	if [ "${KV:0:3}" == "2.6" ] ; then
	  /bin/sed -i ci.c \
	    -e "10i#define __KERNEL__
#include <asm/unaligned.h>
#undef __KERNEL__"
	fi


	# now for vdr.c
	/bin/sed -i vdr.c \
	  -e '/#define DEFAULTPLUGINDIR PLUGINDIR/ a\#define DEFAULTCONFIGDIR CONFIGDIR' \
	  -e 's:ConfigDirectory = VideoDirectory:ConfigDirectory = DEFAULTCONFIGDIR:'

	# finally for plugin.c
	/bin/sed -i plugin.c \
	  -e 's:#define SO_INDICATOR   ".so.":#define SO_INDICATOR   ".so":' \
	  -e 's:\(asprintf.*\)%s/%s%s%s%s\(.*SO_INDICATOR.*\):\1%s/%s%s%s\2:' \
	  -e 's:LIBVDR_PREFIX, s, SO_INDICATOR, VDRVERSION);:LIBVDR_PREFIX, s, SO_INDICATOR);:'
}

src_compile() {
	local myconf
	use lirc && myconf="${myconf} REMOTE=LIRC"
	vdr_opts rcu && myconf="${myconf} REMOTE=RCU"
	vdr_opts vfat && myconf="${myconf} VFAT=1"

	einfo "Building VDR with this options ${myconf} now"
	make ${myconf} || die "vdr compile problem"

	mkdir -p include/vdr
	(cd include/vdr; for i in ../../*.h; do ln -sf $i .; done)
	for i in $(ls ${S}/PLUGINS/src) ; do
		cd ${S}/PLUGINS/src/${i}
		make all || die "compile problem plugin: ${i}"
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
	dohtml PLUGINS.html
	doman vdr.[15]

	for i in $(ls ${S}/PLUGINS/src) ; do
		insinto /usr/lib/vdr
		insopts -m0755
		newins ${S}/PLUGINS/src/${i}/libvdr-${i}.so libvdr-${i}.so.${PV}
		dosym /usr/lib/vdr/libvdr-${i}.so.${PV} /usr/lib/vdr/libvdr-${i}.so
	done

	insinto /usr/include/vdr
	doins *.h

	exeinto /usr/bin
	doexe vdr
	doexe svdrpsend.pl
	doexe ${FILESDIR}/vdrwatchdog.sh

	rm Make.config.template
	insopts -m0644 -ovdr -gvideo
	insinto /etc/vdr
	doins [a-z]*.conf*
	fowners vdr:video /etc/vdr
	insinto /etc/vdr/plugins/.keep
	fowners vdr:video /etc/vdr/plugins

	# changed to /usr/share/vdr -> see above... fs(12/23/2003)
	if vdr_opts elchi || vdr_opts akool
	then
		insinto /etc/vdr/logos
		doins ../logos/*.xpm
		fowners vdr:video /etc/vdr/logos
		insinto /etc/vdr/schemes
		doins ../schemes/*
		fowners vdr:video /etc/vdr/schemes
	fi
}

pkg_setup(){
	# temp userid 270 until got one from gentoo.org
	if ! grep -q "^vdr:" /etc/passwd ; then
		useradd -u 270 -g video -G audio,cdrom -d /video -s /bin/bash -c "VDR Daemon" vdr
		einfo "Added vdr user with id 270 and groups video, audio and cdrom."
	fi
}

pkg_postinst() {
	test -d /video && mkdir /video && fowners vdr:video /video
	# add fam to /etc/init.d/vdr if patched with akool
	if vdr_opts akool
	then
		/bin/sed -i '/need famd/d' /etc/init.d/vdr
		/bin/sed -i '/^depend/a\
		need famd' /etc/init.d/vdr
	fi

	einfo
	einfo "Congratulations, you have just installed VDR,"
	einfo "The Digital Video Recorder. To get started you"
	einfo "should read, read, read ..."
	einfo "A good starting point seems to be:"
	einfo "http://vdr.gentoo.de/ and "
	einfo "http://www.vdrportal.de/board/board.php?boardid=56"
	einfo

	[ -x /usr/bin/qpkg ] && INSTALLED_PLUGINS=$(qpkg -I -nc | grep vdrplugin | cut -d" " -f 1)
	if [ -z "$INSTALLED_PLUGINS" ]; then
		einfo "Remember: it is generally a good idea, to recompile plugins now."
		einfo
		einfo "here is a list:"
		einfo
		
		#create script 
		echo "#!/bin/sh" > /usr/local/bin/emerge-vdrplugs.sh
		chmod 766 /usr/local/bin/emerge-vdrplugs.sh
		
		for i in ${INSTALLED_PLUGINS}
			do
			 einfo ${i}
			 echo "ACCEPT_KEYWORDS=\"~x86\" /usr/bin/emerge ${i}" >> /usr/local/bin/emerge-vdrplugs.sh
		done
		
		# doensnt work yet (mad)
		if vdr_opts emergeplugs quiet ; then
			einfo
		 	ACCEPT_KEYWORDS="~x86" /usr/bin/emerge ${INSTALLED_PLUGINS}
			einfo
		 fi
	
		einfo
		einfo "for your convenience you can use the script"
		einfo "/usr/local/bin/emerge-vdrplugs.sh"
		einfo "to (re)emerge all installed plugins"
		einfo
	fi
}
