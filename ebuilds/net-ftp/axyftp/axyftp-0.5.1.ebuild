DESCRIPTION="GUI FTP client for X Window System (former WXftp)"
SRC_URI="http://www.wxftp.seul.org/download/axyftp-0.5.1.tar.gz"
HOMEPAGE="http://www.wxftp.seul.org"

LICENSE="Artistic LGPL"
KEYWORDS="~x86 ~amd64"

src_compile(){
	econf || die "configure failed"
	emake -j1 || die "compilation failed"
}

src_install() {
	make install DESTDIR=${D} 
}
