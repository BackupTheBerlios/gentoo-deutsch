# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-vbox/vdrplugin-vbox-0.5.0-r1.ebuild,v 1.1 2004/07/22 21:15:50 austriancoder Exp $

IUSE=""
VDRPLUGIN="vbox"

inherit eutils

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder Voicebox PlugIn"
HOMEPAGE="http://linvdr.org/"
SRC_URI="http://linvdr.org/download/vdr-vbox/vdr-${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.0
	media-libs/libmad
	media-libs/libsndfile"
RDEPEND="net-dialup/isdn4k-utils"

src_unpack() {
	unpack ${A}

        # patch to support => vdr1.3.7
        if
        has_version ">=media-video/vdr-1.3.7" ;
        then
        epatch ${FILESDIR}/vbox-${PV}-1.3.7.diff
        fi

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
	make all|| die "compile problem"
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
