# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit cvs

ECVS_CVS_COMMAND="cvs"
ECVS_ANON="yes"
ECVS_SERVER="cvs.sourceforge.net:/cvsroot/vidix"
ECVS_MODULE="vidix"
ECVS_TOPDIR="${DISTDIR}/cvs-src/vidix"

S=${WORKDIR}/vidix
DESCRIPTION="This is the CVS standalone VIDeo Interface for uniX"
HOMEPAGE="http://vidix.sourceforge.net/"
LICENSE="GPL"
SLOT="1"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
RDEPEND=""

src_unpack() {
	cvs_src_unpack
	unpack ${A} || die "unpack failed"
}

src_compile() {
	cd ${S}
	ewarn ${S}
	./configure --prefix=/usr || die "./configure failed."
	make || die "compile problem"
}

src_install() {
    cd ${S}

    cd ${S}/libdha
    insinto /usr/lib
    insopts -m0755
    doins libdha-0.4.so 
    dosym /usr/lib/libdha-0.4.so /usr/lib/libdha.so


    cd ${S}/vidix
    insinto /usr/lib
    insopts -m0755
    doins libvidix.so 

    insinto /usr/include/vidix
    doins *.h


    cd ${S}/vidix/drivers
    insinto /usr/lib/vidix
    insopts -m0755
    doins *.so
}

