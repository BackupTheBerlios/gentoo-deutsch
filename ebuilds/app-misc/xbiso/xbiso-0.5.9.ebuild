DESCRIPTION="iso extraction utillity for xdvdfs images (used for xbox)"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/xbiso"

LICENSE="GPL"
KEYWORDS="~x86"

# Compilation will fail using -Os !
replace-flags -Os -O2

src_install() {
	#exeinto /usr/bin; doexe ${WORKDIR}/${P}/${PN}
	exeinto /usr/bin; doexe ${PN}
}
