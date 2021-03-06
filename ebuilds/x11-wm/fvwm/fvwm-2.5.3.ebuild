# Ingo Rohlfs (irohlfs@irohlfs.de)

S=${WORKDIR}/${P}
DESCRIPTION="an extremely powerful ICCCM-compliant multiple virtual desktop window manager"
SRC_URI="ftp://ftp.fvwm.org/pub/fvwm/version-2/${P}.tar.bz2"
HOMEPAGE="http://www.fvwm.org/"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

RDEPEND=">=dev-libs/libstroke-0.4
	gtk? ( =x11-libs/gtk+-1.2* )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
	ncurses? ( >=sys-libs/readline-4.1 )"
DEPEND="${RDEPEND} sys-devel/automake"

src_unpack() {

	unpack ${A}
}

src_compile() {
	local myconf

	use gnome \
		&& myconf="--with-gnome" \
		|| myconf="--without-gnome" \

	automake

	econf \
		--libexecdir=/usr/lib \
		${myconf} || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	echo "#!/bin/bash" > fvwm2
	echo "/usr/bin/fvwm2" >> fvwm2

	exeinto /etc/X11/Sessions
	doexe fvwm2
}
 
