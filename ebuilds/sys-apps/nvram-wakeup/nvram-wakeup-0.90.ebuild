# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/sys-apps/nvram-wakeup/nvram-wakeup-0.90.ebuild,v 1.1 2003/03/05 19:30:17 mad Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="This is a (small) program that can read and write the WakeUp time in the Bios"
HOMEPAGE="http://sourceforge.net/projects/nvram-wakeup/"
SRC_URI="mirror://sourceforge/nvram-wakeup/${P}.tar.bz2"
KEYWORDS="x86"
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
	doman nvram-wakeup.8
	doman nvram-wakeup.conf.5
	dobin biosinfo guess nvram-wakeup rtc  
	newbin time nvram-time
	dodoc HISTORY README README.mb
}

pkg_postinst() {
	echo
	ewarn "I´ve renamed the time binary because it bothers"
	ewarn "the bash build in time funktion or the time tool."
	echo
}
