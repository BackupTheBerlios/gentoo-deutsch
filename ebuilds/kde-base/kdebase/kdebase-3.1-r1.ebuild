# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/kde-base/kdebase/kdebase-3.1-r1.ebuild,v 1.1 2003/02/01 23:55:03 wpbasti Exp $
NEED_KDE_DONT_ADD_KDELIBS_DEP=1 # we're a special case, see below
inherit kde-dist 

IUSE="ldap pam motif encode oggvorbis cups ssl opengl samba java"
DESCRIPTION="KDE base packages: the desktop, panel, window manager, konqueror..."

KEYWORDS="~x86 ~ppc"

newdepend ">=media-sound/cdparanoia-3.9.8
	ldap? ( >=net-nds/openldap-1.2 )
	pam? ( >=sys-libs/pam-0.73 )
	motif? ( >=x11-libs/openmotif-2.1.30 )
	encode? ( >=media-sound/lame-3.89b )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta1 )
	cups? ( net-print/cups )
	ssl? ( >=dev-libs/openssl-0.9.6b )
	opengl? ( virtual/opengl )
	samba? ( net-fs/samba )
	java? ( virtual/jre )
	>=media-libs/freetype-2" 
#	lm_sensors? ( ?/lm_sensors ) # ebuild doesn't exist yet

# special case, contd.: we need kdelibs >=3.1-r1, but not so that we get a version !=3.1
# so we told kde-functions:need-kde not to add a dep on kdelibs, and now we'll do it manually
# newdepend "( >=kde-base/kdelibs-3.1-r1 <kde-base/kdelibs-3.1.1 )" # bug in portage?
newdepend "=kde-base/kdelibs-3.1-r1"

myconf="$myconf --with-dpms --with-cdparanoia"

use ldap	&& myconf="$myconf --with-ldap" 	|| myconf="$myconf --without-ldap"
use pam		&& myconf="$myconf --with-pam"		|| myconf="$myconf --with-shadow"
use motif	&& myconf="$myconf --with-motif"	|| myconf="$myconf --without-motif"
use encode	&& myconf="$myconf --with-lame"		|| myconf="$myconf --without-lame"
use cups	&& myconf="$myconf --with-cups"		|| myconf="$myconf --disable-cups"
use oggvorbis 	&& myconf="$myconf --with-vorbis"	|| myconf="$myconf --without-vorbis"
use opengl	&& myconf="$myconf --with-gl"		|| myconf="$myconf --without-gl"
use ssl		&& myconf="$myconf --with-ssl"		|| myconf="$myconf --without-ssl"
use pam		&& myconf="$myconf --with-pam=yes"	|| myconf="$myconf --with-pam=no --with-shadow"
use java	&& myconf="$myconf --with-java=$(java-config --jre-home)"	|| myconf="$myconf --without-java"
src_compile() {

    kde_src_compile myconf configure
    kde_remove_flag kdm/kfrontend -fomit-frame-pointer
    kde_src_compile make

}

src_install() {

    kde_src_install

    # cf bug #5953
    insinto /etc/pam.d
    #newins ${FILESDIR}/kscreensaver.pam kscreensaver
    newins ${FILESDIR}/kde.pam kde

    # startkde script
    cd ${D}/${KDEDIR}/bin
    patch -p0 < ${FILESDIR}/${PVR}/startkde-${PVR}-gentoo.diff || die
    mv startkde startkde.orig
    sed -e "s:_KDEDIR_:${KDEDIR}:" startkde.orig > startkde
    rm startkde.orig
    chmod a+x startkde

    # x11 session script
    cd ${T}
    echo "#!/bin/sh
${KDEDIR}/bin/startkde" > kde-${PV}
    chmod a+x kde-${PV}
    exeinto /etc/X11/Sessions
    doexe kde-${PV}

    cd ${D}/${KDEDIR}/share/config/kdm || die
    sed -e "s:SessionTypes=:SessionTypes=kde-${PV},:" \
	-e "s:Session=${PREFIX}/share/config/kdm/Xsession:Session=/etc/X11/xdm/Xsession:" \
	${FILESDIR}/${PVR}/kdmrc > kdmrc
    cp ${FILESDIR}/${PVR}/backgroundrc .

    #backup splashscreen images, so they can be put back when unmerging 
    #mosfet or so.
    if [ ! -d ${KDEDIR}/share/apps/ksplash.default ]
    then
        cd ${D}/${KDEDIR}/share/apps
        cp -rf ksplash/ ksplash.default
    fi
    
    # Show gnome icons when choosing new icon for desktop shortcut
    dodir /usr/share/pixmaps
    mv ${D}/${KDEDIR}/share/apps/kdesktop/pics/* ${D}/usr/share/pixmaps/
    rm -rf ${D}/${KDEDIR}/share/apps/kdesktop/pics/
    cd ${D}/${KDEDIR}/share/apps/kdesktop/
    ln -sf /usr/share/pixmaps/ pics

    rmdir ${D}/${KDEDIR}/share/templates/.source/emptydir

}

pkg_postinst() {
    mkdir -p ${KDEDIR}/share/templates/.source/emptydir
}
 
