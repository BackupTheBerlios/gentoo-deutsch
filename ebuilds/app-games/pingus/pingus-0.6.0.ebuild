# Copyright 2003 Stefan Knoblich <stefan.knoblich@t-online.de>
# Distributed under the terms of the GNU General Public License v2

inherit games

DESCRIPTION="Linux Lemmings Clone"
HOMEPAGE="http://pingus.seul.org/"
SRC_URI="http://pingus.seul.org/files/pingus-${PV}.tar.bz2"

SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"

RDEPEND="=app-games/clanlib-0.6*"

DEPEND="${RDEPEND}"

# pingus needs this
GAMES_PREFIX="/usr"
GAMES_DATADIR="/usr/share"

src_unpack() {

    unpack ${A}
}


src_compile() {

    local myconf
    
    myconf="--bindir=${GAMES_BINDIR} --libdir=${GAMES_LIBDIR}"

    egamesconf ${myconf}
    emake || die
}

src_install() {

    egamesinstall
    
    # little workaround
    mkdir -p ${D}/usr/games/bin
    mv -f ${D}/usr/games/pingus ${D}/usr/games/bin/
    
    dodoc README INSTALL ChangeLog COPYING AUTHORS NEWS README.languages INSTALL.unix INSTALL.Win32 ABOUT-NLS TODO 

    prepgamesdirs
}
