# Ebuild Submitted By AutoBot (autobot@midsouth.rr.com)

S=${WORKDIR}/${P}

DESCRIPTION="wmmemload is a simple dockapp for X Windows and WindowMaker that displays memory and swap space usage."
SRC_URI="http://www.markstaggs.net/wmmemload/${P}.tar.gz"
HOMEPAGE="http://www.markstaggs.net/"
DEPEND="x11-base/xfree"
#RDEPEND=""

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
	#make || die
}

src_install () {
	make DESTDIR=${D} install || die
	#make \
	#	prefix=${D}/usr \
	#	mandir=${D}/usr/share/man \
	#	infodir=${D}/usr/share/info \
	#	install || die
}
