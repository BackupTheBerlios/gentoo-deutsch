DESCRIPTION="iso extraction utillity for xdvdfs images (used for xbox)"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/xbiso"

LICENSE="GPL"
KEYWORDS="~x86 ~amd64"

# Otherwise compilation will break for amd64 or when using -Os
append-flags -lm

src_install() {
	dobin ${PN}
}
