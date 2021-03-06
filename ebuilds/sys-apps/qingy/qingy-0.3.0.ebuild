# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header:

DESCRIPTION="Qingy is a DirectFB getty replacement."
HOMEPAGE="http://qingy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="pam"
DEPEND=">=dev-libs/DirectFB-0.9.18
	pam? ( >=sys-libs/pam-0.75-r11 )
	>=sys-apps/fbset-2.1
	>=dev-util/pkgconfig-0.12.0"
S=${WORKDIR}/${P}

src_compile()
{
	# override qingy self-calculated cflags
	econf MY_CFLAGS="${CFLAGS}" || die
	emake || die
}

src_install()
{
	# copy documentation manually as make install doesn't do that
	dodoc AUTHORS COPYING ChangeLog ChangeLog.paolino INSTALL NEWS README HOWTO_THEMES

	# and finally install the program
	einstall prefix=${D} infodir=${D}usr/share/info || die
}

pkg_postinst()
{
	einfo "In order to use qingy you must first edit your /etc/inittab"
	einfo "Check files INSTALL and README in /usr/share/doc/${P}"
	einfo "for instructions on how to do that."
	einfo
	ewarn "Please note that configuration and theme files syntax"
	ewarn "has changed since version 0.2x: please remove all"
	ewarn "old themes and update qingy configuration files!"
	sleep 5
}

