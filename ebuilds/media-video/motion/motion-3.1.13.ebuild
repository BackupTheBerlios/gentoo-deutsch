# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/motion/motion-3.1.13.ebuild,v 1.1 2004/05/12 16:47:17 martini Exp $ 

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
	local myconf=""
    use mysql && myconf="${myconf} --with-mysql"
    use mysql || myconf="${myconf} --without-mysql"
    use postgres && myconf="${myconf} --with-pgsql"
	use postgres || myconf="${myconf} --without-pgsql"
	econf --with-libavcodec=/usr/lib \
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
}

pkg_postinst() {
	echo
	einfo "Motion is now installed. A sample configuration file"
	einfo "is placed in /etc/motion (motion-dist.conf)." 
	einfo "Please rename 'motion-dist.conf' to 'motion.conf'!" 
	einfo "More sample configuration files can be find in"
	einfo "/usr/share/doc/motion*/examples."
	echo
}