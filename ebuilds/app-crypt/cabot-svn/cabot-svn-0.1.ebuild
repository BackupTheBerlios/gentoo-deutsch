# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/app-crypt/cabot-svn/cabot-svn-0.1.ebuild,v 1.1 2004/06/19 11:54:12 tove Exp $

#[ -z "$ESVN_REPO_URI" ] && \
ESVN_REPO_URI="svn://svn.debian.org/cabot/trunk/"

inherit subversion

#SRC_URI="http://www.gnuenterprise.org/cgi-bin/viewcvs.cgi/*checkout*/gnue/trunk/gnue-common/utils/svn2cl"

DESCRIPTION="Scripts that help managing some parts of a PGP keysigning process"
HOMEPAGE="http://www.palfrader.org/cabot/"
RDEPEND="app-crypt/gnupg
	dev-perl/GnuPG-Interface
	dev-perl/Class-MethodMaker
	virtual/mta"
DEPEND="dev-util/subversion
	dev-lang/perl
	>=sys-devel/automake-1.7
	>=sys-devel/autoconf-2.5"

SLOT="0"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="-*"	# works today on my x86, masked because of svn.

src_compile() {
	cd ${S}
	einfo "Running bootstrap..."
	/bin/touch ChangeLog	# else bootstrap will fail
	WANT_AUTOMAKE=1.7 WANT_AUTOCONF=2.5  ./bootstrap

	einfo "Running configure..."
	econf || die "econf failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	# i decided to remove html docs:

	#dodir /usr/share/doc/cabot/html
	#mv ${D}/usr/share/doc/cabot/*.html ${D}/usr/share/doc/cabot/html
	rm ${D}/usr/share/doc/cabot/*.html

	rm -f ${D}/usr/share/doc/cabot/ChangeLog	# remove the touched file

	eval `perl -V:installvendorlib`
	PERL_VENDOR=${installvendorlib}
	dodir ${PERL_VENDOR}
	mv ${D}/usr/share/perl5/Cabot.pm ${D}/${PERL_VENDOR}
	rmdir ${D}/usr/share/perl5

	prepalldocs
}
