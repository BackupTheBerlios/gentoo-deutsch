# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-graphlcd/vdrplugin-graphlcd-0.1.0-r1.ebuild,v 1.1 2004/06/20 23:06:32 austriancoder Exp $

IUSE=""
VDRPLUGIN="graphlcd"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="VDR graphical LCD PlugIn"
HOMEPAGE="http://www.powarman.de"

SRC_URI="http://home.arcor.de/andreas.regel/files/vdr-${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.6"

src_unpack() {
	unpack ${A}
	cd ${S}
	
	sed -i "/cp.*LIBDIR/d" Makefile

	# if we are using a 2.6 Kernel the dvb includes are in the /usr/src/linux dir (fix by Christian Gmeiner)
	if [ "${KV:0:3}" == "2.6" ] ; then
		sed -i "s/^DVBDIR.*$/DVBDIR = \/usr\/src\/linux/" Makefile
	fi
	if [ "${KV:0:3}" == "2.4" ] ; then
		sed -i "s/^DVBDIR.*$/DVBDIR = \/usr/" Makefile
	fi

	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" Makefile
	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib/" Makefile
	sed -i "s/^INSTALLLIBDIR.*$/INSTALLLIBDIR = \/var\/tmp\/portage\/vdrplugin-${VDRPLUGIN}-${PV}\/work/" Makefile
	sed -i "s/^INSTALLBINDIR.*$/INSTALLBINDIR = \/var\/tmp\/portage\/vdrplugin-${VDRPLUGIN}-${PV}\/work/" Makefile
}

src_compile() {
#	emake
	make all || die "compile problem"
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
	doexe ${S}/tools/crtfont/crtfont
	doexe ${S}/tools/drawtest/drawtest
	doexe ${S}/tools/showpic/showpic
}

pkg_postinst() {
#	chmod u+s /usr/bin/vdr
	einfo
	einfo "you need to add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to activate it."
	einfo "please run the plugin setup via OSD"
	einfo
	einfo "Add additional options in /etc/conf.d/vdr.graphlcd"
	einfo
}
