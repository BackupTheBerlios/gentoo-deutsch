# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-audiocd/vdrplugin-audiocd-0.0.4.ebuild,v 1.1 2004/01/24 15:20:28 fow0ryl Exp $

IUSE=""
VDRPLUGIN="audiocd"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder Audio-CD PlugIn"
HOMEPAGE="http://mail.pad.zuken.de/~alex"
SRC_URI="http://mail.pad.zuken.de/~alex/vdr/vdr-${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.6-r4
	>=media-libs/libcdaudio-0.99.6-r2"

src_unpack() {
	unpack ${A}
}

src_compile() {
	/bin/sed -i Makefile \
	  -e '/cp.*LIBDIR/d' \
	  -e 's/^DVBDIR.*$/DVBDIR = \/usr/' \
	  -e 's/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/' \
	  -e 's/^LIBDIR.*$/LIBDIR = \/usr\/lib/'
#	   \
#	  -e 's/@install.*$//' \
#	  -e '/@install.*$/d'
	make all || die "compile problem"
}

src_install() {
	insinto /etc/conf.d
	doins ${FILESDIR}/vdr.${VDRPLUGIN}

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
