# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/em8300-modules-cvs/em8300-modules-cvs-20031209.ebuild,v 1.2 2004/03/10 21:30:35 austriancoder Exp $

ECVS_SERVER="cvs.dxr3.sourceforge.net:/cvsroot/dxr3"
ECVS_MODULE="em8300"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"

inherit cvs debug flag-o-matic
strip-flags

S=${WORKDIR}/${ECVS_MODULE}/modules
DESCRIPTION="em8300 (RealMagic Hollywood+/Creative DXR3) video decoder card cvs kernel modules"
HOMEPAGE="http://dxr3.sourceforge.net/"
SRC_URI=
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/linux-sources"
RDEPEND="${DEPEND} >=sys-apps/portage-1.9.10"

src_compile() {
cd ${S}
	# NTSC default...
	#sed 	-e 's/PAL/NTSC/g' \
	#	Makefile > Makefile.hacked
	#mv Makefile.hacked Makefile
	make clean all || die "problem compiling modules"
}

src_install() {
	insinto "/usr/src/linux/include/linux"
	doins ../include/linux/em8300.h
	# The driver to the standard modules location
	insinto "/lib/modules/${KV}/kernel/drivers/video"
	doins em8300.o bt865.o adv717x.o
	# Docs
	dodoc README-modoptions \
	README-modules.conf \
	devfs_symlinks \
	ldm \
	rmm
	
	insinto /etc/modules.d
	newins ${FILESDIR}/modules.em8300 em8300
}

pkg_postinst () {

	if [ "${ROOT}" = "/" ]
	then
		[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
	fi

	einfo
	einfo "The em8300 kernel modules have been installed into the modules"
	einfo "directory of your currently running kernel.  They haven't been"
	einfo "loaded.  Please read the documentation, and if you would like"
	einfo "to have the modules load at startup, add em8300, bt865, adv717x"
	einfo "to your /etc/modules.autoload they may need module options to "
	einfo "work correctly on your system.  You will also need to add"
	einfo "the contents of /usr/share/doc/${P}/devfs_symlinks.gz"
	einfo "to your devfsd.conf so that the em8300 devices will be linked"
	einfo "correctly."
	einfo
	einfo "You will also need to have the i2c kernel modules compiled for"
	einfo "this to be happy, no need to patch any kernel though just turn"
	einfo "all the i2c stuff in kernel config to M and you'll be fine."
	einfo

}

