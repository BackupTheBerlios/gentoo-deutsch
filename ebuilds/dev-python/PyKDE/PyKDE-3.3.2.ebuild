# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/dev-python/PyKDE/PyKDE-3.3.2.ebuild,v 1.1 2002/08/31 10:23:00 tschortsch Exp $

S="${WORKDIR}/PyKDE-3.3.2"
DESCRIPTION="PyKDE is a set of Python bindings for the KDE libs (VERSION 3.x ONLY!!)."
#we need the sip files in pyqt/sip
SRC_URI="http://www.river-bank.demon.co.uk/download/PyKDE2/PyKDE-3.3.2-3.tar.gz
	http://www.riverbankcomputing.co.uk/download/snapshots/PyQt/PyQt-snapshot-20020722.tar.gz"

HOMEPAGE="http://www.riverbankcomputing.co.uk/pykde/"
SLOT="0"
LICENSE="MIT"
KEYWORDS="x86"
DEPEND="virtual/glibc
	sys-devel/libtool
	>=x11-libs/qt-3.0.4.1
    	>=dev-lang/python-2.2.1
    	=dev-python/sip-3.3.2
	=dev-python/PyQt-3.3.2
	>=kde-base/kdelibs-3.0.0"

PYTARGET=/usr/lib/python2.2/site-packages

src_unpack() {
	unpack ${A} || die
	cd ${S}
	#this is the debian patch to allow installation to ${D}
	patch -p0 < ${FILESDIR}/build.py.patch || die
	#but we still need to add the build dir to the linking path
	patch -p1 < ${FILESDIR}/linkingdirs.patch || die
}


src_compile() {
	cd ${S}
	mkdir -p ${D}${PYTARGET}
	mkdir -p ${D}/usr/include/python2.2
	python  build.py -c -l qt-mt -v ../PyQt-snapshot-20020722/sip \
	-d ${D}/${PYTARGET} -s ${PYTARGET} || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	cd ${S}
	dohtml ./doc/*
	dodoc ChangeLog AUTHORS THANKS README 
}


