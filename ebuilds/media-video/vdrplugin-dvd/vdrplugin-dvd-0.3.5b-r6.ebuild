IUSE=""
inherit vdrplugin

S="${WORKDIR}/${VDRPLUGIN}-${PV}06"
DESCRIPTION="Video Disk Recorder DVD-Player PlugIn"
HOMEPAGE="http://www.jausoft.com"
SRC_URI="http://www.jausoft.com/Files/vdr/vdr-dvd/vdr-${VDRPLUGIN}-${PV}06.tar.bz2"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL"

DEPEND=">=media-video/vdr-1.3.11
	>=media-libs/libdvdcss-1.2.8
	>=media-libs/libdvdnav-0.1.9
	>=media-libs/libdvdread-0.9.4
	>=media-libs/a52dec-0.7.4"

src_install() {
	vdrplugin_src_install

	insinto /etc/conf.d
	doins ${FILESDIR}/vdr.dvd
}

pkg_postinst() {
	vdrplugin_pkg_postinst
	einfo "please read manual and example scripts!!!"
}
