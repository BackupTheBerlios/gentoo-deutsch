# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-gfx/digikam-cvs/digikam-cvs-0.0.1.ebuild,v 1.1 2004/02/14 18:51:30 fow0ryl Exp $

inherit cvs
inherit kde-base
need-kde 3

ECVS_CVS_COMMAND="cvs"
ECVS_ANON="yes"
ECVS_SERVER="cvs.sourceforge.net:/cvsroot/digikam"
ECVS_MODULE="digikam3"
ECVS_TOPDIR="${DISTDIR}/digikam3"

# cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/digikam login
# cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/digikam co digikam3

IUSE=""
S=${WORKDIR}/digikam3
DESCRIPTION="A KDE frontend for gPhoto 2"
HOMEPAGE="http://digikam.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="~x86"

newdepend ">=kde-base/kdelibs-3.1
	>=kde-base/kdesdk-3.1
	>=media-gfx/gphoto2-2.1.2"

src_unpack() {
	cvs_src_unpack
}
