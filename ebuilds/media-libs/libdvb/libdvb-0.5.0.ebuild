# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-libs/libdvb/libdvb-0.5.0.ebuild,v 1.1 2003/10/28 14:02:31 martini Exp $

DESCRIPTION="libdvb package with added CAM library and libdvbmpegtools as well as dvb-mpegtools"
HOMEPAGE="http://www.metzlerbros.org/dvb/"
SRC_URI="http://www.metzlerbros.org/dvb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=sys-apps/sed-4
	>=media-tv/linuxtv-dvb-1.0.1"

function vdr_opts {
	local x
	for x in ${VDR_OPTS}
	do
		if [ "${x}" = "${1}" ]
		then
			return 0
		fi
	done
	ewarn "No optional ${1} in VDR_OPTS"
	return 1
}

src_unpack() {
	unpack ${A} && cd "${S}"

	# Disable compilation of sample programs
	# and use DESTDIR when installing
	epatch "${FILESDIR}/${P}-gentoo.patch"
	
	# Patching for using with Adreas Kool's
	# AnalogTV-Plugin vor VDR
	einfo
	einfo "VDR_OPTS: $VDR_OPTS"
	einfo
	if vdr_opts analogtv; then
	epatch ${FILESDIR}/${P}-analogtv.patch
	fi
}

src_compile() {
	emake || die "compile problem"
}

src_install() {
	make DESTDIR="${D}" PREFIX=/usr install || die

	insinto "/usr/share/doc/${PF}/sample_progs"
	doins sample_progs/*
	insinto "/usr/share/doc/${PF}/samplerc"
	doins samplerc/*

	dodoc README
}
