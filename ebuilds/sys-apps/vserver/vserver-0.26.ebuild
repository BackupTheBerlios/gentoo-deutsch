# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/sys-apps/vserver/Attic/vserver-0.26.ebuild,v 1.2 2003/11/08 11:31:08 mad Exp $

inherit flag-o-matic 
# Compile problems with these ...
filter-flags "-funroll-loops"
filter-flags "-fomit-frame-pointer"
replace-flags "-O3" "-O2"

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
	sed -i \
		-e "/\.sysv.*v_/d" \
		-e "/vservers.sysv/d" \
		Makefile
	make install -e RPM_BUILD_ROOT=${D}
	insinto /etc/init.d
	doins ${FILESDIR}/rc.vservers
}

pkg_postinst(){
	einfo
	einfo "READ http://www.solucorp.qc.ca/miscprj/s_context.hc"
	einfo "because you need much more than tis pkg to run "
	einfo "vservers. Especially a patched Kernel."
	einfo
}
