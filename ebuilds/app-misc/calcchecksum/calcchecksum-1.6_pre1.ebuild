inherit kde-base

need-kde 3.1

SRC_URI="mirror://sourceforge/calcchecksum/${PN}-1.6-pre1.tar.bz2"
HOMEPAGE="http://calcchecksum.sf.net"
DESCRIPTION=""

KEYWORDS="~x86"

S=${WORKDIR}/${PN}-1.6-pre1

src_compile() {
    econf --prefix=$KDEDIR
    emake
}
