# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

VDRPLUGIN="text2skin"

S=${WORKDIR}/${VDRPLUGIN}-${PV/_/-}
DESCRIPTION="VDR text2skin PlugIn"
HOMEPAGE="http://www.magoa.net/linux/"
SRC_URI="http://www.magoa.net/linux/contrib/vdr-${VDRPLUGIN}-${PV/_/-}.tgz
         http://www.magoa.net/linux/contrib/demo.tgz
         http://linvdr.org/download/VDR-AIO/logos/xpmlogos.tar.bz2
"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.3.8
	media-gfx/imagemagick"


src_unpack() {
	unpack ${A}
        if [ "${KV:0:3}" == "2.4" ] ; then
	  sed -i "s/^DVBDIR.*$/DVBDIR = \/usr\/include\/linux\/dvb\//" ${S}/Makefile
	fi
        if [ "${KV:0:3}" == "2.6" ] ; then
          mkdir -p ${S}/linuxtv/include/linux
          ln -s /lib/modules/$(uname -r)/build/include/linux/dvb/ ${S}/linuxtv/include/linux/dvb
          /bin/sed -i ${S}/Makefile \
            -e 's:DVBDIR = ../../../../DVB:DVBDIR   = ./linuxtv:'
        fi
	sed -i "/cp.*LIBDIR/d" ${S}/Makefile
	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" ${S}/Makefile
	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib/" ${S}/Makefile
}

src_compile() {

	make all|| die "compiling returned an error"
}

src_install() {
	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PV}
	dodoc COPYING README HISTORY SKINS SKINS.de
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PV} libvdr-${VDRPLUGIN}.so

	insinto /etc/vdr/plugins/text2skin/demo
	doins ${S}/../demo/*
	insinto /etc/vdr/plugins/text2skin/demo/symbols
	doins ${S}/../demo/symbols/*.xpm
	insinto /etc/vdr/plugins/text2skin/demo/langs
	doins ${S}/../demo/langs/*.png
	insinto /etc/vdr/plugins/text2skin/demo/logos
	doins ${S}/../logos/*.xpm
	chown -R vdr:video ${D}/etc/vdr/plugins/text2skin
}

pkg_postinst() {
	einfo
	einfo "you need to add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to activate it."
	einfo
}
