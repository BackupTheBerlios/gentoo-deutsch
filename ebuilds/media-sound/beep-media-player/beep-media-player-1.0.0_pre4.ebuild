# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-sound/beep-media-player/Attic/beep-media-player-1.0.0_pre4.ebuild,v 1.2 2003/11/01 21:56:51 dertobi123 Exp $

IUSE="nls esd opengl mmx oggvorbis 3dnow mikmod ipv6"

MY_P=${PN}-1.0.0-pre4
S=${WORKDIR}/${MY_P}

DESCRIPTION="beep is a media player based on XMMS (http://www.xmms.org) using UI enhancements with latest technology (GTK2, Pango), and usability while maintaining the skinned UI."
HOMEPAGE="http://linux-media.net/beep/"
SRC_URI="http://linux-media.net/beep/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"


DEPEND="app-arch/unzip
	>=x11-libs/gtk+-2
	>=dev-libs/libxml-1.8.15
	mikmod? ( >=media-libs/libmikmod-3.1.6 )
	esd? ( >=media-sound/esound-0.2.22 )
	opengl? ( virtual/opengl )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )"

RDEPEND="${DEPEND}
	directfb? ( dev-libs/DirectFB )
	nls? ( dev-util/intltool )"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${S}/beep
	epatch ${FILESDIR}/desktopfile.patch
}

src_compile() {
	local myconf=""

	if [ `use 3dnow` ] || [ `use mmx` ] ; then
		myconf="${myconf} --enable-simd"
	else
		myconf="${myconf} --disable-simd"
	fi

	
	# Config fails without this
	myconf="${myconf} --prefix=/usr"

	# Build fails with "--with-x"
	myconf="${myconf} --without-x"

	# Doesn't work
	myconf="${myconf} --without-gnome"

	econf \
		--with-dev-dsp=/dev/sound/dsp \
		--with-dev-mixer=/dev/sound/mixer \
		`use_enable oggvorbis vorbis` \
		`use_enable oggvorbis oggtest` \
		`use_enable oggvorbis vorbistest` \
		`use_enable esd` \
		`use_enable esd esdtest` \
		`use_enable mikmod` \
		`use_enable mikmod mikmodtest` \
		`use_with mikmod libmikmod` \
		`use_enable opengl` \
		`use_enable nls` \
		`use_enable ipv6` \
		${myconf} \
		|| die


	make || die
}

src_install() {
	einstall
	
	dodoc AUTHORS ChangeLog COPYING FAQ NEWS README TODO

	dodir /usr/share/beep
	dosym /usr/share/xmms/Skins /usr/share/beep/Skins
	
	insinto /usr/share/pixmaps 
	doins beep/beep_logo.xpm beep/beep_mini.xpm

	if [ -n "`use gnome`" ]
	then
		insinto /usr/share/gnome/apps/Multimedia
		mv beep/beep.desktop.in beep/beep.desktop
		doins beep/beep.desktop
	fi
}
