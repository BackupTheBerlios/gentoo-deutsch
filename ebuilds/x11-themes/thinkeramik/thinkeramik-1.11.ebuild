inherit kde-base || die "Can't inherit kde-base!"
need-kde 3.1.2

S=${WORKDIR}/${P}
DESCRIPTION="A neat KDE 3.1 style based on Keramik"
HOMEPAGE="http://www.kdelook.org/content/show.php?content=6986"
SRC_URI="http://www.kdelook.org/content/files/6986-${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
DEPEND="kde-base/kdebase"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

src_compile(){
        ./configure --prefix=$KDEDIR||die
        emake||die
}

src_install(){
        emake DESTDIR=${D} install || die "emake install failed"
}

pkg_postinst(){
        ewarn "HOW TO USE THIS THEME FOR KDE:"
        einfo ""
        einfo "Open the KDE-Menu and start the Control Center."
        einfo "Select \"Look and Feel\"."
        einfo "Select \"Style\" if the package you installed was a style, or select \"Theme Manager\" if the package you installed was a theme."
        einfo "Select your theme or style."
        einfo "Click \"Apply\""
        einfo ""
        einfo "Have fun! :-)"
}
