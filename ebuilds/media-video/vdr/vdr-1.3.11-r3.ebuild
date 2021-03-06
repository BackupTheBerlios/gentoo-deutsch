# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdr/vdr-1.3.11-r3.ebuild,v 1.2 2004/07/27 02:04:11 austriancoder Exp $

IUSE="lirc"
AC3_OVER_DVB="vdr-1.3.10-AC3overDVB-0.2.6"
BEAUTY="vdr-1.3.10-beauty"
AIO="vdr-1.3.12-enAIO-1.3"
SUBMENU="cmd_submenu.patch"
JUMPPLAY="jumpplay-0.4-1.3.11.diff"
DOUBLEEPG="disableDoubleEpgEntrys_0.6b_vdr1.3.6.diff"

S=${WORKDIR}/vdr-${PV}
DESCRIPTION="The Video Disk Recorder"
HOMEPAGE="http://www.cadsoft.de/vdr/"
SRC_URI="
	ftp://ftp.cadsoft.de/vdr/Developer/vdr-${PV}.tar.bz2
	http://www.hut.fi/~rahrenbe/vdr/${AIO}.diff.gz
	http://www.e-tobi.net/vdr/${SUBMENU}.gz
	http://www.muempf.de/down/${AC3_OVER_DVB}.diff.gz
	http://www.muempf.de/down/${BEAUTY}.diff.gz
	http://www.wontorra.net/filemgmt_data/files/disableDoubleEpgEntrys_0.6b_vdr1.3.6.diff.tar.gz
	"

KEYWORDS="x86 ~ppc"
SLOT="0"
LICENSE="GPL-2"

if [ "${KV:0:3}" == "2.6" ]
then
	DEPEND="virtual/glibc
	media-libs/jpeg
	sys-libs/ncurses
	app-admin/sudo
	lirc? ( app-misc/lirc )
	app-portage/gentoolkit
	"
fi

if [ "${KV:0:3}" == "2.4" ]
then
	DEPEND="virtual/glibc
	virtual/linux-sources
	>=linuxtv-dvb-1.0.0
	media-libs/jpeg
	sys-libs/ncurses
	app-admin/sudo
	lirc? ( app-misc/lirc )
	app-portage/gentoolkit
	"
fi


##########
## ToDo ##
##########

# fix auto-emerge

##########

# include functions from eutils
inherit eutils

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
	[ -z $2 ] && einfo "No optional ${1} in VDR_OPTS - Fine :)"
	echo
	return 1
}

