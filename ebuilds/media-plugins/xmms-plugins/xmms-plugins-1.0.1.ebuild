S=${WORKDIR}/${P//xmms-}
DESCRIPTION="emerge this package to install all of the xmms plugins"
HOMEPAGE="http://www.xmms.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND=">=media-sound/xmms-1.2.7
		media-plugins/alsa-xmms
		avi-xmms? ( media-plugins/avi-xmms )
		media-plugins/dumb-xmms
		media-plugins/efxmms
		media-plugins/modplugxmms
		media-plugins/xmms-alarm
		media-plugins/xmms-blursk
		media-plugins/xmms-cdread
		media-plugins/xmms-compress
		media-plugins/xmms-crossfade
		media-plugins/xmms-dflowers
		media-plugins/xmms-dscope
		media-plugins/xmms-dspectogram
		media-plugins/xmms-dspectral
		media-plugins/xmms-extra
		media-plugins/xmms-fc
		media-plugins/xmms-find
		media-plugins/xmms-fmradio
		media-plugins/xmms-gdancer
		media-plugins/xmms-goom
		media-plugins/xmms-infinity
		media-plugins/xmms-infopipe
		media-plugins/xmms-iris
		media-plugins/xmms-itouch
		media-plugins/xmms-jess
		media-plugins/xmms-kjofol
		media-plugins/xmms-ladspa
		media-plugins/xmms-lirc
		media-plugins/xmms-liveice
		media-plugins/xmms-mad
		media-plugins/xmms-midi
		media-plugins/xmms-musepack
		media-plugins/xmms-nas
		media-plugins/xmms-nebulus
		media-plugins/xmms-nsf
		media-plugins/xmms-shell
		media-plugins/xmms-shn
		media-plugins/xmms-sid
		media-plugins/xmms-sndfile
		media-plugins/xmms-spc
		media-plugins/xmms-status-plugin
		media-plugins/xmms-synaesthesia
		media-plugins/xmms-volnorm
		media-sound/xmmsctrl
		media-video/smpeg-xmms
		x11-themes/xmms-themes
		"
