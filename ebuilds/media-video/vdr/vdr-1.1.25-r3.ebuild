# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdr/Attic/vdr-1.1.25-r3.ebuild,v 1.2 2003/03/18 19:33:15 fow0ryl Exp $

IUSE="lirc rcu vdr_sc vdr_elchi vdr_vfat"

ELCHI="ElchiAIO3-1.1.25"
SC_VER="0.1.10"

S=${WORKDIR}/${P}
DESCRIPTION="The Video Disk Recorder"
HOMEPAGE="http://linvdr.org/"
SRC_URI="http://linvdr.org/download/vdr/Developer/${P}.tar.bz2
	vdr_sc? http://208.231.8.113/vdr-sc-${SC_VER}.tar.gz
	vdr_elchi? http://www.fh-lippe.de/~mad/${ELCHI}.diff.gz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc virtual/linux-sources >=linuxdvb-1.0.0_pre1-r3 media-libs/jpeg"


src_unpack() {
	unpack ${A}
	if [ -n "`use vdr_elchi`" ]; then
		cd ${S}
		patch < ${WORKDIR}/${ELCHI}.diff || die "patch problem"
	fi

	if [ -n "`use vdr_sc`" ]; then
		cd ${S}/PLUGINS/src
		unpack vdr-sc-${SC_VER}.tar.gz
		cp ${S}/PLUGINS/src/sc-${SC_VER}/patches/vdr-${PV}-sc.diff ${S}/sc.diff
		cd ${S}
		cat ${S}/sc.diff | patch -p1
	fi
}

src_compile() {
	local myconf
	use vdr_vfat && myconf="${myconf} VFAT=1"
	use lirc && myconf="${myconf} REMOTE=LIRC"
	use rcu && myconf="${myconf} REMOTE=RCU"

	make ${myconf} || die "compile problem"
}

src_install() {
	insinto /etc/conf.d
	newins ${FILESDIR}/confd.${P} vdr
	insinto /etc/init.d
	insopts -m755
	newins ${FILESDIR}/rc.${P} vdr
	newins ${FILESDIR}/rc.vdrwatchdog vdrwatchdog
	
	dodoc CONTRIBUTORS COPYING README INSTALL MANUAL HISTORY
	dohtml PLUGINS.html
	doman vdr.[15] 
	insinto /usr/include/vdr
	doins *.h
	exeinto /usr/bin
	doexe vdr
	doexe ${FILESDIR}/vdrwatchdog.sh 
	insinto /etc/vdr
	doins *.conf
}

pkg_postinst() {

	einfo "Congratulations, you have just installed VDR,"
	einfo "The Digital Video Recorder. To get started you"
	einfo "should read, read, read ..."
}
