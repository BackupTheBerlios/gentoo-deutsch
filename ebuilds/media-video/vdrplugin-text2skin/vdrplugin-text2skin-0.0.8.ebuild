# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

VDRPLUGIN="text2skin"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="VDR text2skin PlugIn"
HOMEPAGE="http://www.magoa.net/linux/"
SRC_URI="
	http://www.magoa.net/linux/files/vdr-${VDRPLUGIN}-${PV}.tgz
	http://www.magoa.net/linux/files/demo.tgz
"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.3.8
	media-gfx/imagemagick"


src_unpack() {
	unpack ${A}

	# if we are using a 2.6 Kernel the dvb includes are in the /usr/src/linux dir (fix by Christian Gmeiner)
	if [ "${KV:0:3}" == "2.6" ] ; then
		sed -i "s/^DVBDIR.*$/DVBDIR = \/usr\/src\/linux/" ${S}/Makefile
	fi
	if [ "${KV:0:3}" == "2.4" ] ; then
		sed -i "s/^DVBDIR.*$/DVBDIR = \/usr/" ${S}/Makefile
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

	mkdir -p ${D}/etc/vdr/plugins/text2skin
	cp -r ${S}/../demo ${D}/etc/vdr/plugins/text2skin/
	insinto /etc/vdr/plugins/text2skin
	insopts -m0755
	newins ${S}/contrib/skin_to_002.pl skin_to_002.pl 
	chown -R vdr:video ${D}/etc/vdr/plugins/text2skin
}

pkg_postinst() {
	einfo
	einfo "you need to add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to activate it."
	einfo
}
