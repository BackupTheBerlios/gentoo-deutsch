# Copyright 2003 Stefan Knoblich <stefan.knoblich@t-online.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/ebuilds/ebuilds/net-p2p/lmule-dev/Attic/lmule-1.3.1.ebuild,v 1.1 2003/08/22 15:27:29 fow0ryl Exp $

DESCRIPTION="Port of the Emule to Linux (development version)"
HOMEPAGE="http://lmule.sourceforge.net/"
SRC_URI="mirror://sourceforge/lmule/lmule-${PV}.tar.gz"
S=${WORKDIR}/${P}

IUSE="gtk2"
SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"

inherit flag-o-matic
replace-flags "-O3" "-O2"

RDEPEND=">=x11-libs/wxGTK-2.4.0
	 >=sys-libs/zlib-1.1.4
	 >=sys-devel/gettext-0.11.5
	 >=dev-libs/expat-1.95"

DEPEND="${RDEPEND}"

src_unpack() {
    unpack ${A}
}

src_compile() {
    local myconf=""

    myconf="--prefix=/usr"

    use nls || \
	myconf="${myconf} --disable-nls"

    if [ "`use gtk2`" ]; then
 
	if [ ! -x /usr/bin/wxgtk2-2.4-config ]; then
	    eerror "No GTK2 version of wxGTK found!"
	    eerror "Edit /usr/portage/x11-libs/wxGTK/wxGTK-2.4.0.ebuild,"
	    eerror "replace \"--enable-unicode\" with \"--disable-unicode\""
	    eerror "and re-emerge wxGTK with gtk2 USE flag enabled"
	    die
	fi
	
	ewarn "If this emerge fails, edit /usr/portage/x11-libs/wxGTK/wxGTK-2.4.0.ebuild:"
	ewarn "replace \"--enable-unicode\" with \"--disable-unicode\" and re-emerge wxGTK"
	ewarn "press <enter> to continue or <ctrl>+<c> to stop..."
	read;
	
	myconf="${myconf} --with-wx-config=/usr/bin/wxgtk2-2.4-config"
    else
        myconf="${myconf} --with-wx-config=/usr/bin/wx-config"
    fi

    econf ${myconf} || die
    make || die
}

src_install() {
    emake install DESTDIR=${D} || die

    dodoc AUTHORS ABOUT-NLS COPYING ChangeLog README INSTALL TODO ED2K-Links.HOWTO lmule.desktop lmule.xpm
    
    docinto emule
    dodoc docs/emule/*
}
