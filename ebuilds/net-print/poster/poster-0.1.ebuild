DESCRIPTION="small utility for making a poster from an EPS file or a one-page PS document"
SRC_URI="http://www.geocities.com/SiliconValley/5682/poster.tgz"
HOMEPAGE="http://www.geocities.com/SiliconValley/5682/poster.html"

LICENSE="none"
KEYWORDS="~x86 ~amd64"

append-flags -lm
P=${PN}

src_compile(){
	tar xzf ${PN}.tar.gz
	gcc ${CFLAGS} -o poster poster.c
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
}