src_unpack() {
	unpack ${A}
	cd ${S}

	echo
	einfo
	# some little info about the kernel
	if [ "${KV:0:3}" == "2.6" ]
	then
		einfo "Kernel 2.6.x detected"
	fi

	if [ "${KV:0:3}" == "2.4" ]
	then
		einfo "Kernel 2.4.x detected"
	fi
	einfo
	echo

	# AC3 over DVB Patch
	# needs app-admin/fam-oss
	if vdr_opts ac3
	then
		ewarn "Applying AC3_OVER_DVB patch now"
		epatch ../${AC3_OVER_DVB}.diff
	fi

	# enAIO Patch
	#	* Easyinput Patch by Marcel Schaeben / Patrick Maier  
	#	* Rename Recordings Patch by Torsten Kunkel  
	#	* Menu Selection Patch by Peter D.  
	#	* Recording Length Patch by Tobias Faust  
	#	* Show Weekdays Patch by Oskar Signell
	if vdr_opts aio
	then
		ewarn "Applying AIO patch now"
		epatch ../${AIO}.diff
		echo
	fi
	
	# Replay Mode Beauty Patch
	if vdr_opts beauty
	then
		ewarn "Applying REPLAY BEAUTY patch now"
		epatch ../${BEAUTY}.diff
		echo
	fi

	# Submenu Patch
	if vdr_opts submenu
	then
		ewarn "Applying SUBMENU patch now"
		epatch ../${SUBMENU}
		echo
	fi

	# Jumpplay Patch
	# Patch to automatically jump over cutting marks.
	if vdr_opts jumpplay
	then
		ewarn "Applying JUMPPLAY patch now"
		epatch ${FILESDIR}/${JUMPPLAY}
		echo
	fi

	# Disable-Double-Epg-Entrys-Patch
	if vdr_opts doubleepg
	then
		ewarn "Applying Disable-Double-Epg-Entrys-Patch now"
		epatch ../${DOUBLEEPG}
		echo
	fi

	# if we are using a 2.6 Kernel the dvb includes are in the /usr/src/linux dir (fix by Christian Gmeiner)
	if [ "${KV:0:3}" == "2.6" ] ; then
		sed -i "s/^DVBDIR.*$/DVBDIR = \/usr\/src\/linux/" Makefile
	fi
	if [ "${KV:0:3}" == "2.4" ] ; then
		sed -i "s/^DVBDIR.*$/DVBDIR = \/usr/" Makefile
	fi

	# apply local patches
	if test -n "${VDR_LOCAL_PATCHES}"; 
	then
		ewarn "Applying local patches:"
		for LOCALPATCH in ${VDR_LOCAL_PATCHES}; 
		do
			if test -f "${LOCALPATCH}";
			then
				epatch ${LOCALPATCH}
			fi
		done
	else
		einfo "No additional local patches to use"	
	fi
	echo

	# here comes the gentoo specific stuff ( also called the "fun part")
	# for Makefile...
	sed -i Makefile \
	  -e 's:PLUGINDIR= ./PLUGINS:PLUGINDIR= /usr/lib/vdr:' \
	  -e 's:$(PLUGINDIR)/lib:$(PLUGINDIR):' \
	  -e '/Make.config/d' \
	  -e '51iCONFIGDIR = /etc/vdr' \
	  -e '51iDEFINES += -DCONFIGDIR=\\\"$(CONFIGDIR)\\\"'

	# now for ci.c
	if [ "${KV:0:3}" == "2.6" ] ; then
	    sed -i ci.c \
	    -e "10i#define __KERNEL__
#include <asm/unaligned.h>
#undef __KERNEL__"
	fi

	# now for vdr.c
	sed -i vdr.c \
	  -e '/#define DEFAULTPLUGINDIR PLUGINDIR/ a\#define DEFAULTCONFIGDIR CONFIGDIR' \
	  -e 's:ConfigDirectory = VideoDirectory:ConfigDirectory = DEFAULTCONFIGDIR:'

	# finally for plugin.c
	sed -i plugin.c \
	  -e 's:#define SO_INDICATOR   ".so.":#define SO_INDICATOR   ".so":' \
	  -e 's:\(asprintf.*\)%s/%s%s%s%s\(.*SO_INDICATOR.*\):\1%s/%s%s%s\2:' \
	  -e 's:LIBVDR_PREFIX, s, SO_INDICATOR, VDRVERSION);:LIBVDR_PREFIX, s, SO_INDICATOR);:'
}

