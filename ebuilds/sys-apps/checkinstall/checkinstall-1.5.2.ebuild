# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/sys-apps/checkinstall/checkinstall-1.5.2.ebuild,v 1.1 2002/07/05 23:09:11 holler Exp $

DESCRIPTION="CheckInstall installations tracker"
HOMEPAGE="http://checkinstall.izto.org/"

S=${WORKDIR}/${P}
SRC_URI="http://checkinstall.izto.org/files/source/${P}.tgz"
LICENSE="GPL-2"
SLOT="1"

RDEPEND="app-arch/rpm"
DEPEND="virtual/glibc"

src_compile() {

	emake PREFIX=/usr || die "compile problem"

}

src_install () {

        dosbin makepak

        sed -e 's:/usr/local/lib/checkinstall/checkinstallrc:/usr/lib/checkinstall/checkinstallrc:' \
		-e 's:INSTALLWATCH_PREFIX="/usr/local":INSTALLWATCH_PREFIX="/usr":' \
		-e 's:MAKEPKG=/usr/local/sbin/makepak:MAKEPKG=/usr/sbin/makepak:' \
		checkinstall >checkinstall.gentoo
        newsbin checkinstall.gentoo checkinstall

	dolib.so installwatch-0.6.3/installwatch.so
        sed -e 's:#PREFIX#:/usr:' installwatch-0.6.3/installwatch > installwatch-0.6.3/installwatch.gentoo
	newbin installwatch-0.6.3/installwatch.gentoo installwatch
	
        mkdir -p ${D}usr/lib/checkinstall
        sed -e 's:INSTALLWATCH_PREFIX="/usr/local":INSTALLWATCH_PREFIX="/usr":' checkinstallrc >checkinstallrc.gentoo
        cp checkinstallrc.gentoo ${D}/usr/lib/checkinstall/checkinstallrc

	dodoc doc-pak/*
	docinto installwatch-0.6.3; dodoc doc-pak/*
}

pkg_postinst () {
	ewarn "*************************************"
	ewarn "* WARNING: Remove the sgid-bit from *"
	ewarn "* make or checkinstall won't work!  *"
	ewarn "*************************************"
}
