# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/sys-kernel/cryptoloop-sources/cryptoloop-sources-2.4.23_pre7.ebuild,v 1.1 2003/10/20 10:29:07 longint Exp $

IUSE="build"

# OKV=original kernel version, KV=patched kernel version, CV=cryptoloop-kernel-version.  

ETYPE="sources"

inherit kernel || die

OKV="2.4.22"
KV="${PV/_/-}"
CV="${KV}-cryptoloop";
S=${WORKDIR}/linux-${CV}

EXTRAVERSION="`echo ${KV}|sed -e 's:[^-]*\(-.*$\):\1:'`"
BASE="`echo ${KV}|sed -e s:${EXTRAVERSION}::`"

DESCRIPTION="Full sources for prepatched vanilla Linux kernel including cryptoloop"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	mirror://kernel/linux/kernel/v2.4/testing/patch-${PV/_/-}.bz2
	mirror://kernel/linux/kernel/crypto/v2.4/testing/patch-cryptoloop-jari-2.4.22.0"
HOMEPAGE="http://www.kernel.org/ http://www.kerneli.org/"

KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"
SLOT="${KV}"

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${CV} || die

	cd linux-${CV}

	bzcat ${DISTDIR}/patch-${PV/_/-}.bz2|patch -p1          || die "-prerelease patch failed"
	cat ${DISTDIR}/patch-cryptoloop-jari-2.4.22.0|patch -p1 || die "-cryptoloop patch failed"

	kernel_universal_unpack
}

pkg_postinst() {
	einfo "Prepatches are the equivalent to alpha releases for Linux."
	einfo "They may be poorly tested, and may not work at all."
	einfo "Prepatches with -rc in the name are release candidates and"
	einfo "may become full versions.  It is particularly important"
	einfo "that these are thoroughly tested and bugs are reported back"
	einfo "upstream (and not to the Gentoo team)."
	einfo "                --------------------"
	einfo "This kernel includes the cryptoloop-sources by jari."
	einfo "Please note that the current crypto-api is incompatible"
	einfo "whith the one used before (f.i. in gentoo-sources) AND"
	einfo "util-linux-2.12 (to be more correct: losetup will not work)."
	einfo "In case you are upgrading from such an previous crypto-filesystem,"
	einfo "you _can't_ use it anymore. You are forced to backup your data"
	einfo "and create a new crypto-file-system (see 'man losetup')."
	einfo "The good thing is, you will be fully compatible with kernel 2.6,"
	einfo "where everything is already included and you don't have to worry"
	einfo "about any further upgrade of your crypto-fs."
	einfo "It is most likely, that cryptoloop will make it's way to the official"
	einfo "sources once, but until then you need this patch. See also" 
	einfo "http://bugs.gentoo.org/show_bug.cgi?id=25192 for further readings."

}
