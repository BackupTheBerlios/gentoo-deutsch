inherit nsplugins

S=${WORKDIR}/${P}
DESCRIPTION="MozPlugger streaming media plugin"
SRC_URI="http://mozdev.mirrors.nyphp.org/mozplugger/${P}.tar.gz"
HOMEPAGE="http://mozplugger.mozdev.org/"

KEYWORDS="~x86 -ppc ~sparc"
LICENCSE="GPL-2"
DEPEND="virtual/glibc"
PROVIDE="virtual/plugger"

src_compile()
{
    cd ${S}
    make linux
}

src_install()
{
    cd ${S}
    dodir /opt/netscape/plugins /etc
    insinto /opt/netscape/plugins
    doins mozplugger.so
    insinto /etc
    doins mozpluggerrc
    dodoc README COPYING ChangeLog
    bunzip2 mozplugger.7.bz2
    doman mozplugger.7
    insinto /usr/bin
    dobin mozplugger
    
    inst_plugin /opt/netscape/plugins/mozplugger.so
    
    dodoc README
}
