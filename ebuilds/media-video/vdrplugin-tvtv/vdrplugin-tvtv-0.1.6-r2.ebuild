# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-tvtv/vdrplugin-tvtv-0.1.6-r2.ebuild,v 1.1 2004/07/27 01:19:28 austriancoder Exp $

IUSE=""
PVERSION="0.1.6"

S=${WORKDIR}/tvtv-${PVERSION}
DESCRIPTION="Video Disk Recorder TvTv Plugin"
HOMEPAGE="http://www.vdrportal.de/"
SRC_URI="http://www.fh-lippe.de/~mad/vdr-tvtv-${PVERSION}.tgz
	 http://puzzle.dl.sourceforge.net/sourceforge/vdr-statusleds/tvtv-${PVERSION}-withdelete.patch
	 http://www.akool.de/download/plugins/tvtv-${PVERSION}.patch.bz2"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.0"

# include functions from eutils
inherit eutils

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
	cp ${PORTDIR}/distfiles/tvtv-${PVERSION}-withdelete.patch ${WORKDIR}
	unpack ${A}
	cd  ${S}
	einfo ${WORKDIR}
	if vdr_opts akool; then
	    einfo "Applying withdelete patch"
	    epatch ../tvtv-${PVERSION}-withdelete.patch
	    einfo "Applying AKOOl tvtv patch"
	    epatch ../tvtv-${PVERSION}.patch
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
	make all|| die "compile problem"
}

src_install() {
	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-tvtv.so libvdr-tvtv.so.${PVERSION}
	dodoc COPYING README HISTORY
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-tvtv.so.${PVERSION} libvdr-tvtv.so
}

pkg_postinst() {
	einfo
	einfo "you need to add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to activate it."
	einfo
}
