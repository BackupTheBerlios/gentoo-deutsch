# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/x11-plugins/gdesklets-iconbutton-sensor/Attic/gdesklets-iconbutton-sensor-0.1.4.ebuild,v 1.1 2003/09/04 11:29:26 elefantenfloh Exp $"

MY_P=IconButton

DESCRIPTION="gDesklets: This sensor is based on the starterbar. It will execute the command when an image is clicked (with on-click), and it will scal\e this image on mouse over (with on-enter, on-leave, and scale).The animation can be disabled, and the command can be changed \with the configurator."
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=22"
SRC_URI="http://gdesklets.gnomedesktop.org/files/IconButton-0.1.4.tar.bz2"


IUSE=""                                      


LICENSE="GPL"
KEYWORDS="~x86 ~ppc"
DEPEND=">=x11-misc/gdesklets-0.20"


S=${WORKDIR}
DEST="/usr/share/gdesklets/Sensors/"

src_install() {
	cd ${S}

	python ${MY_P}-${PV}/Install_IconButton_Sensor.bin --nomsg ${S}/../image/${DEST}


}
