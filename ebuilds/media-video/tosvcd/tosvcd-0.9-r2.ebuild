# Copyright 2003 Henning Ryll <henning.ryll@web.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/tosvcd/tosvcd-0.9-r2.ebuild,v 1.1 2003/05/03 14:46:16 fow0ryl Exp $


S=${WORKDIR}/tosvcd-${PV}/
DESCRIPTION="convert vdr files to svcd"
SRC_URI="http://muse.seh.de/tosvcd/tosvcd-${PV}.tar.bz2"
HOMEPAGE="http://muse.seh.de/"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL"

DEPEND=""

RDEPEND="${DEPEND}
	>=media-video/mjpegtools-1.6.0-r5
	>=media-video/vcdimager-0.7.12
        >=app-cdr/cdrdao-1.1.7-r1
	>=media-libs/netpbm-9.12-r4
	>=virtual/vdr-1.1.25"

src_unpack()  {
	unpack tosvcd-${PV}.tar.bz2
}


src_compile() {
	emake || die "emake failed"
}

src_install() {

	dobin tosvcd

	# Docs
	dodoc README
}

pkg_postinst() {
echo 'tosvcd is a vdr to svcd converter. You should have VDR running.'
}
