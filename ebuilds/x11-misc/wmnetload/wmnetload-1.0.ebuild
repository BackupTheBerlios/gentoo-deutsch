#Jürg Marti <tschortsch@gmx.ch>

DESCRIPTION="A WindowMaker dock app showing network usage"
HOMEPAGE="http://freshmeat.net/projects/wmnetload"

S=${WORKDIR}/${P}
SRC_URI="ftp://truffula.com/pub/${P}.tar.gz"
DEPEND="virtual/x11
	>=libdockapp-0.4.0"

src_compile() {
	./configure --prefix=/usr
	make || die
}

src_install () {
	make prefix=${D}/usr install || die
}
