# Copyright 2003 Henning Ryll <henning.ryll@web.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-video/vdrplugin-osdteletext/vdrplugin-osdteletext-0.3.2.ebuild,v 1.1 2003/12/02 21:32:27 fow0ryl Exp ${VDRPLUGIN}/vdr-${VDRPLUGIN}-0.3.1.ebuild,v 1.1 2003/05/13 09:39:19 fow0ryl Exp $

IUSE=""
VDRPLUGIN="osdteletext"

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder OSD-Teletext Plugin"
HOMEPAGE="http://www.wiesweg-online.de/linux/linux.html"
SRC_URI="http://www.wiesweg-online.de/linux/vdr/vdr-${VDRPLUGIN}-${PV}.tgz"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.5"

src_unpack() {
	unpack ${A}
}

src_compile() {
	sed -i "/cp.*LIBDIR/d" Makefile
	sed -i "s/^DVBDIR.*$/DVBDIR = \/usr/" Makefile
	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" Makefile
	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib/" Makefile
	make all|| die "compile problem"
}

src_install() {
	insinto /etc/conf.d
	doins ${FILESDIR}/vdr.${VDRPLUGIN}

	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PV}
	dodoc COPYING HISTORY README
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PV} libvdr-${VDRPLUGIN}.so

	# create the teletext directory
	insinto /vtx
	# we have to add the /vtx directory to /etc/fstab
	if ! grep "/vtx" /etc/fstab; then {
	   cp /etc/fstab $S/fstab
	   echo "tmpfs			/vtx		tmpfs		size=64M		0 0" >> $S/fstab
	   insinto /etc
	   doins $S/fstab
	}
	fi
}

pkg_postinst() {
	einfo
	if ! grep "/vtx" /etc/fstab; then {
	   einfo "/vtx is added to /etc/._cfg...._fstab by default"
	   einfo "please make sure using the correct /etc/fstab"
	   einfo
	}
	fi
	einfo "you need to add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to aktivate it."
	einfo "If you got Problems with DVB drivers >= 01.06.2003"
	einfo "try setting screen size to 17*48 in your teletext-setup"
	einfo
}
