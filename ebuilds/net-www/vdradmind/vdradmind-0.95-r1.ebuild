# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-www/vdradmind/vdradmind-0.95-r1.ebuild,v 1.1 2004/03/24 21:27:48 austriancoder Exp $

LIBDIR=/usr/share/vdradmin
ETCDIR=/etc/vdradmin

IUSE=""

S=${WORKDIR}/vdradmin-0.95
DESCRIPTION="WWW Admin for the Video Disk Recorder"
HOMEPAGE="http://linvdr.org/"
SRC_URI="http://linvdr.org/download/vdradmin/vdradmin-0.95.tar.gz
http://xpix.dieserver.de/downloads/vdradmin-0.95_0.9_pre3.tar.gz
"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="dev-lang/perl
	dev-perl/Template-Toolkit
	>=dev-perl/Compress-Zlib-1.2.2
	media-video/vdr"

RESTRICT="nostrip"

#
# function to implement a "local" use variable called VDRADMIN_OPTS
#
function vdradmin_opts {
        local x
        for x in ${VDRADMIN_OPTS}
        do
                if [ "${x}" = "${1}" ]
                then
                        return 0
                fi
        done
        [ -z $2 ] && ewarn "No optional ${1} in VDRADMIN_OPTS; Fine."
        return 1
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "45s/0/1/" vdradmind.pl
}

src_compile() {
	einfo "no need to compile"
}

src_install() {
	make DESTDIR=${D} install
	insinto /etc/init.d
	insopts -m755
	newins ${FILESDIR}/rc.vdradmind vdradmind

	# addional install for bigpatch
	if vdradmin_opts bigpatch
	then
		einfo Installing bigpatch ...
		cd ${WORKDIR}/vdradmin
		insinto $LIBDIR/template
		doins template/*.conf
		insinto $LIBDIR/template/Deutsch
		doins template/Deutsch/{*.html,*.ico,*.pl,*.css,*.js}
		insinto $LIBDIR/template/Deutsch/bilder
		doins template/Deutsch/bilder/*
		insinto $LIBDIR/template/Deutsch/copper
		doins template/Deutsch/copper/*
		insinto $LIBDIR/template/English
		doins template/English/{*.html,*.pl,*.css}
		insinto $LIBDIR/template/English/bilder
		doins template/English/bilder/*
		insinto $LIBDIR/template/French
		doins template/French/{*.html,*.pl,*.css}
		insinto $LIBDIR/template/French/bilder
		doins template/French/bilder/*
		insinto $LIBDIR/lib/HTML
		doins lib/HTML/Template.pm
		insinto $LIBDIR/lib/HTML/Template
		doins lib/HTML/Template/Expr.pm
		insinto $LIBDIR/lib/MIME/
		doins lib/MIME/Base64.pm
		insinto $LIBDIR/lib/Parse
		doins lib/Parse/RecDescent.pm
		insinto $LIBDIR/lib/Text
		doins lib/Text/Balanced.pm
		dodoc COPYING HISTORY INSTALL README_BigPatch
		docinto contrib
		dodoc contrib/*
		dobin vdradmind.pl
	fi
}

pkg_postinst() {
	einfo
	einfo "start \"vdradmind.pl -c\" to setup ..."
	einfo
}
