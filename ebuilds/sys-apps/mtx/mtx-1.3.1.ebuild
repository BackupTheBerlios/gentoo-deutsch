# Copyright 2002 Alexander Holler
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/sys-apps/mtx/Attic/mtx-1.3.1.ebuild,v 1.1 2002/10/21 04:52:18 holler Exp $

S=${WORKDIR}/${P}
DESCRIPTION="SCSI Media Changer and Backup Device Control"
SRC_URI="http://download.sourceforge.net/mtx/${P}.tar.gz"
HOMEPAGE="http://mtx.badtux.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64 alpha"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
}

src_compile() {

	econf || die
	emake || die

}

src_install() {

	dosbin loaderinfo mtx nsmhack scsitape tapeinfo
	doman loaderinfo.1 mtx.1 scsitape.1 tapeinfo.1
	dodoc CHANGES COMPATABILITY FAQ LICENSE README TODO
	dohtml mtxl.README.html

}
