# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-launcher/vdrplugin-launcher-0.0.2a.ebuild,v 1.1 2004/06/26 08:48:29 fow0ryl Exp $

IUSE=""
VDRPLUGIN="launcher"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder OSD-PIP PlugIn"
HOMEPAGE="http://www.datac.de/cw/html/vdr-launcher.html"
SRC_URI="http://www.datac.de/cw/vdr_1.3.11-${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.7
	"

src_unpack() {
	unpack ${A}
}

src_compile() {
	/bin/sed -i Makefile \
	  -e '/cp.*LIBDIR/d' \
	  -e 's/^DVBDIR.*$/DVBDIR = \/usr/' \
	  -e 's/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/' \
	  -e 's/^LIBDIR.*$/LIBDIR = \/usr\/lib/' \
	  -e 's/@install.*$//' \
	  -e '/@install.*$/d'
	make all || die "compile problem"
}

src_install() {
	insinto /etc/conf.d
	doins ${FILESDIR}/vdr.${VDRPLUGIN}

	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PV}
	dodoc COPYING README HISTORY README.deu
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PV} libvdr-${VDRPLUGIN}.so
}

pkg_postinst() {
	einfo
	einfo "you need to add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to activate it."
	einfo
}
