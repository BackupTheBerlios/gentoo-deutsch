# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/ebuilds/ebuilds/app-i18n/aspell-de/Attic/aspell-de-20001109.ebuild,v 1.1 2003/08/22 15:27:27 fow0ryl Exp $


MY_P=igerman98-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A german dictionary for ispell"
SRC_URI="http://www.suse.de/~bjacke/igerman98/dict/${MY_P}.tar.bz2"
HOMEPAGE="http://www.suse.de/~bjacke/igerman98/"

DEPEND="app-text/aspell app-text/ispell"
RDEPEND="app-text/aspell"

src_unpack() {

	unpack ${A}
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s:^ASPELL.*:ASPELL = aspell --data-dir=./aspell:" \
		Makefile.orig > Makefile
	ln -s /usr/share/aspell/iso8859-1.dat aspell
}

src_compile() {

	make \
	    SQ=${S}/bin/sq.pl \
	    UNSQ=${S}/bin/unsq.pl \
	aspell || die

}

src_install () {

	dodir /usr/share/pspell
	echo "/usr/lib/aspell/german" > ${D}/usr/share/pspell/de-aspell.pwli

	insinto /usr/share/aspell
	doins aspell/german*.dat
	insinto /usr/lib/aspell
	doins german
 
	dodoc Documentation/*

}

 
