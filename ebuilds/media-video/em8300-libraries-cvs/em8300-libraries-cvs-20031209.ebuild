# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/em8300-libraries-cvs/em8300-libraries-cvs-20031209.ebuild,v 1.1 2003/12/09 22:57:32 rootshell Exp $

ECVS_SERVER="cvs.dxr3.sourceforge.net:/cvsroot/dxr3"
ECVS_MODULE="em8300"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"

inherit cvs debug flag-o-matic
strip-flags

S=${WORKDIR}/${ECVS_MODULE}
DESCRIPTION="em8300 (RealMagic Hollywood+/Creative DXR3) video decoder card cvs libraries"
HOMEPAGE="http://dxr3.sourceforge.net/"
SRC_URI=
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="media-video/em8300-modules
	x11-libs/gtk+"
RDEPEND="${DEPEND} >=sys-apps/portage-1.9.10"

src_compile() {
cd ${S}
	./bootstrap || die "bootstrap failed"
	econf || die
	emake || die "emake failed"

}

src_install() {
	make em8300incdir=${D}/usr/include/linux/ \
		prefix=${D}/usr \
		datadir=${D}/usr/share \
		sysconfdir=/etc \
		oldincludedir=${D}/usr/include \
		install || die
	insinto /usr/share/misc
	doins modules/em8300.uc
	dodoc AUTHORS COPYING ChangeLog README
}

pkg_postinst() {

	einfo
	einfo "The em8300 libraries and modules have now beein installed,"
	einfo "you will probably want to add /usr/bin/em8300setup to your"
	einfo "/etc/conf.d/local.start so that your em8300 card is "
	einfo "properly initialized on boot."
	einfo
	einfo "If you still need a microcode other than the one included"
	einfo "with the package, you can simply use em8300setup <microcode.ux>"
	einfo

}

