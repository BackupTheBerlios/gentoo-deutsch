# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/dev-perl/HTML-Template-Expr/HTML-Template-Expr-0.04.ebuild,v 1.1 2002/11/07 12:33:37 shermann Exp $

inherit perl-module

DESCRIPTION="A Perl module to use HTML Templates with expr"
HOMEPAGE="http://cpan.org/modules/by-module/HTML/${P}.readme"
SRC_URI="http://cpan.org/modules/by-module/HTML/${P}.tar.gz"

LICENSE="Artistic | GPL-1 | GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64 ~ppc ~alpha"

DEPEND=">=dev-perl/Parse-RecDescent-1.80
	${DEPEND}"

