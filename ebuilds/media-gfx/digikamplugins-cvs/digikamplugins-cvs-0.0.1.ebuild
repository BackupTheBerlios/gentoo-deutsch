# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-gfx/digikamplugins-cvs/digikamplugins-cvs-0.0.1.ebuild,v 1.1 2004/02/14 18:49:34 fow0ryl Exp $

inherit cvs
inherit kde-base
need-kde 3

ECVS_CVS_COMMAND="cvs"
ECVS_ANON="yes"
ECVS_SERVER="cvs.sourceforge.net:/cvsroot/digikam"
ECVS_MODULE="digikamplugins"
ECVS_TOPDIR="${DISTDIR}/digikamplugins"

# cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/digikam login
# cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/digikam co digikamplugins

IUSE=""
S=${WORKDIR}/digikamplugins
DESCRIPTION="A KDE frontend for gPhoto 2"
HOMEPAGE="http://digikam.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="~x86"

newdepend ">=media-gfx/digikam-0.6.0"

src_unpack() {
	cvs_src_unpack
	if ! [ `use opengl` ]; then
	   ewarn "slideshow disabled, because there is no opengl USE Flag"
	   cd ${S}
	   /bin/sed -i configure.in.in \
             -e 's:#DO_NOT_COMPILE="$DO_NOT_COMPILE slideshow":DO_NOT_COMPILE="$DO_NOT_COMPILE slideshow":'
	fi
}
