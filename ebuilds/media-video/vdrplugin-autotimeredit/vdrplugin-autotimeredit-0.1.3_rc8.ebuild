IUSE=""

inherit vdrplugin

PV=${PV/_/}
S=${WORKDIR}/${VDRPLUGIN}-0.1.3

DESCRIPTION="Video Disk Recorder Autotimeredit PlugIn"
HOMEPAGE="http://www.fast-info.de/vdr/autotimeredit"
SRC_URI="http://www.fast-info.de/vdr/autotimeredit/vdr-${VDRPLUGIN}-${PV}.tgz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.9"

src_install() {
	insinto /etc/conf.d
	#doins ${FILESDIR}/vdr.autotimeredit

	vdrplugin_src_install
}

