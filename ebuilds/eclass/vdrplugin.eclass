# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/eclass/vdrplugin.eclass,v 1.3 2004/08/12 18:19:32 austriancoder Exp $
#
# Matthias Schwarzott <zzam@gmx.de>

inherit dvb

ECLASS=vdrplugin
INHERITED="$INHERITED $ECLASS"

#
## This is the minimal plugin-ebuild:
##
## ### cut ############################################
##
## # Copyright 1999-2004 Gentoo Technologies, Inc.
## # Distributed under the terms of the GNU General Public License v2
## # $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/eclass/vdrplugin.eclass,v 1.3 2004/08/12 18:19:32 austriancoder Exp $
## 
## inherit vdrplugin
## 
## DESCRIPTION="..."
## HOMEPAGE="http://.../"
## SRC_URI="http://.../.../vdr-${VDRPLUGIN}-${PV}.tgz"
## LICENSE="GPL-2"
## 
## DEPEND=">=media-video/vdr-1.3.7"
##
## ### cut ############################################
#

#
# Configuration-Variables used by this eclass:
#
# Automatically filled with values:
# (You can change them after inherit if you need to)
#   VDRPLUGIN    - Name of the plugin
#   S            - Path of the sources
#   KEYWORDS     - Set ebuild to state masked
#   SLOT         - Set to 0
#   IUSE         - Set to use no useflags
#
#
#
# You must set in your ebuild
#   SRC_URI      - Download location
#   HOMEPAGE     - Homepage of plugin
#   DESCRIPTION  - Description
#   LICENSE      - License of plugin (GPL-2)
#   DEPEND       - Dependencies to vdr etc.
#

# This eclass exports these functions:
#    src_unpack
#    src_compile
#    src_install
#    pkg_postinst
#

# If this implementation is good for you,
# you have nothing to do, else you can inherit this
# Version and change it how you like.

# Example for src_unpack:
#
# inherit eutils
# src_unpack() {
#         # inherited version
#         vdrplugin_src_unpack
#
#         # Added code
#         epatch ${FILESDIR}/patch-no5.diff
# }
#





#
# VDRPLUGIN - Name of the plugin
#
test -z "${VDRPLUGIN}" && VDRPLUGIN="${PN/vdrplugin-/}"



#
#
S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder ${VDRPLUGIN} PlugIn"
SRC_URI="-TODO- Insert download location here"
DEPEND="media-video/vdr"
KEYWORDS="~x86"
SLOT="0"


#
# Export default functions for ebuilds
#
EXPORT_FUNCTIONS src_unpack src_compile src_install pkg_postinst

vdrplugin_patch_makefile() {

	# To not overwrite the global variable with local changes 
	local S="${S}"
	[ -z "${1}" ] || S="${1}"

	dvb_patch_makefile "${S}"

	sed -i "/cp.*LIBDIR/d" ${S}/Makefile

	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include/" ${S}/Makefile
	sed -i 's/\$(VDRDIR)\/include/$(VDRDIR)/' ${S}/Makefile

	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib/" ${S}/Makefile

	sed -i "/@install.*$/d" ${S}/Makefile
	sed -i "/@-strip.*$/d" ${S}/Makefile

	sed -i "/cp.*LIBDIR/d" ${S}/Makefile

	#DEBUG
	#cp ${S}/Makefile /tmp/Makefile-${VDRPLUGIN}
}


#
#  * src_unpack
#  * src_compile
#  * src_install
#  * pkg_postinst
#   
# Standardversionen dieser Routinen
# wenn sie im ebuild nicht 
# ueberschrieben werden
#

vdrplugin_src_unpack() {
	unpack ${A}
}

vdrplugin_src_compile() {
	vdrplugin_patch_makefile	
	make all || die "compile problem"
}

vdrplugin_src_install() {
	cd ${S}
	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PV}

	for f in COPYING README HISTORY TODO; do
		test -f "${f}" && dodoc "${f}"
	done

	if test -f ${FILESDIR}/vdr.${VDRPLUGIN}; then
		insinto /etc/conf.d
		doins ${FILESDIR}/vdr.${VDRPLUGIN}
	fi

	dosym libvdr-${VDRPLUGIN}.so.${PV} /usr/lib/vdr/libvdr-${VDRPLUGIN}.so
}

vdrplugin_pkg_postinst() {
        einfo
        einfo "you need to add the module to /etc/conf.d/vdr"
        einfo "and restart vdr to activate it."
        einfo
}


