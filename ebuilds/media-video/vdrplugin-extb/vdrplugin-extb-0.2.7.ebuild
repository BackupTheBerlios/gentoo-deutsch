# Copyright 2003 Martin Hierling <mad@cc.fh-lippe.de>
# Distributed under the terms of the GNU General Public License v2

IUSE=""
VDRPLUGIN="extb"

inherit eutils

S=${WORKDIR}/${VDRPLUGIN}-${PV}
DESCRIPTION="Video Disk Recorder ExtensionBoard PlugIn"
HOMEPAGE="http://deltab.de/vdr/extb.html"
SRC_URI="http://deltab.de/vdr/vdr-${VDRPLUGIN}-${PV}.tgz
	http://www.tb-electronic.de/vdr/tmp/extb_firmware_1.08_lircd.conf.zip
	http://home.t-online.de/home/tb_electronic/vdr/tmp/extb.tar.gz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.2.5"

src_unpack() {
	unpack ${A}

        # if we are using a 2.6 Kernel the dvb includes are in the /usr/src/linux dir (fix by Christian Gmeiner)
        if [ "${KV:0:3}" == "2.6" ] ; then
                sed -i "s/^DVBDIR.*$/DVBDIR = \/usr\/src\/linux/" ${S}/Makefile
        fi
        if [ "${KV:0:3}" == "2.4" ] ; then
                sed -i "s/^DVBDIR.*$/DVBDIR = \/usr/" ${S}/Makefile
        fi

        sed -i "/cp.*LIBDIR/d" ${S}/Makefile
        sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" ${S}/Makefile
        sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib/" ${S}/Makefile

	epatch ${FILESDIR}/extb.diff
}

src_compile() {
	make all|| die "compile problem"
}

src_install() {
	insinto /etc/conf.d
	doins ${FILESDIR}/vdr.extb
	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PV}
	dodoc COPYING README HISTORY README.de
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PV} libvdr-${VDRPLUGIN}.so
	insinto /opt/extb/bin/
	insopts -m0755
	doins ${S}/../extb/bin/*
	doins ${S}/wakeup/extb-poweroff.pl
	insinto /opt/extb/src/PIC/firm
	doins ${S}/../extb_1.08.hex
	insinto /opt/extb/etc/
	doins ${S}/../lircd.conf.extb_FW1.08
	insinto /etc/init.d
	insopts -m0755
	newins ${FILESDIR}/rc.irexec irexec
}

pkg_postinst() {
	einfo
	einfo "you need to add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to activate it."
	einfo 
	einfo "You need to upload the included firmware (1.08)"
	einfo "into the extension board and update your lircd.conf"
	einfo "See the supplied lircd.conf.extb_FW1.08 in"
	einfo "/opt/extb/etc/"
}
