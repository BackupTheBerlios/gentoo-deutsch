# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/tvmovie2vdr/tvmovie2vdr-0.0.9.ebuild,v 1.1 2004/03/24 00:09:30 austriancoder Exp $

VDR_CONV_DIR="/etc/vdr"
CONV_DIR="${VDR_CONV_DIR}/tvmovie2vdr"
DATA_DIR="/var/vdr"

DESCRIPTION="load the program guide from tvmovie and others to vdr"
SRC_URI="http://www.vdr-portal.de/download/scripts/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.2.0
	>=dev-perl/DateManip-5.42a-r1
	>=dev-perl/Compress-Zlib-1.22
	>=libwww-perl-5.69-r2
	>=HTML-Parser-3.34-r1
"

S=${WORKDIR}/${P}

src_unpack() {
        unpack ${A}
}

src_compile() {
	# change default downloadpath in config
        /bin/sed -i ${S}/config.pl \
          -e 's:\$channelsfile = "/video/channels.conf";:\$channelsfile = "'${VDR_CONV_DIR}'/channels.conf";:' \
          -e 's:\$epgfile = "/video/epg.data";:\$epgfile = "'${DATA_DIR}'/epg.data";:' \
          -e 's:\$downloadprefix = "downloadfiles/";:\$downloadprefix = "'${DATA_DIR}'/downloadfiles/";:' \
          -e 's:\$updateprefix = "downloadupdatefiles/";:\$updateprefix = "'${DATA_DIR}'/downloadupdatefiles/";:'
}

src_install() {
        exeinto ${CONV_DIR}
        doexe tvinfomerk2vdr.pl
        doexe tvm2vdr.pl
        doexe channels.pl
        doexe config.pl
        keepdir ${DATA_DIR}/downloadfiles
         keepdir ${DATA_DIR}/downloadupdatefiles
        exeinto ${CONV_DIR}/contrib
        doexe ./contrib/*
        exeinto ${CONV_DIR}/inc
        doexe ./inc/*
        dodoc COPYING.GPL
        dodoc HISTORY
        dodoc README
}

pkg_setup() {
        # install an cpan packge
        draw_line 000000000000000000000000000000000000000
        einfo "Installing needed cpan package..."
        g-cpan.pl String::Similarity > /dev/null
        einfo "...done"
        draw_line 000000000000000000000000000000000000000
}

pkg_postinst() {
        einfo "setting rights in tvmovie2vdr dir"
        chown -R vdr:video "${CONV_DIR}"
        chown -R vdr:video "${DATA_DIR}"
        einfo
        einfo "You have to configuare the following files:"
        einfo "/etc/vdr/tvmovie2vdr/config.pl"
        einfo "/etc/vdr/tvmovie2vdr/channels.pl"
        einfo
        einfo "Its a good idea to add the following to /etc/crontab:"
        einfo "3  5  * * *     vdr     (cd /etc/vdr/tvmovie2vdr;./tvm2vdr.pl)"
        einfo "7  5  * * *     vdr     (cd /etc/vdr/tvmovie2vdr;./tvinfomerk2vdr.pl)"
        einfo
}
