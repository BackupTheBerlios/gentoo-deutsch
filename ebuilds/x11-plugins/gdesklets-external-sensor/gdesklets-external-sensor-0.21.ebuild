# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/x11-plugins/gdesklets-external-sensor/Attic/gdesklets-external-sensor-0.21.ebuild,v 1.1 2003/09/04 11:29:26 elefantenfloh Exp $"

MY_P=external-sensor

DESCRIPTION="gDesklets: sensor for retrieving data from external programs"
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=15"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}-${PV}.tar.bz2"

IUSE=""                                      


LICENSE="GPL"
KEYWORDS="~x86 ~ppc"
DEPEND=">=x11-misc/gdesklets-0.20"


S=${WORKDIR}
DEST="/usr/share/gdesklets/Sensors/"

src_install() {
	cd ${S}

	python ${MY_P}-${PV}/Install_External_Sensor.bin --nomsg ${S}/../image/${DEST}

	mkdir -p ${S}/../image/${DEST}/../data/external-sensor/
	mv ${MY_P}-${PV}/examples/ ${S}/../image/${DEST}/../data/external-sensor/

}