src_compile() {
	local myconf
	use lirc && myconf="${myconf} REMOTE=LIRC"
	vdr_opts rcu && myconf="${myconf} REMOTE=RCU"
	vdr_opts vfat && myconf="${myconf} VFAT=1"

	echo
	ewarn
	einfo " -- Building VDR with this options ${myconf} --"
	ewarn
	echo

	make ${myconf} || die "vdr compile problem"

	mkdir -p include/vdr
	(cd include/vdr; for i in ../../*.h; do ln -sf $i .; done)
	for i in $(ls ${S}/PLUGINS/src) 
	 do
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

	for i in $(ls ${S}/PLUGINS/src) 
	do
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
}

pkg_setup(){
	# temp userid 270 until got one from gentoo.org
	if ! grep -q "^vdr:" /etc/passwd ; then
		useradd -u 270 -g video -G audio,cdrom -d /video -s /bin/bash -c "VDR Daemon" vdr
		einfo "Added vdr user with id 270 and groups video, audio and cdrom."
	fi

	# some short info about use flags of vdr
	echo
	einfo
	einfo "Video Disk Recorder"
	einfo "-------------------"
	einfo
	einfo "You can use some VDR-USE-Flags to build your special VDR."
	einfo "Only add "
	einfo "VDR_OPTS=\"...\""
	einfo "to /etc/make.conf"
	einfo
	einfo
	einfo "Here is a list of all possible VDR_OPTS:"
	einfo
	einfo "ac3 -> patching vdr with: AC3 over DVB Patch"
	einfo "beauty -> patching vdr with: Replay Mode Beauty Patch"
	einfo "aio -> patching vdr with: enAIO Patch"
	einfo "submenu -> patching vdr with: Submenu Patch"
	einfo "jumpplay -> patching vdr with: jumpplay Patch (automatically jump over cutting mark.)"
	einfo "doubleepg -> automaticly clean out double epg entries"
	einfo "vfat -> enables vfat support in vdr"
	einfo "rcu -> enables rcu Remote-Support of VDR - look at http://www.cadsoft.de/vdr/remote.htm"
#	einfo "emergeplugs  -> recompile every emerged plugin after emerging of vdr"
	einfo
	einfo "Your VDR_OPTS: $VDR_OPTS"
	einfo
	einfo "It is also possible to apply local patches. You only need"
	einfo "to add VDR_LOCAL_PATCHES to your make.conf. Here a simpe example:"
	einfo
	einfo "VDR_LOCAL_PATCHES=\"/usr/../patch1.diff /usr/../patch2.diff\""
	einfo
	einfo "NOTE: Contact the ebuild-makers at vdr-portal.de -> Forum, if you"
	einfo "      miss a pacht, so that the missed patch can be added."
	echo
}

pkg_postinst() {
	test -d /video && mkdir /video && fowners vdr:video /video

	echo
	einfo
	einfo "Congratulations, you have just installed VDR,"
	einfo "The Digital Video Recorder. To get started you"
	einfo "should read, read, read ..."
	einfo "A good starting point seems to be:"
	einfo "http://vdr.gentoo.de/ and "
	einfo "http://www.vdrportal.de/board/board.php?boardid=56"
	einfo

	# do we have gentoolkit installed?
	if [ -x /usr/bin/qpkg ] 
	then 
		INSTALLED_PLUGINS=$(qpkg -I -nc | grep vdrplugin) 
	fi

	if [ -z "${INSTALLED_PLUGINS}" ]
	then
		echo
		einfo "It seems like you dont have installed any plugins. To see what plugins exist run"
		einfo "ACCEPT_KEYWORDS=\"~x86\" emerge -s vdrplugin"
		einfo
	else
		echo
		einfo "Remember: it is generally a good idea, to recompile plugins now."
		einfo
		einfo "here is a list:"
		echo

		# print list
		for i in ${INSTALLED_PLUGINS}
		do
			einfo ${i}
		done		

		echo
		echo

		# auto emering?
#		if vdr_opts emergeplugs quiet
#		then
#			# do emering of all plugins via this ebuild
#			einfo "Script will automaticly emerge all installed plugins"
#			echo
#
#			for i in ${INSTALLED_PLUGINS}
#			do
#				einfo "emergeing now :"
#				einfo ${i}
#			 	ACCEPT_KEYWORDS="~x86" emerge ${i}
#				echo
#			done
#		else
			# generate a script

			# delete script if it exists
			if [ -x /usr/local/bin/emerge-vdrplugs.sh ]
			then
				rm /usr/local/bin/emerge-vdrplugs.sh
			fi

			# create script 
			echo "#!/bin/sh" > /usr/local/bin/emerge-vdrplugs.sh
			chmod 766 /usr/local/bin/emerge-vdrplugs.sh
		
			for i in ${INSTALLED_PLUGINS}
			do
				echo "ACCEPT_KEYWORDS=\"~x86\" /usr/bin/emerge ${i}" >> /usr/local/bin/emerge-vdrplugs.sh
			done

			echo
			einfo "for your convenience you can use the script"
			einfo "/usr/local/bin/emerge-vdrplugs.sh"
			einfo "to (re)emerge all installed plugins"
			einfo
#		fi	
	fi
}
