# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/x11-plugins/gdesklets-starterbar-desklet/Attic/gdesklets-starterbar-desklet-0.12.ebuild,v 1.1 2003/09/04 11:29:26 elefantenfloh Exp $"

MY_P=starterbar-desklet

DESCRIPTION="gDesklets: An icon bar for GNOME where you can put starters into. Yes, you can do the same with the GNOME panel, but this one is pure eye\ candy!"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=13"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}-${PV}.tar.bz2"

IUSE=""                                      
                                                                                                                             


LICENSE="GPL"
KEYWORDS="~x86 ~ppc"
DEPEND=">=x11-misc/gdesklets-0.20"


S=${WORKDIR}
DEST="/usr/share/gdesklets/Sensors/"

src_install() {
	cd ${S}
	
	python ${MY_P}-${PV}/Install_StarterBar_Sensor.bin --nomsg ${S}/../image/${DEST}

	mkdir -p ${S}/../image/${DEST}/../data/StarterBar/
	mv ${MY_P}-${PV}/gfx/ ${S}/../image/${DEST}/../data/StarterBar/
	mv ${MY_P}-${PV}/starterbar.display ${S}/../image/${DEST}/../data/StarterBar/


	einfo "You can add the display by typing:"
	einfo "gdesklets /usr/share/gdesklets/data/StarterBar/starterbar.display"
	sleep 7
}

