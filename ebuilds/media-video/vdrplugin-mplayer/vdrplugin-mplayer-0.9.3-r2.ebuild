# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-mplayer/vdrplugin-mplayer-0.9.3-r2.ebuild,v 1.1 2004/08/12 18:21:37 austriancoder Exp ${VDRPLUGIN}/vdrplugin-${VDRPLUGIN}-0.7.15.ebuild,v 1.1 2003/06/05 09:39:40 mad Exp $

IUSE=""
inherit vdrplugin eutils

DESCRIPTION="Video Disk Recorder Mplayer Plugin"
HOMEPAGE="http://www.muempf.de/"
SRC_URI="http://www.muempf.de/down/vdr-mp3-${PV}.tar.gz
	http://vdr.poogle.de/files/mplayer-audiostreamid-patch-${PV}.tar.gz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.6
	>=media-video/mplayer-0.90_rc4
	>=media-sound/madplay
	sys-libs/zlib
	>=media-libs/libmad-0.15.0b
	>=media-libs/libsndfile-1.0.5"


src_unpack() {
	vdrplugin_src_unpack

	epatch mplayer-${PV}-audiostreamid_patch.diff
}

src_install() {
	vdrplugin_src_install

	insinto /etc/conf.d
	doins ${FILESDIR}/vdr.mp3

	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-mp3.so libvdr-mp3.so.${PV}

	dodoc examples/mplayer.sh.example
	dodoc examples/mount.sh.example
	dodoc examples/mp3sources.conf.example

	cd ${D}/usr/lib/vdr/
	dosym libvdr-${VDRPLUGIN}.so.${PV} /usr/lib/vdr/libvdr-${VDRPLUGIN}.so
	dosym libvdr-mp3.so.${PV} /usr/lib/vdr/libvdr-mp3.so

	mkdir -p ${D}etc/vdr/plugins/
	echo "/tmp/;TMP;0" > ${D}etc/vdr/plugins/mplayersources.conf
	echo "/tmp/;TMP;0" > ${D}etc/vdr/plugins/mp3sources.conf

	exeinto /usr/bin
      doexe ${WORKDIR}/mplayer.sh
}

pkg_postinst() {
	vdrplugin_pkg_postinst

	einfo
	einfo "Don´t forget to edit the *sources.conf files"
	einfo "in /etc/vdr/plugins/ "
	einfo
}
