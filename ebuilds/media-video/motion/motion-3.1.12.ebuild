# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/motion/motion-3.1.12.ebuild,v 1.2 2004/07/28 20:26:35 martini Exp $ 

DESCRIPTION="A software motion detector. It grabs images from video4linux devices and/or webcams"
HOMEPAGE="http://motion.sf.net"
SRC_URI="mirror://sourceforge/motion/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="mysql postgres"
DEPEND="mysql? ( dev-db/mysql ) 
		postgres? ( dev-db/postgresql )		
		media-video/ffmpeg
		media-libs/jpeg
		>=xmlrpc-c-0.9.10
		sys-apps/sed"
#Note that sed is only a dependancy because of its use in src_compile()

RDEPEND=""

src_unpack() {
    unpack ${A}
    cd ${S}
}

src_compile() {
	# fix breakage in tarball
	chmod +x configure

	# Needed because ffmpeg does not have libavcodec.a but it does have .so
	sed -i configure -e 's/libavcodec.a/libavcodec.so/'
	
	# now run configure
	local myconf=""
    use mysql && myconf="${myconf} --with-mysql"
    use mysql || myconf="${myconf} --without-mysql"
    use postgres && myconf="${myconf} --with-pgsql"
	use postgres || myconf="${myconf} --without-pgsql"
	CFLAGS="-I/usr/include/ffmpeg" econf \
		--with-libavcodec=/usr/lib \
		--sysconfdir=/etc/motion \
		${myconf} || die "configure problem !"
	
	# now modifying Makefile for installing docs/examples in the right place
	sed -i Makefile -e 's/docdir = $(prefix)\/doc\/motion-$(VERSION)/docdir = $(prefix)\/share\/doc\/motion-$(VERSION)/'
	sed -i Makefile -e 's/examplesdir = $(prefix)\/examples\/motion-$(VERSION)/examplesdir = $(docdir)\/examples/'
	emake || die "compile problem !"
}

src_install() {
	einstall || die "install problem !"
	
	#Needed because --sysconfdir do not install motion.conf in the right place
	rm ${D}/etc/motion-dist.conf
	insinto /etc/motion
	doins ${S}/motion-dist.conf
	insinto /etc/init.d
	insopts -m755
	newins ${FILESDIR}/rc.motion motion
}

pkg_postinst() {
	einfo "Motion is now installed. Your configuration files"
	einfo "are placed in /etc/motion. Sample configuration can"
	einfo "be find in /usr/share/doc/motion*/examples."
	einfo "Be aware with etc-update after (re)emerge of motion"
	einfo "do not replace your 'hard work' in the motion.conf :-)"
}
