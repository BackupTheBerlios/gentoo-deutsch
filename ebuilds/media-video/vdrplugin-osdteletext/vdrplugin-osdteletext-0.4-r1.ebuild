# Copyright 2003 Henning Ryll <henning.ryll@web.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-osdteletext/vdrplugin-osdteletext-0.4-r1.ebuild,v 1.2 2004/08/11 13:37:40 austriancoder Exp ${VDRPLUGIN}/vdr-${VDRPLUGIN}-0.3.1.ebuild,v 1.1 2003/05/13 09:39:19 fow0ryl Exp $

IUSE=""

# inherit from vdrplugin
# include functions from eutils
inherit vdrplugin eutils

DESCRIPTION="Video Disk Recorder OSD-Teletext Plugin"
HOMEPAGE="http://www.wiesweg-online.de/linux/linux.html"
SRC_URI="http://www.wiesweg-online.de/linux/vdr/vdr-${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.5"

src_unpack() {
	# extend inherited version
	vdrplugin_src_unpack

	# a little patch from vdr-portal.de	
	epatch ${FILESDIR}/txtrecv.c.diff
}

src_install() {
	# inherited
	vdrplugin_src_install

	# create the teletext directory
	insinto /vtx
	# we have to add the /vtx directory to /etc/fstab
	if ! grep -q "/vtx" /etc/fstab; then {
	   cp /etc/fstab $S/fstab
	   echo "tmpfs			/vtx		tmpfs		size=64M		0 0" >> $S/fstab
	   insinto /etc
	   doins $S/fstab
	}
	fi
}

pkg_postinst() {
	einfo
	if ! grep -q "/vtx" /etc/fstab; then {
	   einfo "/vtx is added to /etc/._cfg...._fstab by default"
	   einfo "please make sure using the correct /etc/fstab"
	   einfo
	}
	fi
	einfo "If you got Problems with DVB drivers >= 01.06.2003"
	einfo "try setting screen size to 17*48 in your teletext-setup"
	einfo

	# inherited version
	vdrplugin_pkg_postinst
}
