# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-mail/cyrus-imap-admin/Attic/cyrus-imap-admin-2.1.4.ebuild,v 1.1 2002/07/05 20:12:30 holler Exp $

DESCRIPTION="Utilities to administer a Cyrus IMAP Server (includes Perl modules)"
HOMEPAGE="http://asg.web.cmu.edu/cyrus/imapd/"

S=${WORKDIR}/cyrus-imapd-2.1.4
SRC_URI="ftp://ftp.andrew.cmu.edu/pub/cyrus-mail/cyrus-imapd-2.1.4.tar.gz"
LICENSE="as-is"
SLOT="1"

RDEPEND="virtual/glibc
        afs? ( >=net-fs/openafs-1.2.2 )
        snmp? ( >=net-analyzer/ucd-snmp-4.2.3 )
        ssl? ( >=dev-libs/openssl-0.9.6 )
        >=sys-libs/db-3.2
        >=sys-libs/pam-0.75
	>=dev-libs/cyrus-sasl-2.1.2
	>=sys-devel/perl-5
	>=dev-lang/tcl-8.3.3
        >=sys-apps/tcp-wrappers-7.6"

DEPEND="virtual/glibc
        afs? ( >=net-fs/openafs-1.2.2 )
        snmp? ( >=net-analyzer/ucd-snmp-4.2.3 )
        ssl? ( >=dev-libs/openssl-0.9.6 )
        >=sys-libs/db-3.2
        >=sys-libs/pam-0.75
	>=dev-libs/cyrus-sasl-2.1.2
	>=sys-devel/perl-5
	>=dev-lang/tcl-8.3.3
        >=sys-apps/tcp-wrappers-7.6"


src_unpack() {

	unpack ${A} ; cd ${S}

}

src_compile() {

	local myconf
	
	use afs || myconf="--without-afs"
	use snmp || myconf="${myconf} --without-ucdsnmp"
	use ssl || myconf="${myconf} --without-openssl"

	./configure \
		--prefix=/usr \
		--without-krb \
		--without-gssapi \
		--enable-listext \
		--host=${CHOST} || die "bad ./configure"

	# make depends breaks with -f... in CFLAGS
	make depend CFLAGS="" || die "make depend problem"

	cd ${S}/lib
	emake || die "compile problem"
	cd ${S}/perl
	emake || die "compile problem"

}

src_install () {

	cd ${S}/perl

	# taken from perl-module.eclass
	make PREFIX=${D}usr \
		DESTDIR=${D} \
                INSTALLMAN1DIR=${D}/usr/share/man/man1 \
                INSTALLMAN3DIR=${D}/usr/share/man/man3 \
		install || die "install problem"

	eval `perl '-V:installarchlib'`
	ARCH_LIB=${installarchlib}

	eval `perl '-V:version'`
	POD_DIR="/usr/share/perl/gentoo-pods/${version}"

	echo "ARCH_LIB: '${ARCH_LIB}'"
	echo "POD_DIR: '${POD_DIR}'"
	
	mkdir -p ${D}/${POD_DIR}
	
        sed -e "s:${D}::g" \
                ${D}/${ARCH_LIB}/perllocal.pod \
                        > ${D}/${POD_DIR}/${P}.pod
        rm -f ${D}/${ARCH_LIB}/perllocal.pod

	rm -rf ${D}usr/lib/perl5/${version}

	cd ${S}
	doman man/sieveshell.1 man/installsieve.1
        dodoc COPYRIGHT README*
	
}
