# Copyright 2004 Stefan Nickl <snickl@snickl.freaks.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/app-misc/gpsman/Attic/gpsman-6.1.1.ebuild,v 1.1 2004/06/11 10:51:01 snickl Exp $

DESCRIPTION="GPS Manager is a graphical manager of GPS data that makes possible the preparation, inspection and edition of GPS data in a friendly environment"
HOMEPAGE=""http://www.ncc.up.pt/gpsman/

SRC_URI="http://www.ncc.up.pt/gpsman/gpsmanhtml/${PF}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE="tcltk"

DEPEND=">=dev-lang/tcl-8.4
        >=dev-lang/tk-8.4"

src_install() {
	dobin gpsman.tcl
	dobin util/*

    doman man/man1/gpsman.1x

	dodoc LICENSE
	dodoc manual/GPSMandoc.pdf

	dohtml manual/html/*
	insinto /usr/share/doc/${PF}/html/info
	doins manual/html/info/*

	insinto /usr/share/${P}

	# released package
	doins gmsrc/*.tcl

	# icons from release package
	insinto /usr/share/${P}/gmicons
	doins gmsrc/gmicons/*

	dosed "s:^set SRCDIR.*$:set SRCDIR /usr/share/${P}:" \
		/usr/bin/gpsman.tcl \
		/usr/bin/mb2gmn.tcl \
		/usr/bin/mou2gmn.tcl
}
