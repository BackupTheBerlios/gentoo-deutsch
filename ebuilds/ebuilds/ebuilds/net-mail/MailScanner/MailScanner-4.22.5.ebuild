# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/ebuilds/ebuilds/net-mail/MailScanner/Attic/MailScanner-4.22.5.ebuild,v 1.1 2003/08/22 15:27:30 fow0ryl Exp $

PV=4.22-5
S=${WORKDIR}/MailScanner-${PV}
DESCRIPTION="MailScanner / A Free Anti-Virus and Anti-Spam Filter "
HOMEPAGE="http://www.mailscanner.info/"
SRC_URI="http://www.sng.ecs.soton.ac.uk/mailscanner/files/4/tar/MailScanner-${PV}.tar.gz"

BASE="/opt/MailScanner"

KEYWORDS="~x86 ~sparc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="dev-lang/perl
		dev-perl/Convert-TNEF
		dev-perl/File-Temp
		dev-perl/MIME-tools
		dev-perl/HTML-Parser
		dev-perl/HTML-Tagset
		dev-perl/File-Spec
		dev-perl/MailTools
		dev-perl/MIME-Base64
		dev-perl/IO-stringy
		"

src_unpack() {
	unpack ${A}
}

src_compile() {
	sed -i "s/libdir=\/usr\/lib\/MailScanner/libdir=\/opt\/MailScanner\/lib/" ${S}/bin/check_mailscanner.linux
	sed -i "s/opt\/MailScanner\/etc/\/etc\/MailScanner/" ${S}/bin/MailScanner
	sed -i \
		-e "s/\/opt\/MailScanner\/etc/\/etc\/MailScanner/g" \
		-e "s/^#\(TNEF.*internal\)$/\1/" \
		-e "s/^\(TNEF.*0000\)$/#\1/" \
		-e "s/^Virus Scanning = yes$/Virus Scanning = no/" \
		-e "s/^\(Run As User =\)$/\1 mail/" \
		-e "s/^\(Run As Group =\)$/\1 mail/" \
		-e "s/^PID file.*/PID file = \/var\/run\/MailScanner\/MailScanner.pid/" \
		${S}/etc/MailScanner.conf
	sed -i \
		-e "s/\/opt\/MailScanner\/etc\//\/etc\/MailScanner\//g" \
		${S}/lib/MailScanner/ConfigDefs.pl
		# change run as user and group
}

src_install() {
	cd ${S}
	exeinto ${BASE}/bin
	newexe	bin/check_mailscanner.linux check_mailscanner
	doexe	bin/df2mbox
	doexe	bin/MailScanner
	doexe	bin/update_virus_scanners

	insinto	/etc/MailScanner
	doins	etc/*.conf
	insinto	/etc/MailScanner/rules
	doins	etc/rules/*
	for i in $(ls etc/reports/)
	do
		insinto /etc/MailScanner/reports/$i
		doins etc/reports/$i/*
	done

	insinto	${BASE}/lib
	doins lib/*

	insinto	${BASE}/lib/MailScanner
	doins lib/MailScanner/*

	mkdir -p ${D}usr/share/doc/${PF}/html
	cp -a docs/* ${D}usr/share/doc/${PF}/html
		
	dodoc COPYING INSTALL notes.txt README docs/QuickInstall.txt docs/README.sql-logging	

	dodir /var/spool/MailScanner/incoming
	touch ${D}/var/spool/MailScanner/incoming/.keep
	dodir /var/spool/MailScanner/quarantine
	touch ${D}/var/spool/MailScanner/quarantine/.keep
	dodir /var/spool/MailScanner/spamassassin
	touch ${D}/var/spool/MailScanner/spamassassin/.keep
	dodir /var/spool/MailScanner/archiv
	touch ${D}/var/spool/MailScanner/archiv/.keep
	chown -R mail.mail ${D}/var/spool/MailScanner/
	dodir ${BASE}/var
	touch ${D}${BASE}/var/.keep
	

}


