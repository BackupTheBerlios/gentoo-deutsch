# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

IUSE="doc python"

inherit debug

S=${WORKDIR}/${P}
DESCRIPTION="Development series of Gimp"
SRC_URI="ftp://ftp.gimp.org/pub/gimp/v1.3/v${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.gimp.org/"
SLOT="1.4"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

#libglade
RDEPEND=">=x11-libs/gtk+-2.2.0
	>=x11-libs/pango-1.2.0
	>=dev-libs/glib-2.2.0
	>=media-libs/libpng-1.2.1
	>=media-libs/jpeg-6b-r2
	>=media-libs/tiff-3.5.7
	>=media-libs/libart_lgpl-2.3.8-r1
	sys-devel/gettext
	python? ( >=dev-lang/python-2.2 )"
# Bah, circ dependency
#	cups? ( media-gfx/gimp-print )
	

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.14.0
	doc? ( >=dev-util/gtk-doc-0.10 )"

pkg_setup() {
	ewarn ""
	ewarn "You have to unmerge previous versions of"
	ewarn "The Gimp 1.3.x (<=media-gfx/gimp-1.3.10)"
	ewarn "first."
	ewarn ""
	sleep 15
}


src_compile() {
	local myconf
	use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --disable-gtk-doc"
	use python && myconf="${myconf} --enable-python" \
		|| myconf="${myconf} --disable-python"

# circular dependency
# 	use cups && myconf="${myconf} --enable-print" || myconf="${myconf} --disable-print"
	myconf="${myconf} --disable-print"
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--localstatedir=/var/lib \
		--disable-perl ${myconf} \
		|| die

# hack for odd make break
	touch plug-ins/common/${P}.tar.bz2
	emake || die
}

src_install() {
	make DESTDIR=${D} prefix=/usr \
		sysconfdir=/etc \
		infodir=/usr/share/info \
		mandir=/usr/share/man \
		localstatedir=/var/lib \
		install || die
    
	dodoc AUTHORS COPYING ChangeL* HACKING INSTALL MAINTAINERS NEWS PLUGIN_MAINTAINERS README* TODO* 
}


post_install() {
	echo "You have to delete your private .gimp-1.3 directorie, since there is a new layout in gimp 1.3.11!"
}
