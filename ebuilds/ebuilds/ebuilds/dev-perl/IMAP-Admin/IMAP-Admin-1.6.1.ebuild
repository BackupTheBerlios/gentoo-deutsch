# Copyright 2002 Alexander Holler
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/ebuilds/ebuilds/dev-perl/IMAP-Admin/Attic/IMAP-Admin-1.6.1.ebuild,v 1.1 2003/08/22 15:27:33 fow0ryl Exp $

CATEGORY="dev-perl"
DESCRIPTION="IMAP::Admin - Perl module for basic IMAP server administration"
SRC_URI="http://search.cpan.org/CPAN/authors/id/E/EE/EESTABROO/IMAP-Admin-1.6.1.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

src_compile() {

	perl Makefile.PL
	emake || die
}

src_install() {
	make PREFIX=${D}/usr  \
                INSTALLMAN1DIR=${D}/usr/share/man/man1 \
                INSTALLMAN2DIR=${D}/usr/share/man/man2 \
                INSTALLMAN3DIR=${D}/usr/share/man/man3 \
                INSTALLMAN4DIR=${D}/usr/share/man/man4 \
                INSTALLMAN5DIR=${D}/usr/share/man/man5 \
                INSTALLMAN6DIR=${D}/usr/share/man/man6 \
                INSTALLMAN7DIR=${D}/usr/share/man/man7 \
                INSTALLMAN8DIR=${D}/usr/share/man/man8 \
                INSTALLSITEMAN1DIR=${D}/usr/share/man/man1 \
                INSTALLSITEMAN2DIR=${D}/usr/share/man/man2 \
                INSTALLSITEMAN3DIR=${D}/usr/share/man/man3 \
                INSTALLSITEMAN4DIR=${D}/usr/share/man/man4 \
                INSTALLSITEMAN5DIR=${D}/usr/share/man/man5 \
                INSTALLSITEMAN6DIR=${D}/usr/share/man/man6 \
                INSTALLSITEMAN7DIR=${D}/usr/share/man/man7 \
                INSTALLSITEMAN8DIR=${D}/usr/share/man/man8 \
	install  || die
}

 
