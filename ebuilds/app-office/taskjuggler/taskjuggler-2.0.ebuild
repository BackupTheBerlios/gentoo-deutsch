DESCRIPTION="project management tool for Linux and UNIX system-based operating systems"
SRC_URI="http://www.taskjuggler.org/download/taskjuggler-2.0.tar.bz2"
HOMEPAGE="http://taskjuggler.org"

LICENSE="GPL"
KEYWORDS="~x86 ~amd64"

IUSE="kde"

# Otherwise compilation will break for amd64 or when using -Os
DEPEND=">=qt-3.1"
RDEPEND="${DEPEND}
         dev-perl/Class-MethodMaker
		 dev-perl/Date-Calc
		 dev-perl/Data-Dumper
		 dev-perl/PostScript-Simple
		 dev-perl/XML-Parser
		 net-print/poster
		 "

src_compile() {
	use kde && myconf="${myconf} --with-kde-support"
	econf \
		`use_with kde kde-support` \
		|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "install failed"
}

