# Copyright 2004 Stefan Nickl <snickl@snickl.freaks.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-radio/drm/drm-1.0.6.ebuild,v 1.1 2004/03/22 14:47:58 snickl Exp $

IUSE=""
DESCRIPTION="Open-Source Software Implementation of a DRM-Receiver"
HOMEPAGE="http://drm.sourceforge.net/"
SRC_URI="mirror://sourceforge/drm/${P}.tar.gz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
		>=media-libs/faad2-2.0
		>=x11-libs/qwt-4.2.0_rc1
		<dev-libs/fftw-3.0.0
		>=sys-devel/autoconf-2.58"

src_compile() {
	addwrite "${ROOT}/usr/qt/3/etc/settings"

	econf
	emake || die
}

src_install() {
	einstall || die
	dodoc README AUTHORS COPYING ChangeLog INSTALL

	einfo
	einfo "If you get an error about a missing libqwt.so.4"
	einfo "when starting drm, run ldconfig and try again"
	einfo
}

