# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-tvtv/vdrplugin-tvtv-0.1.6-r2.ebuild,v 1.2 2004/08/11 13:55:19 austriancoder Exp $

IUSE=""
# include functions from eutils
inherit vdrplugin eutils

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


src_unpack() {
	vdrplugin_src_unpack
	cp ${PORTDIR}/distfiles/tvtv-${PVERSION}-withdelete.patch ${WORKDIR}

	cd  ${S}
	einfo ${WORKDIR}
	if vdr_opts akool; then
	    einfo "Applying withdelete patch"
	    epatch ../tvtv-${PVERSION}-withdelete.patch
	    einfo "Applying AKOOl tvtv patch"
	    epatch ../tvtv-${PVERSION}.patch
	fi
}

