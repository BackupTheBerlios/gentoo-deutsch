IUSE=""
VDRPLUGIN="${PN/vdrplugin-/}"


PV=${PV/_/}

S=${WORKDIR}/${VDRPLUGIN}-0.1.3


DESCRIPTION="Video Disk Recorder Autotimeredit PlugIn"
HOMEPAGE="http://www.fast-info.de/vdr/autotimeredit"
SRC_URI="http://www.fast-info.de/vdr/autotimeredit/vdr-${VDRPLUGIN}-${PV}.tgz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.3.9"

src_unpack() {
	unpack ${A}
	#epatch ${FILESDIR}/${VDRPLUGIN}-${PV}.diff

	# if we are using a 2.6 Kernel the dvb includes are in the /usr/src/linux dir (fix by Christian Gmeiner)
	if [ "${KV:0:3}" == "2.6" ] ; then
		sed -i "s/^DVBDIR.*$/DVBDIR = \/usr\/src\/linux/" ${S}/Makefile
    	fi
    	if [ "${KV:0:3}" == "2.4" ] ; then
		sed -i "s/^DVBDIR.*$/DVBDIR = \/usr/" ${S}/Makefile
    	fi

    	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" ${S}/Makefile
    	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib/" ${S}/Makefile
    	sed -i "s/@cp $@.*//" ${S}/Makefile
}

src_compile() {
	make all|| die "compile problem"
}

src_install() {
	insinto /etc/conf.d
	#doins ${FILESDIR}/vdr.autotimeredit

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
	einfo "please read manual and example scripts!!!"
	einfo
}
