IUSE=""
VDRPLUGIN="softdevice"

#S=${WORKDIR}/${VDRPLUGIN}-${PV}pre1
S=${WORKDIR}/${VDRPLUGIN}-0.0.7pre1
DESCRIPTION="Video Disk Recorder Softdevice PlugIn"
HOMEPAGE="http://www.k13zoo.de/vdr"
SRC_URI="http://www.lucke.in-berlin.de/vdr-softdevice-0.0.7pre1.tar.bz2"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.3.9"

# include functions from eutils
inherit eutils

#
# function to implement a "local" use variable called VDR_SOFTDEVICE_OPTS
#
function vdr_softdevice_opts {
    local x
    for x in ${VDR_SOFTDEVICE_OPTS}
    do
        if [ "${x}" = "${1}" ]
        then
            return 0
        fi
    done
    [ -z $2 ] && einfo "No optional ${1} in VDR_SOFTDEVICE_OPTS - Fine :)"
    return 1
}


src_unpack() {
	unpack ${A}
    # if we are using a 2.6 Kernel the dvb includes are in the /usr/src/linux dir (fix by Christian Gmeiner)
    if [ "${KV:0:3}" == "2.6" ] ; then
        sed -i "s/^DVBDIR.*$/DVBDIR = \/usr\/src\/linux/" ${S}/Makefile
    fi
    if [ "${KV:0:3}" == "2.4" ] ; then
        sed -i "s/^DVBDIR.*$/DVBDIR = \/usr/" ${S}/Makefile
    fi

    sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" ${S}/Makefile
    sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib/" ${S}/Makefile
	sed -i "s/^LIBAVCODEC.*$/LIBAVCODEC = \/usr\/include\/ffmpeg/" ${S}/Makefile
    sed -i "s/@cp $@.*//" ${S}/Makefile
	sed -i "/cp.*LIBDIR/d" ${S}/Makefile
    # XV-Support
    if vdr_softdevice_opts xv
    then
        ewarn "enable XV-Support"
	    sed -i "s/^#XV_SUPPORT.*$/XV_SUPPORT=1/"  ${S}/Makefile
    else
        ewarn "disable XV-Support"
	    sed -i "s/^XV_SUPPORT.*$/#XV_SUPPORT=1/"  ${S}/Makefile
    fi
    # vidix-Support
    if vdr_softdevice_opts vidix
    then
        ewarn "enable Vidix-Support"
	    sed -i "s/^#VIDIX_SUPPORT=1.*$/VIDIX_SUPPORT=1/"  ${S}/Makefile
    else
        ewarn "disable Vidix-Support"
	    sed -i "s/^VIDIX_SUPPORT=1.*$/#VIDIX_SUPPORT=1/"  ${S}/Makefile
    fi
    # DFB-Support
    if vdr_softdevice_opts dfb
    then
        ewarn "enable DFB-Support"
	    sed -i "s/^#DFB_SUPPORT=1.*$/DFB_SUPPORT=1/" ${S}/Makefile
    else
        ewarn "disable DFB-Support"
	    sed -i "s/^DFB_SUPPORT=1.*$/#DFB_SUPPORT=1/" ${S}/Makefile
    fi
    # FB-Support
    if vdr_softdevice_opts fb
    then
        ewarn "enable FB-Support"
	    sed -i "s/^#FB_SUPPORT=1.*$/FB_SUPPORT=1/" ${S}/Makefile
    else
        ewarn "disable FB-Support"
	    sed -i "s/^FB_SUPPORT=1.*$/#FB_SUPPORT=1/" ${S}/Makefile
    fi
}

src_compile() {

einfo ${S}
	make all|| die "compile problem"
}

src_install() {
	insinto /etc/conf.d
	doins ${FILESDIR}/vdr.softdevice

	insinto /usr/lib/vdr
	insopts -m0755
	newins libvdr-${VDRPLUGIN}.so libvdr-${VDRPLUGIN}.so.${PV}
	dodoc COPYING README HISTORY
	cd ${D}/usr/lib/vdr/
	ln -s libvdr-${VDRPLUGIN}.so.${PV} libvdr-${VDRPLUGIN}.so
}

pkg_setup(){
    # some short info about use flags of vdrplugin-softdevice
    echo
    einfo
    einfo "softdevice-plugin for Video Disk Recorder"
    einfo "-----------------------------------------"
    einfo
    einfo "You can use some VDR-SOFTDEVICE-USE-Flags to build your special plugin"
    einfo "Only add "
    einfo "VDR_SOFTDEVICE_OPTS=\"...\""
    einfo "to /etc/make.conf"
    einfo
    einfo
    einfo "Here is a list of all possible VDR_SOFTDEVICE_OPTS:"
    einfo
    einfo "xv -> enable XV-Support"
    einfo "vidix -> enable vidix-Support"
    einfo "dfb -> enable DFB-Support"
    einfo "fb -> enable FB-Support"
    einfo
    einfo "Your VDR_SOFTDEVICE_OPTS: $VDR_SOFTDEVICE_OPTS"
    einfo
    echo
}


pkg_postinst() {
	einfo
	einfo "you need to add the module to /etc/conf.d/vdr"
	einfo "and restart vdr to activate it."
	einfo "please read manual and example scripts!!!"
	einfo
}
