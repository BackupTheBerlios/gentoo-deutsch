IUSE=""
VDRPLUGIN="dvd"

S=${WORKDIR}/${VDRPLUGIN}-${PV}06
DESCRIPTION="Video Disk Recorder DVD-Player PlugIn"
HOMEPAGE="http://www.jausoft.com"
SRC_URI="http://www.jausoft.com/Files/vdr/vdr-dvd/vdr-dvd-0.3.5b06.tar.bz2"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.3.11
	>=media-libs/libdvdcss-1.2.8
	>=media-libs/libdvdnav-0.1.9
	>=media-libs/libdvdread-0.9.4
	>=media-libs/a52dec-0.7.4"

src_unpack() {
	unpack ${A}
}

src_compile() {

einfo ${S}
	sed -i "/cp.*LIBDIR/d" Makefile
	sed -i "s/^DVBDIR.*$/DVBDIR = \/usr/" Makefile
	sed -i "s/^VDRDIR.*$/VDRDIR = \/usr\/include\/vdr/" Makefile
	sed -i "s/^LIBDIR.*$/LIBDIR = \/usr\/lib/" Makefile
	make all || die "compile problem"
}

src_install() {
	insinto /etc/conf.d
	doins ${FILESDIR}/vdr.dvd

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
