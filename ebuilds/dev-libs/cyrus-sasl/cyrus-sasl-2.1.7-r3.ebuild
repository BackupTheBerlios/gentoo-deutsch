# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/dev-libs/cyrus-sasl/cyrus-sasl-2.1.7-r3.ebuild,v 1.5 2003/02/01 23:55:02 wpbasti Exp $


S=${WORKDIR}/${P}

DESCRIPTION="The Cyrus SASL (Simple Authentication and Security Layer)"
HOMEPAGE="http://asg.web.cmu.edu/sasl/"
SRC_URI="ftp://ftp.andrew.cmu.edu/pub/cyrus-mail/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 -ppc -sparc -sparc64"

RDEPEND=">=sys-libs/db-3.2
	>=sys-libs/pam-0.75
	>=dev-libs/openssl-0.9.6d
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	berkdb? ( >=sys-libs/db-3.2.9 )
	ldap? ( >=net-nds/openldap-2.0.25 )
	mysql? ( >=dev-db/mysql-3.23.51 )
	kerberos? ( >=app-crypt/krb5-1.2.5 )"
	
DEPEND="${RDEPEND}
	sys-devel/libtool
	sys-devel/autoconf
	sys-devel/automake"


src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/cyrus-sasl-iovec.diff || die
	patch -p1 < ${FILESDIR}/crypt.diff || die
	patch -p0 < ${FILESDIR}/cyrus-sasl-gcc32.patch || die

}

src_compile() {

	local myconf

	libtoolize --copy --force
	aclocal -I config -I cmulocal
	autoheader
	autoconf
	automake -a --foreign

	use ldap && myconf="${myconf} --with-ldap" \
		|| myconf="${myconf} --without-ldap"

	use mysql && myconf="${myconf} --with-mysql" \
		|| myconf="${myconf} --without-mysql"

	if use berkdb; then
		myconf="${myconf} --with-dblib=berkeley"
	elif use gdbm; then
		myconf="${myconf} --with-dblib=gdbm --with-gdbm=/usr"
	else
		myconf="${myconf} --with-dblib=berkeley"
	fi

	use static && myconf="${myconf} --enable-static --with-staticsasl" \
		|| myconf="${myconf} --disable-static --without-staticsasl"

	#use kerberos && myconf="${myconf} --enable-krb4" \
	#	|| myconf="${myconf} --disable-krb4"	
	#Ya this seems wierd, but I'm guessing we'd rather prefer GSSAPI auth.

	econf \
		--with-saslauthd=/var/lib/sasl2 \
		--with-pwcheck=/var/lib/sasl2 \
		--with-configdir=/etc/sasl2 \
		--with-openssl \
		--with-plugindir=/usr/lib/sasl2 \
		--with-dbpath=/etc/sasl2/sasldb2 \
		--with-des \
		--with-rc4 \
		--disable-krb4 \
		--with-gnu-ld \
		--enable-shared \
		--disable-sample \
		--enable-login \
		${myconf} || die "bad ./configure"

	make || die "compile problem"
}

src_install () {
	make DESTDIR=${D} install || die "install problem"

	dodoc AUTHORS ChangeLog COPYING NEWS README doc/*.txt
	docinto examples ; dodoc sample/{*.[ch],Makefile}
	newdoc pwcheck/README README.pwcheck
	dohtml doc/*

	dodir /var/lib/sasl2
	dodir /etc/sasl2
	# generate an empty sasldb2 with correct permissions
	LD_OLD=${LD_LIBRARY_PATH}
	export LD_LIBRARY_PATH=${S}/lib/.libs
	echo "gentoo" | ${D}usr/sbin/saslpasswd2 -f ${D}etc/sasl2/sasldb2 -p cyrus
	${D}usr/sbin/saslpasswd2 -f ${D}etc/sasl2/sasldb2 -d cyrus
	export LD_LIBRARY_PATH=${LD_OLD}
	chown postfix.mail ${D}etc/sasl2/sasldb2
	chmod 0640 ${D}etc/sasl2/sasldb2
																
	insinto /etc/conf.d ; newins ${FILESDIR}/saslauthd.confd saslauthd
	exeinto /etc/init.d ; newexe ${FILESDIR}/saslauthd2.rc6 saslauthd
	exeinto /etc/init.d ; newexe ${FILESDIR}/pwcheck.rc6 pwcheck
}
 
