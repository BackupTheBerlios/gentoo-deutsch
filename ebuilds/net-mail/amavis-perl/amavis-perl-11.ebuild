# Copyright 2002 Alexander Holler
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-mail/amavis-perl/amavis-perl-11.ebuild,v 1.1 2002/08/20 23:11:43 holler Exp $

DESCRIPTION="AMaViS-Perl - A Mail Virus Scanner"
SRC_URI="http://www.amavis.org/dist/perl/${P}.tar.gz"
HOMEPAGE="http://www.amavis.org/"
SLOT="0"
LICENSE="GPL-2"
# don't know if there is an ppc-antivir
KEYWORDS="x86"

# If you want to use another MTA change the configure-line and the dependency

# We don't add an Antivirus as dependency (user should install them first)
# so configure will fail if none is installed

DEPEND="net-mail/postfix
	sys-devel/perl
	app-arch/arc
	app-arch/zoo
	app-arch/lha
	app-arch/ncompress
	app-arch/unarj
	app-arch/unrar
	sys-apps/bzip2
	dev-perl/Archive-Tar
	dev-perl/Archive-Zip
	dev-perl/Convert-TNEF
	dev-perl/Convert-UUlib
	dev-perl/Unix-Syslog"

RDEPEND="${DEPEND}"

pkg_setup() {

	if ! grep -q ^vscan: /etc/group ; then
		groupadd vscan || die "problem adding group vscan"
	fi
	if ! grep -q ^vscan: /etc/passwd ; then
		useradd -g vscan -s /bin/false -c "Amavis" vscan \
			|| die "problem adding user vscan"
	fi
}	
	
src_compile() {

	./configure --enable-postfix --enable-smtp --without-warnsender --with-mailto=root || die
        emake || die

}

src_install() {                                                                                                                  

	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS COPYING ChangeLog FAQ HINTS INSTALL NEWS README* TODO doc/amavis.txt doc/amavis.m4
	dohtml doc/amavis.html doc/amavis.png

}

pkg_postinst() {

	einfo "**************************************************"
	einfo "* INFO: add                                      *"
	einfo "* content_filter = vscan                         *"
	einfo "* to /etc/postfix/main.cf                        *"
	einfo "* and                                            *"
	einfo "* vscan unix - n n - 10 pipe user=vscan          *"
	einfo '*   argv=/usr/sbin/amavis ${sender} ${recipient} *'
	einfo "* localhost:10025 inet n - n - - smtpd           *"
	einfo "*   -o content_filter=                           *"
	einfo "* to /etc/postfix/master.cf                      *"
	einfo "**************************************************"
	
}
