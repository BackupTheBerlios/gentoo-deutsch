# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

#provide Xmake and Xemake
inherit virtualx libtool gnome2

DESCRIPTION="Gnumeric, the GNOME Spreadsheet"
HOMEPAGE="http://www.gnome.org/gnome-office/gnumeric.shtml"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/sources/gnumeric/1.1/${P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE="nls libgda gb evo python guile perl"

#Eye Of Gnome (media-gfx/eog) is for image support.
RDEPEND=">=x11-libs/gtk+-2
	>=dev-libs/glib-2
	>=gnome-base/libgnome-2.0.0
	>=gnome-base/libgnomeui-2.0.0
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/libbonoboui-2.0.0
	>=gnome-base/libgnomeprint-2.0.0
	>=gnome-base/libgnomeprintui-2.0.0
	>=gnome-extra/gal2-0.0.7
	>=gnome-extra/libgsf-1.6.0
	>=gnome-base/libglade-2.0.0
	>=dev-libs/libxml2-2.4.12
	perl?   ( >=sys-devel/perl-5.6 )
	python? ( >=dev-lang/python-2.0 )
	gb?     ( ~gnome-extra/gb-0.0.17 )
	libgda? ( >=gnome-extra/libgda-0.2.91
	          >=gnome-base/bonobo-1.0.17 )
	evo?    ( >=net-mail/evolution-1.0.8 )"

DEPEND="${RDEPEND}
	 nls? ( sys-devel/gettext
	 >=dev-util/intltool-0.9 )"

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"

# Currently disabled!
#	use gb \
#		&& myconf="${myconf} --with-gb" \
#		|| myconf="${myconf} --without-gb"

# Currently disabled!
#	use guile \
#		&& myconf="${myconf} --with-guile" \
#		|| myconf="${myconf} --without-guile"

	use perl \
		&& myconf="${myconf} --with-perl" \
		|| myconf="${myconf} --without-perl"

  	use python \
		&& myconf="${myconf} --with-python" \
		|| myconf="${myconf} --without-python"

  	econf ${myconf}

	#the build process have to be able to connect to X
	Xemake || Xmake || die
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	make DESTDIR=${D} install || die "install failed" 

	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
}

DOCS="AUTHORS COPYING* ChangeLog HACKING NEWS README TODO"
