# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/sys-apps/vserver/Attic/vserver-0.22.ebuild,v 1.2 2003/08/22 12:10:17 mad Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Virtual private servers and security contexts"
HOMEPAGE="http://www.solucorp.qc.ca/miscprj/s_context.hc"
SRC_URI="ftp://ftp.solucorp.qc.ca/pub/vserver/${P}.src.tar.gz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=""

src_unpack() {
	unpack ${A}
}

src_compile() {
	make || die "compile problem"
}

src_install() {
	sed -i "/\.sysv.*v_/d" Makefile
	make install -e RPM_BUILD_ROOT=${D}
}

