# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-misc/pxes/pxes-0.7-r1.ebuild,v 1.2 2004/05/08 11:04:30 fow0ryl Exp $

IUSE="ltsp"
DESCRIPTION="PXES is a package for building thin clients using multiple types of clients"
HOMEPAGE="http://pxes.sourceforge.net"
SRC_URI="mirror://sourceforge/pxes/${PN}-base-i586-${PV}-1.tar.gz
	mirror://sourceforge/pxes/pxesconfig-${PV}-1.tar.gz
	ltsp? ( mirror://sourceforge/pxes/${PN}-ltsp-${PV}.tar.gz )"

KEYWORDS="~x86"

SLOT="0"
LICENSE="GPL-2"
DEPEND=">=dev-lang/perl-5.8.0-r12
	ltsp? >=net-misc/ltsp-core-3.0.9-r1"

RDEPEND="${DEPEND}
	dev-perl/gtk-perl
	>=dev-perl/glade-perl-0.61
	cdr? app-cdr/cdrtools"

S=${WORKDIR}/${P}
RESTRICT="nouserpriv"

inherit perl-module

dir=/opt/${P}
Ddir=${D}${dir}

src_unpack() {
	unpack ${A}

	use ltsp && unpack ${PN}-ltsp-${PV}.tar.gz
}

src_compile() {
	cd ${WORKDIR}/pxesconfig-${PV}
	perl-module_src_compile || die
}

src_install() {
	dodir ${dir}
	cp -dpR ${S}/stock ${Ddir}
	cp -dpR ${S}/tftpboot ${D}
	dodoc Documentation/ChangeLog
	dohtml Documentation/html/{index,pxe,readme,screenshots}.html,howto/{configuring_ICA,customizing_kernel_and_modules,gdm,xfs,ms_only_environment/ms_only_environment}.html
	exeinto ${dir}
	doexe ${FILESDIR}/makedevices.sh
	cd ${WORKDIR}/pxesconfig-${PV}
	perl-module_src_install || die
	dosym /usr/bin/cpio /bin/cpio
}

#pkg_postinst() {
#	${dir}/makedevices.sh
#}

#pkg_prerm() {
#	rm -rf ${dir}/stock/{dist,initrd}/dev
#}
