# Copyright 2004 Michael Mauch <michael.mauch@gmx.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-vdrrip/vdrplugin-vdrrip-0.3.0.ebuild,v 1.1 2004/05/06 18:21:10 fow0ryl Exp $

IUSE=""
VDRPLUGIN="vdrrip"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder vdrrip PlugIn"
HOMEPAGE="http://www.a-land.de/"
SRC_URI="http://www.a-land.de/vdr-${VDRPLUGIN}-${PV}.tgz http://www.a-land.de/queuehandler-fixed-0.3.0.sh"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.0"
RDEPEND="media-video/mplayer sys-apps/procps sys-apps/util-linux"
# media-video/vdrsync seems to be optional

src_unpack() {
	unpack vdr-${VDRPLUGIN}-${PV}.tgz
	cp ${DISTDIR}/queuehandler-fixed-0.3.0.sh ${S}/scripts/queuehandler.sh	
}

src_compile() {
	sed -i "/cp.*LIBDIR/d" Makefile
	sed -i "s/^DVBDIR.*$/DVBDIR = \/usr/" Makefile
	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" Makefile
	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib/" Makefile

	sed -i "s,/usr/local/bin/,/usr/bin/," scripts/queuehandler.sh.conf
	sed -i 's,scriptdir=`dirname $0`,scriptdir=/etc/conf.d,' scripts/queuehandler.sh
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
}

pkg_postinst() {
	einfo
	einfo "You need to add the module $VDRPLUGIN to /etc/conf.d/vdr"
	einfo "and perhaps adjust /etc/conf.d/vdr.$VDRPLUGIN,"
	einfo "the restart vdr to activate it."
        einfo "Also have a look into /etc/conf.d/vdrrip-qh.conf"
        einfo "and use vdrrip-qh to start the vdrrip queue handler."
	einfo
}
