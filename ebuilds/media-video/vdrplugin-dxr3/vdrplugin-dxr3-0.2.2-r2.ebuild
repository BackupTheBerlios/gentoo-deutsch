# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-dxr3/vdrplugin-dxr3-0.2.2-r2.ebuild,v 1.1 2004/07/27 00:36:03 austriancoder Exp $

VDRPLUGIN="dxr3"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder - dxr3 or hw+ plugin"
HOMEPAGE="http://www.schluenss.de/DXR3.html"
SRC_URI="http://www.schluenss.de/down/DXR3/vdr-${VDRPLUGIN}-${PV}.tgz
http://www.visual-page.de/vdr/dxr3-plugin-0.2.2.patch.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=media-video/vdr-1.2.0
	          media-video/em8300-modules
	          media-video/em8300-libraries
	         media-video/ffmpeg"

# include functions from eutils
inherit eutils

src_unpack() {
	unpack ${A}
        cd ${S}

	# patch: no glitches in *.vdr viewing mode
	epatch ../dxr3-plugin-0.2.2.patch
}

src_compile() {
	mkdir libavcodec
	cp /usr/include/ffmpeg/avcodec.h ./libavcodec/
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
	sed -i "s/^FFMDIR.*$/FFMDIR = \/usr\/include\/ffmpeg/" Makefile
	make all|| die "compiling returned an error"
}

src_install() {
	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PV}
	dodoc COPYING README HISTORY
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PV} libvdr-${VDRPLUGIN}.so
}

pkg_postinst() {
	einfo
	einfo "you need to add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to activate it."
	einfo 
}

