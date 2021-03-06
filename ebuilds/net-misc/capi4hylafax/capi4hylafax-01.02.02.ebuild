# Copyright 2002 Alexander Holler
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-misc/capi4hylafax/capi4hylafax-01.02.02.ebuild,v 1.1 2003/03/08 17:51:34 holler Exp $

S=${WORKDIR}/${P}
DESCRIPTION="CAPI4HylaFAX - CAPI driver for HylaFAX (currently without any special Hylafax-support, but standalone fax receiving works fine)"
SRC_URI="ftp://ftp.avm.de/tools/capi4hylafax.linux/${P}.tar.gz"
HOMEPAGE="http://www.avm.de/"
SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86"

# USE-flags:
#
#	hylafax - operation with hylafax (needs to be done and tested)
#

RDEPEND="virtual/glibc
	media-libs/tiff
	net-dialup/capi4k-utils
	net-mail/metamail
	app-text/ghostscript
	hylafax? (net-misc/hylafax)"

DEPEND="virtual/glibc
	media-libs/tiff
	net-dialup/capi4k-utils
	sys-devel/automake"

src_compile() {

	./configure || die
	emake || die

}

src_install() {															 

	dobin src/faxrecv/c2faxrecv src/faxsend/c2faxsend
#	./install -s -p ${D}var/spool/hylafax -d ${D}usr/bin
	dodoc AUTHORS COPYING Liesmich* Readme_C*
	mv GenerateFileMail.pl GenerateFileMail.pl.orig
	cat GenerateFileMail.pl.orig | sed 's:mimencode $file:/usr/bin/mimencode \\"$file\\":' >GenerateFileMail.pl
	cat sample_faxrcvd | sed -e 's:GenerateFileMail.pl:/etc/c2faxrecv/GenerateFileMail.pl:' \
		-e 's:basename $SendFile:basename \\"$SendFile\\":' > faxrcvd.sample 
	exeinto /etc/c2faxrecv 
	doexe GenerateFileMail.pl faxrcvd.sample
	cat config.faxCAPI | sed \
		-e 's;^SpoolDir:\(.*\)/var/spool/fax;SpoolDir:\1/var/spool/c2faxrecv;' \
		-e 's;^FaxReceiveUser:;#FaxReceiveUser:;' \
		-e 's:/var/spool/fax/bin/faxrcvd:/etc/c2faxrecv/faxrcvd:' \
		-e 's:/var/spool/fax/bin/pollrcvd:/etc/c2faxrecv/pollrcvd:' \
		-e 's:# /tmp/capifax.log:/var/log/c2faxrecv.log:' \
		> c2faxrecv.conf.sample
	insinto /etc/c2faxrecv
	doins c2faxrecv.conf.sample
	exeinto /etc/init.d
	doexe ${FILESDIR}/c2faxrecv
	dodir /var/spool/c2faxrecv
	use hylafax && {
		cat config.faxCAPI | sed \
			-e 's;^SpoolDir:\(.*\)/var/spool/fax;SpoolDir:\1/var/spool/hylafax;' \
			-e 's;^FaxRcvdCmd:\(.*\)/var/spool/fax;FaxRcvdCmd:\1/var/spool/hylafax;' \
			-e 's:# /tmp/capifax.log:/var/log/c2faxrecv.log:' \
			> config.faxCAPI.hylafax
		insinto /var/spool/hylafax/etc
		newins config.faxCAPI.hylafax config.faxCAPI
	}

}
