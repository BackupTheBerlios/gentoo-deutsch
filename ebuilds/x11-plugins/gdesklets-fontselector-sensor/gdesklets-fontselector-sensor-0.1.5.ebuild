# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/x11-plugins/gdesklets-fontselector-sensor/Attic/gdesklets-fontselector-sensor-0.1.5.ebuild,v 1.1 2003/09/04 11:29:26 elefantenfloh Exp $"

MY_P=FontSelector

DESCRIPTION="gDesklets: Adds any number of 'font groups' in a display (for instance, titles/data)."
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=21"
SRC_URI="http://gdesklets.gnomedesktop.org/files/FontSelector-0.1.5.tar.bz2"


IUSE=""                                      


LICENSE="GPL"
KEYWORDS="~x86 ~ppc"
DEPEND=">=x11-misc/gdesklets-0.20"


S=${WORKDIR}
DEST="/usr/share/gdesklets/Sensors/"

src_install() {
	cd ${S}

	python ${MY_P}-${PV}/Install_FontSelector_Sensor.bin --nomsg ${S}/../image/${DEST}


}
