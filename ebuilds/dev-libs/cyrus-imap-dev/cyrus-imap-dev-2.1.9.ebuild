# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/dev-libs/cyrus-imap-dev/Attic/cyrus-imap-dev-2.1.9.ebuild,v 1.2 2003/02/01 23:55:02 wpbasti Exp $


S=${WORKDIR}/cyrus-imapd-${PV}

DESCRIPTION="Developer support for the Cyrus IMAP Server"
HOMEPAGE="http://asg.web.cmu.edu/cyrus/imapd/"
SRC_URI="ftp://ftp.andrew.cmu.edu/pub/cyrus-mail/cyrus-imapd-${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 -ppc -sparc -sparc64"

# Haven't checked if all that is needed for the libs
# just taken from cyrus-imapd
DEPEND="virtual/glibc
	afs? ( >=net-fs/openafs-1.2.2 )
	snmp? ( >=net-analyzer/ucd-snmp-4.2.3 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	kerberos? ( >=app-crypt/krb5-1.2.5 )
	>=sys-libs/db-3.2
	>=sys-libs/pam-0.75
	>=dev-libs/cyrus-sasl-2.1.2
	>=sys-apps/tcp-wrappers-7.6"
RDEPEND="${DEPEND}"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch < ${FILESDIR}/config.diff || die "patch failed"

}

src_compile() {

	local myconf
	
	use afs && myconf="--with-afs" \
		|| myconf="--without-afs"

	use snmp && myconf="${myconf} --with-ucdsnmp=/usr" \
		|| myconf="${myconf} --without-ucdsnmp"

	use ssl && myconf="${myconf} --with-openssl=/usr" \
		|| myconf="${myconf} --without-openssl"

	use kerberos && myconf="${myconf} --with-krb --with-auth=krb" \
		|| myconf="${myconf} --without-krb --with-auth=unix"

	econf \
		--enable-listext \
		--with-cyrus-group=mail \
		--enable-netscapehack \
		--with-com_err=yes \
		--without-perl \
		--disable-cyradm \
		${myconf} || die "bad ./configure"

	# make depends break with -f... in CFLAGS
	make depend CFLAGS="" || die "make depend problem"

	cd ${S}/lib
	make || die "compile problem"
	cd ${S}/acap
	make || die "compile problem"

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
 
