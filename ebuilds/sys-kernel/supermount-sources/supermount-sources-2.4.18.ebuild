# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/sys-kernel/supermount-sources/supermount-sources-2.4.18.ebuild,v 1.2 2003/02/01 23:55:04 wpbasti Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

#we use this next variable to avoid duplicating stuff on cvs
GFILESDIR=${PORTDIR}/sys-kernel/linux-sources/files
OKV=2.4.18
KV=2.4.18-sm
S=${WORKDIR}/linux-${KV}
ETYPE="sources"

# What's in this kernel?

# INCLUDED:
# stock 2.4.18 kernel sources
# supermount patch for the 2.4.18 sources

DESCRIPTION="Supermount Patch applied sources for the Gentoo Linux kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2 http://people.mandrakesoft.com/~quintela/supermount/2.4.18/60_supermount.patch"
PROVIDE="virtual/linux-sources"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/ http://people.mandrakesoft.com/~quintela/" 
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

if [ $ETYPE = "sources" ] && [ -z "`use build`" ]
then
	#console-tools is needed to solve the loadkeys fiasco; binutils version needed to avoid Athlon/PIII/SSE assembler bugs.
	DEPEND=">=sys-devel/binutils-2.11.90.0.31"
	RDEPEND=">=sys-libs/ncurses-5.2 sys-devel/perl >=sys-apps/modutils-2.4.2 sys-devel/make"
fi

[ -z "$LINUX_HOSTCFLAGS" ] && LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include"

src_unpack() {
	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2
	mv linux linux-${KV} || die
	cd ${S}
	cat ${DISTDIR}/60_supermount.patch | patch -p1 || die
	
	#sometimes we have icky kernel symbols; this seems to get rid of them
	make mrproper || die

	#this file is required for other things to build properly, so we autogenerate it
	make include/linux/version.h || die

	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R 0.0 *
	chmod -R a+r-w+X,u+w *

	# Gentoo Linux uses /boot, so fix 'make install' to work properly
	cd ${S}
	mv Makefile Makefile.orig
	sed -e 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' \
		Makefile.orig >Makefile || die # test, remove me if Makefile ok
	rm Makefile.orig
}

src_compile() {
	if [ "$ETYPE" = "headers" ]
	then
		yes "" | make oldconfig		
		echo "Ignore any errors from the yes command above."
	fi
}

src_install() {
	if [ "$ETYPE" = "sources" ]
	then
		dodir /usr/src
		echo ">>> Copying sources..."
		mv ${WORKDIR}/* ${D}/usr/src
	else
		#linux-headers
		dodir /usr/include/linux
		cp -ax ${S}/include/linux/* ${D}/usr/include/linux
		rm -rf ${D}/usr/include/linux/modules
		dodir /usr/include/asm
		cp -ax ${S}/include/asm-i386/* ${D}/usr/include/asm
	fi
}

pkg_preinst() {
	if [ "$ETYPE" = "headers" ] 
	then
		[ -L ${ROOT}usr/include/linux ] && rm ${ROOT}usr/include/linux
		[ -L ${ROOT}usr/include/asm ] && rm ${ROOT}usr/include/asm
		true
	fi
}

pkg_postinst() {
	[ "$ETYPE" = "headers" ] && return
	if [ ! -e ${ROOT}usr/src/linux ]
	then
		rm -f ${ROOT}usr/src/linux
		ln -sf linux-${KV} ${ROOT}/usr/src/linux
	fi
}
 
