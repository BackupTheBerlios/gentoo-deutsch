# Copyright 2002 Alexander Holler
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/dev-perl/MIME-tools/Attic/MIME-tools-5.411a.ebuild,v 1.1 2002/08/20 23:11:16 holler Exp $

inherit perl-module

#S=${WORKDIR}/${P}
S=${WORKDIR}/${PN}-5.411
DESCRIPTION="Perl modules for parsing (and creating!) MIME entities"
SRC_URI="http://www.cpan.org/modules/by-module/MIME/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/MIME/${P}.readme"

DEPEND="${DEPEND}
	dev-perl/MIME-Base64
	dev-perl/IO-stringy
	dev-perl/libwww-perl
	dev-perl/MailTools"

RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc sparc64"
