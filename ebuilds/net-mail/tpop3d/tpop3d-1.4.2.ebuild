# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.8 2002/05/30 01:54:49 sandymac Exp

# Source Maintainer:	Chris Lightfoot <chris@ex-parrot.com>
# .ebuild Maintainer:  	Martin Klebermass <klebermass@LimTec.de>
S=${WORKDIR}/${P}
DESCRIPTION="An extensible POP3 server with vmail-sql/MySQL support."
SRC_URI="http://www.ex-parrot.com/~chris/tpop3d/${P}.tar.gz"
HOMEPAGE="http://www.ex-parrot.com/~chris/tpop3d/"

LICENSE="GPL-2"

DEPEND="    virtual/glibc
			tls?	( >=dev-libs/openssl-0.9.6 )
        	ldap? 	( >=net-nds/openldap-2.0.7 )
		    mysql? 	( >=dev-db/mysql-3.23.28 )
			perl?	( >=sys-devel/perl-5.6.1 )
			pam?	( >=sys-libs/pam-0.75 )
			tcpd?	( >=sys-apps/tcp-wrappers-7.6 )"
			# No Drac Support Because not implemented in gentoo yet

src_compile() {
	local myconf
	use mysql		&& myconf="--enable-auth-mysql"
	use ldap		&& myconf="${myconf} --enable-auth-ldap"
	use perl		&& myconf="${myconf} --enable-auth-perl"
	use tcpd		&& myconf="${myconf} --enable-tcp-wrappers"
	use pam			|| myconf="${myconf} --disable-auth-pam"
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} \
		--enable-mbox-maildir\
		|| die "./configure failed"
	
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodir /etc/tpop3d
}
pkg_postinst() {
	einfo "Read the tpop3d.conf MAN-Page"
	einfo "Please create /etc/tpop3d/tpop3d.conf to fit your Configuration"
}				
 
