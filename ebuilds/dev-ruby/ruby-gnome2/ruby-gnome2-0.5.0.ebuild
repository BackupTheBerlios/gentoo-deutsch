DESCRIPTION="Ruby gnome2 bindings"
HOMEPAGE="http://ruby-gnome2.sourceforge.jp/"
SRC_URI="mirror://sourceforge/ruby-gnome2/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~ppc ~sparc ~x86"
DEPEND=">=dev-lang/ruby-1.6
	>=dev-libs/glib-2
	>=media-libs/gdk-pixbuf-0.20
	>=x11-libs/gtk+-2
	>=x11-libs/pango-1.1
	>=gnome-base/libgnome-2"

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README
}
