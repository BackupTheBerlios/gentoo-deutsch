# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdr/vdr-1.2.6-r4.ebuild,v 1.7 2003/12/27 22:26:06 fow0ryl Exp $

IUSE="lirc"
AC3_OVER_DVB="vdr-1.2.6-AC3overDVB-0.2.4"
AKOOL_VN="1.2.6"
ELCHI_VN="1.2.6"
MAILBOX_VN="0.1.4"

S=${WORKDIR}/vdr-${PV}
DESCRIPTION="The Video Disk Recorder"
HOMEPAGE="http://linvdr.org/"
SRC_URI="
		ftp://ftp.cadsoft.de/vdr/vdr-${PV}.tar.bz2
		http://www.muempf.de/down/${AC3_OVER_DVB}.diff.gz
		http://sites.inka.de/seca/vdr/vdr-mailbox-${MAILBOX_VN}.tgz
		http://www.vdr-portal.de/download/patches/KomplettPatch-1.2.6-E.diff.bz2
		http://linvdr.org/download/VDR-AIO/vdr-${ELCHI_VN}-ElchiAIO3c.diff.gz
		http://www.magoa.net/linux/files/improvedosd-3a.diff.gz
		http://www.magoa.net/linux/contrib/improvedosd-3-3a.diff.gz
		http://www.magoa.net/linux/files/iconscolored.tar.gz
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
	[ -z $2 ] && ewarn "No optional ${1} in VDR_OPTS; Fine."
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
			ewarn "AC3 patch is already part of akool/complete patch ... skipping"
		else
			epatch ../${AC3_OVER_DVB}.diff
		fi
	fi

	# Elchi Patch
	if vdr_opts elchi
	then
		if vdr_opts akool
		then
			ewarn "Elchi patch is already part of akool/complete patch ... skipping"
		else
			cd ${S}
			epatch ../vdr-${ELCHI_VN}-ElchiAIO3c.diff
			if vdr_opts iosd
			then
				epatch ../improvedosd-3a.diff
				# link black & white logos to vdr dir
				ln -s ${WORKDIR}/icons/ ${S}/icons
				# now overwrite black & white logos with some colored ones
				unpack iconscolored.tar.gz
			fi
		fi
	fi

	# Dirk's Komplett Patch
	if vdr_opts akool
	then
		epatch ../KomplettPatch-1.2.6-E.diff
		epatch ../improvedosd-3-3a.diff

		einfo "Applying remove duplicate Symblol 59 patch ..."
		/bin/sed -i -e '782,811d' fontsym.c
	fi

	# here comes the gentoo specific stuff ( also called the "fun part")
	# for Makefile...
	/bin/sed -i Makefile \
	  -e 's:PLUGINDIR= ./PLUGINS:PLUGINDIR= /usr/lib/vdr:' \
	  -e 's:$(PLUGINDIR)/lib:$(PLUGINDIR):' \
	  -e '/Make.config/d' \
	  -e '/DVBDIR/d' \
	  -e '51iCONFIGDIR = /etc/vdr\/' \
	  -e '51iDEFINES += -DCONFIGDIR=\\\"$(CONFIGDIR)\\\"'

	# now for vdr.c
	/bin/sed -i vdr.c \
	  -e '/#define DEFAULTPLUGINDIR PLUGINDIR/ a\#define DEFAULTCONFIGDIR CONFIGDIR' \
	  -e 's:ConfigDirectory = VideoDirectory:ConfigDirectory = DEFAULTCONFIGDIR:'

	# finally for plugin.c
	/bin/sed -i plugin.c \
	  -e 's:#define SO_INDICATOR   ".so.":#define SO_INDICATOR   ".so":' \
	  -e 's:\(asprintf.*\)%s/%s%s%s%s\(.*SO_INDICATOR.*\):\1%s/%s%s%s\2:' \
	  -e 's:LIBVDR_PREFIX, s, SO_INDICATOR, VDRVERSION);:LIBVDR_PREFIX, s, SO_INDICATOR);:'

	# for osdbase.c in case, VDR_OPTS->iosd || akool ?? is that ok ??
	if vdr_opts akool || vdr_opts iosd
	then
		/bin/sed -i osdbase.c \
		  -e 's:logofileS=MALLOC(char, strlen(ConfigDirectory):logofileS=MALLOC(char, strlen("/usr/share/vdr"):' \
		  -e 's:strcpy(logofileS, ConfigDirectory):strcpy(logofileS, "/usr/share/vdr"):'
	fi

	# use patch from mailbox plugin, even if plugin is not used
	epatch ../mailbox-${MAILBOX_VN}/patches/${P}-osdmenufix.diff
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

	dodoc CONTRIBUTORS COPYING README* INSTALL MANUAL HISTORY* UPDATE-1.2.0
	dodoc ${FILESDIR}/vdrshutdown.sh
	dohtml PLUGINS.html
	doman vdr.[15]

	dolib.a libdtv/libdtv.a
	dolib.a libdtv/liblx/liblx.a
	dolib.a libdtv/libsi/libsi.a
	dolib.a libdtv/libvdr/libvdr.a

	for i in $(ls ${S}/PLUGINS/src) ; do
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
	fowners vdr:video /etc/vdr
	insinto /etc/vdr/plugins/.keep
	fowners vdr:video /etc/vdr/plugins

	# changed to /usr/share/vdr -> see above... fs(12/23/2003)
	if  vdr_opts akool || vdr_opts iosd
	then
		insinto /usr/share/vdr/icons
		doins ${S}/icons/*.logo
		fowners vdr:video /usr/share/vdr/icons
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
	# test -d /video && mkdir /video
	# add fam to /etc/init.d/vdr if patched with akool
	if vdr_opts akool
	then
		/bin/sed -i '/need fam/d' /etc/init.d/vdr
		/bin/sed -i '/^depend/a\
		need fam' /etc/init.d/vdr
	fi

	INSTALLED_PLUGINS=$(qpkg -I -nc | grep vdrplugin | cut -d" " -f 1)
	einfo
	einfo "Congratulations, you have just installed VDR,"
	einfo "The Digital Video Recorder. To get started you"
	einfo "should read, read, read ..."
	einfo "A good starting point seems to be:"
	einfo "http://vdr.gentoo.de/ and "
	einfo "http://www.vdrportal.de/board/board.php?boardid=56"
	einfo "Remember: it is generally a good idea, to recompile plugins now."
	einfo
	einfo "here is a list:"
	einfo
	for i in ${INSTALLED_PLUGINS}
		do
		 einfo ${i}
		 if vdr_opts emergeplugs quiet ; then
			einfo
		 	ACCEPT_KEYWORDS="~x86" /usr/bin/emerge ${i}
			einfo
		 fi
	done
}
