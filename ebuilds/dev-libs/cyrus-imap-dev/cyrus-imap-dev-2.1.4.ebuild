# Copyright 2002 Alexander Holler
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/dev-libs/cyrus-imap-dev/Attic/cyrus-imap-dev-2.1.4.ebuild,v 1.3 2003/02/01 23:55:02 wpbasti Exp $


DESCRIPTION="Developer support for the Cyrus IMAP Server"
HOMEPAGE="http://asg.web.cmu.edu/cyrus/imapd/"

S=${WORKDIR}/cyrus-imapd-2.1.4
SRC_URI="ftp://ftp.andrew.cmu.edu/pub/cyrus-mail/cyrus-imapd-2.1.4.tar.gz"
LICENSE="as-is"
SLOT="1"

RDEPEND="virtual/glibc"
DEPEND="virtual/glibc
	afs? ( >=net-fs/openafs-1.2.2 )
	snmp? ( >=net-analyzer/ucd-snmp-4.2.3 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	>=sys-libs/db-3.2
	>=sys-libs/pam-0.75
	>=dev-libs/cyrus-sasl-2.1.2
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
		--disable-cyradm \
		--without-perl \
		--enable-listext \
		--host=${CHOST} || die "bad ./configure"

	# make depends breaks with -f... in CFLAGS
	make depend CFLAGS="" || die "make depend problem"

	cd ${S}/lib
	emake || die "compile problem"
	cd ${S}/acap
	emake || die "compile problem"

}

src_install () {

	cd ${S}/lib
	mkdir -p -m 0755 ${D}usr/include/cyrus
	emake DESTDIR=${D} install || die "compile problem"
	cd ${S}/acap
	emake DESTDIR=${D} install || die "compile problem"
	cd ${S}
	dodoc COPYRIGHT README*

}
 
