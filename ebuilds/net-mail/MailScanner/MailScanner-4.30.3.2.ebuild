# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-mail/MailScanner/MailScanner-4.30.3.2.ebuild,v 1.3 2004/05/24 17:20:45 mad Exp $

PV=4.30.3
SUBVERSION=2

S=${WORKDIR}/MailScanner-${PV}
DESCRIPTION="MailScanner / A Free Anti-Virus and Anti-Spam Filter "
HOMEPAGE="http://www.mailscanner.info/"
SRC_URI="http://www.sng.ecs.soton.ac.uk/mailscanner/files/4/tar/MailScanner-${PV}-${SUBVERSION}.tar.gz"

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
	sed -i \
		-e "s/\/opt\/MailScanner\/etc/\/etc\/MailScanner/g" \
		-e "s/^#\(TNEF.*internal\)$/\1/" \
		-e "s/^\(TNEF.*0000\)$/#\1/" \
		-e "s/^Virus Scanning = yes$/Virus Scanning = no/" \
		-e "s/^\(Run As User =\)$/\1 mail/" \
		-e "s/^\(Run As Group =\)$/\1 mail/" \
		-e "s/^PID file.*/PID file = \/var\/run\/MailScanner\/MailScanner.pid/" \
		${S}/etc/MailScanner.conf
    sed -i "s/^\$ConfFile.*/\$ConfFile \=\ \'\/etc\/MailScanner\/MailScanner\.conf\' unless \$ConfFile;/" \
		${S}/bin/MailScanner
}

src_install() {
	cd ${S}
	exeinto ${BASE}/bin
	newexe	bin/check_mailscanner.linux check_mailscanner
	doexe	bin/df2mbox
	doexe	bin/MailScanner
	doexe	bin/update_virus_scanners
	doexe	bin/upgrade_MailScanner_conf

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

	exeinto /etc/init.d
	newexe ${FILESDIR}/rc.mailscanner mailscanner

	mkdir -p ${D}usr/share/doc/${PF}/html
	cp -a docs/* ${D}usr/share/doc/${PF}/html
		
	dodoc COPYING INSTALL notes.txt README docs/QuickInstall.txt docs/README.sql-logging	

	dodir /opt/MailScanner/lib/MailScanner/CustomFunctions
	touch ${D}/opt/MailScanner/lib/MailScanner/CustomFunctions/.keep
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


