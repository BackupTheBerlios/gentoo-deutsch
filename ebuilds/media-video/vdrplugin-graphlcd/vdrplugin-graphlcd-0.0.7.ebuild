# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-graphlcd/vdrplugin-graphlcd-0.0.7.ebuild,v 1.3 2003/11/27 21:42:53 fow0ryl Exp $

IUSE=""
VDRPLUGIN="graphlcd"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="VDR graphical LCD PlugIn"
HOMEPAGE="http://c.siebholz.bei.t-online.de/"
SRC_URI="http://c.siebholz.bei.t-online.de/download/vdr-${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.0"

#
# function to implement a "local" use variable called VDR_OPTS
#
function vdr_opts {
	local x
	for x in ${VDR_OPTS}
	do
		if [ "${x}" = "${1}" ]
		then
			einfo "Option ${1} found in VDR_OPTS"
			return 0
		fi
	done
	ewarn "No optional ${1} in VDR_OPTS"
	return 1
}

src_unpack() {
	unpack ${A}
	cd ${S}

	if vdr_opts LCD_T6963; then
		epatch ${FILESDIR}/${VDRPLUGIN}-${PV}-T6963.diff || die "T6963 timing patch problem"
		echo
	fi

	#
	# Patch für LCDs von Feegy & LCD-Aktion
	#
	if vdr_opts LCD_FEEGY; then
		epatch /${FILESDIR}/${VDRPLUGIN}-${PV}-feegy.diff || die "feegy patch problem"
		echo
	fi
}

src_compile() {
	sed -i "/cp.*LIBDIR/d" Makefile
	sed -i "s/^DVBDIR.*$/DVBDIR = \/usr/" Makefile
	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" Makefile
	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib/" Makefile

	if vdr_opts LCD_KS0108; then
	   lcd=KS0108
	elif vdr_opts LCD_T6963; then
	   lcd=T6963
	elif vdr_opts LCD_HD61830; then
	   lcd=HD61830
	fi

	if vdr_opts LCD_WIN_WIRE; then
	   wire=WINDOWS
	fi

	GRAPHLCD_DRIVER=${lcd} GRAPHLCD_WIRING=${wire} make all || die "compile problem"
}

src_install() {
	insinto /etc/conf.d
	doins ${FILESDIR}/vdr.${VDRPLUGIN}

	insopts -m0644 -ovdr -gvideo
	insinto /etc/vdr/plugins/${VDRPLUGIN}
	doins ${S}/${VDRPLUGIN}/*
	insinto /etc/vdr/plugins/${VDRPLUGIN}/fonts
	doins ${S}/${VDRPLUGIN}/fonts/*
	insinto /etc/vdr/plugins/${VDRPLUGIN}/logos
	doins ${S}/${VDRPLUGIN}/logos/*

	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PV}
	dodoc COPYING README HISTORY TODO
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PV} libvdr-${VDRPLUGIN}.so

	exeinto /usr/local/bin
	doexe ${S}/tools/convpic/convpic
	doexe ${S}/tools/convpic/convbmp
	doexe ${S}/tools/convpic/convtif
	doexe ${S}/tools/showpic/showpic
}

pkg_postinst() {
	chmod u+s /usr/bin/vdr
	einfo
	einfo "you need to add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to activate it."
	einfo "Add additional options in /etc/conf.d/graphlcd"
	einfo
}
