# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-femon/vdrplugin-femon-0.0.2b.ebuild,v 1.1 2004/02/28 08:34:53 fow0ryl Exp $

IUSE=""
VDRPLUGIN="femon"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="VDR graphical LCD PlugIn"
HOMEPAGE="http://www.saunalahti.fi/~rahrenbe/vdr/femon/"
SRC_URI="http://www.saunalahti.fi/~rahrenbe/vdr/femon/vdr-${VDRPLUGIN}-${PV}.tar.gz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.6"

#
# function to implement a "local" use variable called VDR_OPTS
#
function vdr_opts {
	local x
	for x in ${VDR_OPTS}
	do
		if [ "${x}" = "${1}" ]
		then
			einfo "Option ${1} found in VDR_OPTS"
			return 0
		fi
	done
	ewarn "No optional ${1} in VDR_OPTS"
	return 1
}

src_unpack() {
	unpack ${A}
}

src_compile() {
	sed -i "/cp.*LIBDIR/d" Makefile
	sed -i "s/^DVBDIR.*$/DVBDIR = \/usr/" Makefile
	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" Makefile
	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib/" Makefile

	/bin/sed -i femoni18n.c \
	  -e 's:"SIgnalqualität", // Deutsch:"Signalqualität", // Deutsch:'
	
	make all|| die "compiling returned an error"
}

src_install() {
	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PV}
	dodoc COPYING README HISTORY
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PV} libvdr-${VDRPLUGIN}.so
}

pkg_postinst() {
	einfo
	einfo "you need to add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to activate it."
	einfo
}
