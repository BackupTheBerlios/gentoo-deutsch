# Copyright 2003 Phillip Rothe <phil@alpha-centauri.org>
# Distributed under the terms of the GNU General Public License v2

IUSE=""
VDRPLUGIN="dxr3"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder - dxr3 or hw+ plugin"
HOMEPAGE="http://www.schluenss.de/DXR3.html"
SRC_URI="http://www.schluenss.de/down/DXR3/vdr-${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.0
          media-video/em8300-modules
		  media-video/em8300-libraries
		  media-video/ffmpeg"

src_unpack() {
	unpack ${A}
}

src_compile() {
	mkdir libavcodec
	cp /usr/include/ffmpeg/avcodec.h ./libavcodec/
	sed -i "/cp.*LIBDIR/d" Makefile
	sed -i "s/^DVBDIR.*$/DVBDIR = \/usr/" Makefile
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
