inherit kde-base

S=${WORKDIR}/kio_gopher-${PV}
HOMEPAGE="http://kgopher.berlios.de/"
DESCRIPTION="kio_gopher is a gopher kioslave"
SRC_URI="http://download.berlios.de/kgopher/kio_gopher-${PV}.tar.bz2"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

need-kde 3

DEPEND=">=kde-base/kdelibs-3"
RDEPEND=">=kde-base/kdelibs-3"

src_install(){
        emake DESTDIR=${D} install || die "emake install failed"
        dodoc COPYING INSTALL README AUTHORS
}
