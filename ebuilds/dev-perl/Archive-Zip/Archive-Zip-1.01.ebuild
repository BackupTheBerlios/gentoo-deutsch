# Copyright 2002 Alexander Holler
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/dev-perl/Archive-Zip/Attic/Archive-Zip-1.01.ebuild,v 1.1 2002/08/20 23:11:16 holler Exp $

inherit perl-module
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="The Archive::Zip module allows a Perl program to create, manipulate, read, and write Zip archive files"
SRC_URI="http://www.cpan.org/modules/by-module/Archive/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Archive/${P}.readme"

DEPEND="${DEPEND}
	dev-perl/Compress-Zlib"

RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc sparc64"
