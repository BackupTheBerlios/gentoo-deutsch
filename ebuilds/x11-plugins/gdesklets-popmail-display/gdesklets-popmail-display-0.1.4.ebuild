# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/x11-plugins/gdesklets-popmail-display/Attic/gdesklets-popmail-display-0.1.4.ebuild,v 1.1 2003/09/04 11:29:26 elefantenfloh Exp $"

MY_P=popmaildisp

DESCRIPTION="gDesklets: Checks if there is new mail, prints the server name, login, message number, and box size. The icon changes for errors|new mail\|no new mail."
HOMEPAGE="http://gdesklets.gnomedesktop.org/categories.php?func=gd_show_app&gd_app_id=36"
SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}-${PV}.tar.bz2"

IUSE=""                                      
                                                                                                                             

LICENSE="GPL"
KEYWORDS="~x86 ~ppc"
DEPEND=">=x11-misc/gdesklets-0.20
	>=x11-plugins/gdesklets-popmail-sensor-0.1.4
	>=x11-plugins/gdesklets-iconbutton-sensor-0.1.4
	>=x11-plugins/gdesklets-fontselector-sensor-0.1.5"


S=${WORKDIR}
DEST="/usr/share/gdesklets/Sensors/"

src_install() {
	cd ${S}
	
	mkdir -p ${S}/../image/${DEST}/../data/popmaildisp/
	mv dark-theme/ ${S}/../image/${DEST}/../data/popmaildisp/
	mv light-theme/ ${S}/../image/${DEST}/../data/popmaildisp/

	einfo "You can add the popmail-display by typing:"
	einfo "gdesklets /usr/share/gdesklets/data/popmaildisp/dark-theme/popmail.display"
	einfo "or"
	einfo "gdesklets /usr/share/gdesklets/data/popmaildisp/light-theme/popmail.display"
	sleep 7
}

