# Author Craig Dooley <cd5697@albany.edu>

DESCRIPTION="A dock app showing memory and cpu usage"
HOMEPAGE="http://www.sh.rim.or.jp/~ssato/dockapp/index.shtml#wmmemmon"

S=${WORKDIR}/${P}
SRC_URI="http://www.sh.rim.or.jp/~ssato/src/${P}.tar.bz2"
DEPEND="virtual/x11"

src_compile() {
	./configure --prefix=/usr
	make || die
}

src_install () {
	make prefix=${D}/usr install || die
}
