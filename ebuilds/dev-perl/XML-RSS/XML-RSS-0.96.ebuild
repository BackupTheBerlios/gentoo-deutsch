# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/dev-perl/XML-RSS/XML-RSS-0.96.ebuild,v 1.1 2004/01/03 14:35:11 shermann Exp $

inherit perl-module

DESCRIPTION="XML::RSS creates and updates RSS files"
HOMEPAGE="http://cpan.org/modules/by-module/XML/${P}.readme"
SRC_URI="http://cpan.org/modules/by-module/XML/${P}.tar.gz"

LICENSE="Artistic | GPL-1 | GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64 ~ppc ~alpha"

DEPEND=">=dev-perl/XML-Parser-2.31"
