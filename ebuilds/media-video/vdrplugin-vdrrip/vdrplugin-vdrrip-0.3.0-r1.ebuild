# Copyright 2004 Gentoo Technologies Inc
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-vdrrip/vdrplugin-vdrrip-0.3.0-r1.ebuild,v 1.1 2004/07/15 21:48:43 austriancoder Exp $

IUSE=""
VDRPLUGIN="vdrrip"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder vdrrip PlugIn"
HOMEPAGE="http://www.a-land.de/"
SRC_URI="http://www.a-land.de/vdr-${VDRPLUGIN}-${PV}.tgz 
	http://www.a-land.de/queuehandler-fixed-0.3.0.sh"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.0"
RDEPEND="media-video/mplayer sys-apps/procps sys-apps/util-linux"
# media-video/vdrsync seems to be optional

# include functions from eutils
inherit eutils

src_unpack() {
	unpack vdr-${VDRPLUGIN}-${PV}.tgz
	cp ${DISTDIR}/queuehandler-fixed-0.3.0.sh ${S}/scripts/queuehandler.sh	

	if  
	has_version ">=media-video/vdr-1.3.7" ;
	then
		einfo "applying VDR > 1.3.6 patch"
		epatch ${FILESDIR}/vdrrip-0.3.0-1.3.7.diff
	fi
}

src_compile() {
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

	sed -i "s,/usr/local/bin/,/usr/bin/," scripts/queuehandler.sh.conf
	sed -i 's,scriptdir=`dirname $0`,scriptdir=/etc/conf.d,' scripts/queuehandler.sh
	sed -i 's,nice -+19,nice -n 19,' scripts/queuehandler.sh
	make all || die "compile problem"
}

src_install() {
	insinto /etc/conf.d
	doins ${FILESDIR}/vdr.${VDRPLUGIN} 
	newins scripts/queuehandler.sh.conf vdrrip-qh.conf
	newbin scripts/queuehandler.sh vdrrip-qh
	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PV}
	dodoc COPYING FAQ HISTORY INSTALL README TODO
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PV} libvdr-${VDRPLUGIN}.so
	exeinto /etc/init.d
	doexe ${FILESDIR}/vdrrip-qh
}

pkg_postinst() {
	einfo
	einfo "You need to add the module $VDRPLUGIN to /etc/conf.d/vdr"
	einfo "and perhaps adjust /etc/conf.d/vdr.$VDRPLUGIN,"
	einfo "then restart vdr to activate it."
	einfo
        einfo "Also have a look into /etc/conf.d/vdrrip-qh.conf"
        einfo "and use vdrrip-qh to start the vdrrip queue handler."
	einfo
	einfo "You can also run 'rc-update add /etc/init.d/vdrrip-qh default'."
}
