# Copyright 2002
# Distributed under the terms of the GNU General Public License, v2 or later

S=${WORKDIR}/kvdr/
DESCRIPTION="Kvdr the KDE GUI for VDR (VideoDiskRecorder)"
SRC_URI="http://www.s.netic.de/gfiala/kvdr-${PV}.tgz"
HOMEPAGE="http://www.s.netic.de/gfiala/"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-tv/xawtv-3.73-r1
	>=media-tv/linuxtv-dvb-1.0.0_pre3
	>=media-video/vdr-1.2.6"

src_unpack()  {
	unpack kvdr-${PV}.tgz
}

src_compile() {
	cd ${S}
        ./configure || die "configure failed"
        emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install
}

pkg_postinst() {
echo 'Kvdr the GUI for VDR. Please start VDR prior starting Kvdr'
}
