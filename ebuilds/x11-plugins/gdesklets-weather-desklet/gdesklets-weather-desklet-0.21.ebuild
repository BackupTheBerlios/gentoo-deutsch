# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/x11-plugins/gdesklets-weather-desklet/Attic/gdesklets-weather-desklet-0.21.ebuild,v 1.1 2003/09/04 11:29:27 elefantenfloh Exp $"

MY_P=weather-desklet

DESCRIPTION="gDesklets: Weather desklet for gDesklets"
HOMEPAGE="http://gdesklets.gnomedesktop.org/"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}-${PV}.tar.bz2"

IUSE=""                                      
                                                                                                                             


LICENSE="GPL"
KEYWORDS="~x86 ~ppc"
DEPEND=">=x11-misc/gdesklets-0.20"


S=${WORKDIR}
DEST="/usr/share/gdesklets/Sensors/"

src_install() {
	cd ${S}
	
	python ${MY_P}-${PV}/Install_Weather_Sensor.bin --nomsg ${S}/../image/${DEST}

	mkdir -p ${S}/../image/${DEST}/../data/weather/
	mv ${MY_P}-${PV}/gfx/ ${S}/../image/${DEST}/../data/weather/
	mv ${MY_P}-${PV}/weather.display ${S}/../image/${DEST}/../data/weather/


	einfo "You can add the display by typing:"
	einfo "gdesklets /usr/share/gdesklets/data/weather/weather.display"
	sleep 7
}

