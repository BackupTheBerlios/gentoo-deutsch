# Copyright 2002 Alexander Holler
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/dev-libs/cyrus-sasl/cyrus-sasl-2.1.2.ebuild,v 1.3 2003/02/01 23:55:02 wpbasti Exp $


DESCRIPTION="The Cyrus SASL (Simple Authentication and Security Layer)"
HOMEPAGE="http://asg.web.cmu.edu/cyrus/"

S=${WORKDIR}/${P}
SRC_URI="ftp://ftp.andrew.cmu.edu/pub/cyrus-mail/${P}.tar.gz"
#SRC_URI="ftp://ftp.andrew.cmu.edu/pub/cyrus-mail/cyrus-sasl-2.1.2.tar.gz"
LICENSE="as-is"
SLOT="2"

RDEPEND="virtual/glibc
	>=sys-libs/db-3.2
	>=sys-libs/pam-0.75
	>=dev-libs/openssl-0.9.6"

DEPEND="virtual/glibc
	>=sys-libs/db-3.2
	>=sys-libs/pam-0.75
	>=dev-libs/openssl-0.9.6"

src_unpack() {

	unpack ${A} ; cd ${S}

}

src_compile() {

	./configure \
		--with-dblib=berkeley \
		--disable-sample \
		--prefix=/usr \
		--disable-otp \
		--disable-krb4 \
		--enable-login \
		--disable-gssapi \
		--with-saslauthd \
		--host=${CHOST} || die "bad ./configure"

	emake || die "compile problem"

}

src_install () {

	make DESTDIR=${D} install || die

	rm -rf ${D}usr/man
		
	mkdir -p ${D}var/state/saslauthd

	doman saslauthd/saslauthd.8 utils/saslpasswd2.8 utils/sasldblistusers2.8 man/*.?

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README doc/ONEWS doc/TODO # doc/testing.txt
	dohtml doc/*.html 
	newdoc pwcheck/README README.pwcheck
	docinto sample ; dodoc sample/*

	# Because it's important that etc/sasldb2 has correct rights, we are generating it here
	mkdir ${D}etc
	LD_OLD=${LD_LIBRARY_PATH}
	export LD_LIBRARY_PATH=${S}/lib/.libs
	# I think gentoo as password is better than nothing
	# Maybe we should use some long complicated, root could change it afterwards
	echo "gentoo" | ${D}usr/sbin/saslpasswd2 -f ${D}etc/sasldb2 -p cyrus
	export LD_LIBRARY_PATH=${LD_OLD}
	chown root.mail ${D}etc/sasldb2
	chmod 0640 ${D}etc/sasldb2

	cp doc/*.txt ${D}usr/share/doc/${P}/html

	insinto /etc/conf.d ; newins ${FILESDIR}/saslauthd.confd saslauthd
	exeinto /etc/init.d ; newexe ${FILESDIR}/saslauthd2.rc6 saslauthd
	
	ewarn "*******************************************************************"
	ewarn "* WARNING: The (sasl-)password for user cyrus is set to 'gentoo'. *"
	ewarn "*          CHANGE IT AS root WITH:                                *"
	ewarn "*          /usr/sbin/saslpasswd2 cyrus                            *"
	ewarn "*******************************************************************"

}
 
