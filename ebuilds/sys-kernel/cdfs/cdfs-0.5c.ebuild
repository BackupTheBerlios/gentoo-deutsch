# Copyright 2003 Henning Ryll <henning.ryll@web.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/sys-kernel/cdfs/cdfs-0.5c.ebuild,v 1.1 2003/03/05 21:46:46 fow0ryl Exp $


S=${WORKDIR}/cdfs-${PV}/
DESCRIPTION="CD FileSystem driver"
SRC_URI="http://www.elis.rug.ac.be/~ronsse/cdfs/download/cdfs-${PV}.tar.bz2"
HOMEPAGE="http://www.elis.rug.ac.be/~ronsse/cdfs/"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL"

src_unpack()  {
	unpack ${A} || die "unpack failed"
}

src_compile() {
	./configure
	make || die "make failed with errors"
}

src_install() {
	# The driver goes into the standard modules location
	insinto /lib/modules/${KV}/kernel/fs/cdfs
	doins cdfs.o
	
	# Docs
	dodoc -r ${S}/cdfs.html
	dodoc -r ${S}/cdfs.png
}

pkg_postinst() {
	# Update module dependency
	[ -x /sbin/update-modules ] && /sbin/update-modules

	einfo "If you are not using devfs, loading the module automatically at"
	einfo "boot up, you need to add the module \"cdfs\" to your /etc/modules.autoload."
	einfo
}

