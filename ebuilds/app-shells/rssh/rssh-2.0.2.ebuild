# Copyright 2003 Stefan Knoblich <stefan.knoblich@t-online.de>
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Restricted Shell for SSHd"
HOMEPAGE="http://www.pizzashack.org/rssh"
SRC_URI="http://www.pizzashack.org/rssh/src/rssh-${PV}.tar.gz"

SLOT="0"
KEYWORDS="x86 ~ppc"
LICENSE="BSD"

RDEPEND=">=net-misc/openssh-3.5"

DEPEND="${RDEPEND}"


src_compile() {
    local myconf=""

    einfo "rssh will be statically linked, for higher security"    
    sleep 5

    myconf="--enable-static \
	    --with-scp=/usr/bin/scp \
	    --with-sftp-server=/usr/lib/misc/sftp-server"

    econf ${myconf} || die
    emake || die
}

src_install() {

    einstall || die

    dodoc AUTHORS ChangeLog CHROOT INSTALL TODO README COPYING
}
