# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/ebuilds/ebuilds/net-ftp/gftp/Attic/gftp-2.0.15_rc1.ebuild,v 1.1 2003/08/22 15:27:27 fow0ryl Exp $

IUSE="nls"
S=${WORKDIR}/gftp-2.0.15rc1
DESCRIPTION="Gnome based FTP Client"
SRC_URI="http://www.gftp.org/gftp-2.0.15rc1.tar.bz2"
HOMEPAGE="http://www.gftp.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/x11
	>=x11-libs/gtk+-2.0.0"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	use nls \
		&& myconf="--enable-nls" \
		|| myconf="--disable-nls"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die

	dodoc COPYING ChangeLog AUTHORS README* THANKS \
		TODO docs/USERS-GUIDE NEWS

}
