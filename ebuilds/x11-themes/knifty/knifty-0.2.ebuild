inherit kde-base || die "Can't inherit kde-base!"
need-kde 3.1.2

S=${WORKDIR}/${P}
DESCRIPTION="A native KWin window decoration for KDE 3.x"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=7290"
SRC_URI="http://www.kdelook.org/content/files/7290-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
DEPEND="kde-base/kdebase"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

src_compile(){
	epatch ${FILESDIR}/knifty.desktop.diff
        ./configure --prefix=$KDEDIR||die
        emake||die
}

src_install(){
        emake DESTDIR=${D} install || die "emake install failed"
}
