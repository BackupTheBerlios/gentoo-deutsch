# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-osdpip/vdrplugin-osdpip-0.0.5.ebuild,v 1.1 2004/06/15 11:28:41 fow0ryl Exp $

IUSE=""
VDRPLUGIN="osdpip"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder OSD-PIP PlugIn"
HOMEPAGE="http://www.magoa.net/linux"
SRC_URI="http://www.magoa.net/linux/files/vdr-${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.7
	>=media-libs/libmpeg2-0.4.0
	>=media-video/ffmpeg-0.4.8
	"

src_unpack() {
	unpack ${A}
#	cd ${S}
#	/bin/sed -i Makefile \
#	  -e '/cp.*LIBDIR/d' \
#	  -e 's/^DVBDIR.*$/DVBDIR = \/usr/' \
#	  -e 's/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/' \
#	  -e 's/^FFMDIR.*$/FFMDIR = \/usr\/include\/ffmpeg/' \
#	  -e 's/^LIBDIR.*$/LIBDIR = \/usr\/lib/' \
#	  -e 's/@install.*$//' \
#	  -e '/@install.*$/d'
}

src_compile() {
	/bin/sed -i Makefile \
	  -e '/cp.*LIBDIR/d' \
	  -e 's/^DVBDIR.*$/DVBDIR = \/usr/' \
	  -e 's/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/' \
	  -e 's/^FFMDIR.*$/FFMDIR = \/usr\/include\/ffmpeg/' \
	  -e 's/^LIBDIR.*$/LIBDIR = \/usr\/lib/' \
	  -e 's/@install.*$//' \
	  -e '/@install.*$/d'
	make all || die "compile problem"
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
