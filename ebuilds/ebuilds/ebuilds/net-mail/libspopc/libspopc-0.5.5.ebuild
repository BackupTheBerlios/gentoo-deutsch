# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/ebuilds/ebuilds/net-mail/libspopc/Attic/libspopc-0.5.5.ebuild,v 1.1 2003/08/22 15:27:30 fow0ryl Exp $

IUSE=""

DESCRIPTION="libspopc is a simple-to-use POP3 client library."
HOMEPAGE="http://brouits.free.fr/libspopc/"
SRC_URI="http://brouits.free.fr/libspopc/libspopc-${PV}.tgz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

src_unpack() {
	unpack ${A}
	}

src_compile() {
	sed -i "s/^VERSION=0.5.4/VERSION=0.5.5/" Makefile
	sed -i "s/^install : uninstall lib/install :/" Makefile
	make all || die "compile problem"
	}

src_install() {
	dolib.a libspopc-${PV}.a
	dosym /usr/lib/libspopc-${PV}.a  /usr/lib/libspopc.a
	insinto /usr/include/
	doins *.h
	dodoc README ChangeLog AUTHORS COPYING.LIB doc/*
	}

