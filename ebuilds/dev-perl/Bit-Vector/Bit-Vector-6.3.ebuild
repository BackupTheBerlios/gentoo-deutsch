# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/dev-perl/Bit-Vector/Attic/Bit-Vector-6.3.ebuild,v 1.1 2002/09/29 17:41:51 geschke Exp $

inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="Bit::Vector is an efficient C library which allows you to handle bit vectors, sets (of integers), 'big integer arithmetic' and boolean matrices, all of arbitrary sizes."
SRC_URI="http://www.cpan.org/modules/by-module/Bit/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Bit/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2 | LGPL-2"
KEYWORDS="x86 ppc sparc sparc64"


src_install() {
   perl-module_src_install
   dodoc CHANGE* CREDITS* INSTALL* MANIFEST* README* ${mydoc}
   docinto examples
   dodoc examples/*
}