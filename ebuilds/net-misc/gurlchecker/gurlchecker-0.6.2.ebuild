inherit gnome2

IUSE="gnome"

SRC_URI="http://savannah.nongnu.org/download/gurlchecker/stable/0.6/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/gurlchecker/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=gnome-base/libgnomeui-2
        >=gnome-base/libglade-2"

RDEPEND="${DEPEND}
        >=dev-util/intltool-0.22
        sys-devel/gettext
        dev-util/pkgconfig"

DOCS="ABOUT-NLS THANKS AUTHORS ChangeLog COPYING INSTALL NEWS TODO README"
