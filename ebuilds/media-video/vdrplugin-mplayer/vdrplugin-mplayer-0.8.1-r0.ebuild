# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-mplayer/Attic/vdrplugin-mplayer-0.8.1-r0.ebuild,v 1.1 2003/10/10 11:10:25 martini Exp ${VDRPLUGIN}/vdrplugin-${VDRPLUGIN}-0.7.15.ebuild,v 1.1 2003/06/05 09:39:40 mad Exp $

IUSE=""
VDRPLUGIN="mplayer"


S=${WORKDIR}/mp3-${PV}
DESCRIPTION="Video Disk Recorder ${VDRPLUGIN} Plugin"
HOMEPAGE="http://www.muempf.de/"
SRC_URI="http://www.muempf.de/down/vdr-mp3-${PV}.tar.gz
	 http://www.akool.de/download/plugins/mp3-${PV}.patch.bz2"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.1
	>=media-video/${VDRPLUGIN}-0.90_rc4
	media-sound/mad
	sys-libs/zlib
	media-libs/libsndfile"
	
function vdr_opts {
	local x
	for x in ${VDR_OPTS}
	do
		if [ "${x}" = "${1}" ]
		then
			return 0
		fi
	done
	ewarn "No optional ${1} in VDR_OPTS"
	return 1
}


src_unpack() {
	einfo
	einfo "VDR_OPTS: $VDR_OPTS"
	einfo
	unpack ${A}
	cd ${S}
	if vdr_opts akool; then
	    epatch ../mp3-${PV}.patch
	fi
}

src_compile() {
	sed -i "/cp.*LIBDIR/d" Makefile
	sed -i "s/^DVBDIR.*$/DVBDIR = \/usr\/include\/linux\/dvb/" Makefile
	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" Makefile
	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib/" Makefile
	make all|| die "compile problem"
}

src_install() {
	insinto /etc/conf.d
	doins ${FILESDIR}/vdr.${VDRPLUGIN}
	doins ${FILESDIR}/vdr.mp3
	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PV}
	newins libvdr-mp3.so libvdr-mp3.so.${PV}
	dodoc COPYING HISTORY README MANUAL
	dodoc examples/${VDRPLUGIN}.sh.example
	dodoc examples/mount.sh.example
	dodoc examples/mp3sources.conf.example
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PV} libvdr-${VDRPLUGIN}.so
	ln -s libvdr-mp3.so.${PV} libvdr-mp3.so

	mkdir -p ${D}etc/vdr/plugins/
	echo "/tmp/;TMP;0" > ${D}etc/vdr/plugins/mplayersources.conf
	echo "/tmp/;TMP;0" > ${D}etc/vdr/plugins/mp3sources.conf
}

pkg_postinst() {
	einfo
	einfo "you need to add the module to /etc/conf.d/vdr"
	einfo "(PLUGIN) and restart vdr to activate it."
	einfo "Don´t forget to edit the *sources.conf files"
	einfo "in /etc/vdr/plugins/ "
	einfo
}
