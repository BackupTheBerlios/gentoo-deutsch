# Copyright 2003 Sascha Rusch
# Distributed under the terms of the GNU General Public License v2
inherit kde-base || die

DESCRIPTION="A Scalable Vector Graphics (SVG) authoring tool"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://k2d.sourceforge.net/"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

need-kde 3

DEPEND=">=kde-base/kdelibs-3.1
	>=media-libs/libart_lgpl-2.3.8
	>=media-libs/fontconfig-2.0
	>=media-libs/lcms-1.09
	>=media-libs/freetype-2"
RDEPEND=">=kde-base/kdelibs-3.1
	>=media-libs/libart_lgpl-2.3.8
	>=media-libs/fontconfig-2.0
	>=media-libs/lcms-1.09
	>=media-libs/freetype-2"

