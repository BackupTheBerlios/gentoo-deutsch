# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-tv/linuxtv-dvb/linuxtv-dvb-1.1.1-r1.ebuild,v 1.1 2004/06/16 23:41:08 austriancoder Exp $

DESCRIPTION="This is the standalone DVB driver for Kernel 2.4.x"
HOMEPAGE="http://linuxtv.org/"

SRC_URI="
	http://linuxtv.org/download/dvb/${P}.tar.bz2
	http://www.linuxtv.org/download/dvb/firmware/dvb-ttpci-01.fw-261c"
	
LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~x86"
IUSE=""
DEPEND="
		virtual/glibc
		virtual/linux-sources
		!media-video/linuxdvb"

RDEPEND="virtual/glibc"
#KERNELRELEASE=$(/bin/uname -r)

pkg_setup() { 
	
	if [ -z "$(modinfo -n input 2>/dev/null)" -o -z "$(modinfo -n evdev 2>/dev/null)" ]; then
		ewarn
		ewarn "If something goes wrong, make sure you have evdev,video, i2c and "
		ewarn "input support in your kernel. Check your kernelconfiguration"
		ewarn "for input core support, event interface support, i2c support,"
		ewarn "and video for linux support. Be sure /usr/src/linux point's to"
		ewarn "your current kernel or make will die."
		ewarn
	fi

#	if [ -r /lib/modules/${KERNELRELEASE}/misc/videodev.o ]; then
	if [ -r /lib/modules/${KV}/misc/videodev.o ]; then
		ewarn
		ewarn "There is a stale /lib/modules/${KERNELRELEASE}/misc/videodev.o."
		ewarn "Probably from a previous installation of this driver. Make sure you"
		ewarn "have Video 4 Linux support in your kernel (either as module or"
		ewarn "statically linked) and delete this file. This has changed from "
		ewarn "previous versions. I'm aborting now... ";
		ewarn
		die 
	fi
}

src_unpack() {
	unpack ${P}.tar.bz2 || die "unpack failed"
}

src_compile() {
	cp ${DISTDIR}/dvb-ttpci-01.fw-261c ${S}/build-2.4 || die "fw copy problem"
#	cp ${S}/../dvb-ttpci-01.fw-261c ${S}/build-2.4 || die "fw copy problem"
	cd ${S}/build-2.4
	make || die "compile problem"
}

src_install() {
	cd ${S}/build-2.4
	echo -ne "\nprintmods::\n\t@echo \"\$(obj-m)\"\n" >> Makefile
	insinto /lib/modules/$(uname -r)/misc
	doins $(make printmods)

	cd ../
	dodoc NEWS README README.bt8xx TODO TROUBLESHOOTING
	dodoc linux/Documentation/dvb/*

	#insinto /etc/modules.d
	#newins $FILESDIR/modules.d  /etc/modules.d/linuxtv-dvb

	# install headers
	insinto /usr/include/linux/dvb
	doins	linux/include/linux/dvb/*.h
	insinto /usr/include/linux/media
	doins	linux/include/media/*.h

	insinto /etc/devfs.d
	newins  ${FILESDIR}/linuxtv-dvb.devfs linuxtv-dvb

}

pkg_postinst() {
	[ -x /sbin/update-modules ] && /sbin/update-modules
	[ -x /usr/bin/pkill ] && /usr/bin/pkill -HUP ^devfsd
}

pkg_postrm() {
	[ -x /sbin/update-modules ] && /sbin/update-modules
	[ -x /usr/bin/pkill ] && /usr/bin/pkill -HUP ^devfsd
}

pkg_config() {
	TEMPFILE=$(/bin/mktemp)
	MODFILE="/etc/modules.autoload.d/kernel-2.4"
	
	einfo 
	einfo "Be aware that ALL dvb related modules should be"
	einfo "unloaded!"
	einfo "This works NOT for bt878 and dvb-bt8xx cards."
	einfo "Read the docs for information about howto load"
	einfo "the modules."
	einfo
	einfo "Hit Enter to continue or Strg-C to abort."
	einfo
	read
	
	DVBCORE=$(lsmod | grep dvb-core > /dev/null && echo "Y")
	if [ "$DVBCORE" == "Y" ]; then
		ewarn
		ewarn "DVB-CORE is loaded! Aboarting."
		ewarn 
		die "at least dvb-core is loaded. make sure no dvb releated module is loaded!"
	fi

	MODS="v4l1-compat v4l2-common video-buf"
   	# DVB core
	MODS=$MODS" dvb-core"
   	# frontend drivers
	MODS=$MODS" ves1x93 alps_tdlb7 alps_tdmb7 stv0299 ves1820 tda1004x"
	MODS=$MODS" grundig_29504-401 grundig_29504-491 cx24110 mt312"
 	# saa7146 based siemens/technotrend/hauppauge cards
	MODS=$MODS" saa7146 saa7146_vv ttpci-eeprom dvb-ttpci"
	MODS=$MODS" dvb-ttpci dvb-ttpci-budget dvb-ttpci-budget-ci dvb-ttpci-budget-av "
	# technotrend/hauppauge USB things
	MODS=$MODS" dvb-ttusb-budget ttusb_dec"
	# technisat skystar2
	MODS=$MODS" skystar2"

	ewarn
	ewarn "loading modules ... "
	ewarn

	for i in $MODS; do
		insmod /lib/modules/$(uname -r)/misc/$i.o >/dev/null 2>&1 && echo $i >> $TEMPFILE
	done

	einfo
	einfo "The following modulelist was generated:"
	einfo
	for i in $(cat $TEMPFILE); do
		einfo $i
	done
	einfo
	einfo "If you accept this modules they will be added to"
	einfo "$MODFILE"
	einfo "This is a temporary solution until someone provides"
	einfo "a modules.conf file."
	einfo
	echo -ne  "\tAccept [Y/N] "
	read ACCEPT
	if [ "$ACCEPT" == "Y" -o "$ACCEPT" == "y" ]; then
		echo -ne "\n# linuxtv-dvb drivers $(date)\n" >> $MODFILE
		cat $TEMPFILE >> $MODFILE
		einfo 
		einfo "Done. Be aware that you have to restart /etc/init.d/modules."
		einfo
	else
		einfo "Aborted!!"
	fi
}
