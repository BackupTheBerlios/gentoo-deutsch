HOMEPAGE="http://open.nit.ca/wiki/?page=RetchMail"
DESCRIPTION="RetchMail is the world's most stupidly fast POP3 retriever"
SRC_URI="http://freshmeat.net/redir/retchmail/21631/url_tgz/${P}.tar.gz"

DEPEND="net-libs/wvstreams"

KEYWORDS="~x86"

src_compile() {
    emake clean
    PREFIX=/usr emake
}

src_install() {
    mkdir -p ${D}/usr/bin
    mkdir -p ${D}/usr/share/man/man1
    mkdir -p ${D}/usr/share/man/man5
    install -s -m 0755 ${S}/src/retchmail ${D}/usr/bin/
    install -m 0644 ${S}/retchmail.1 ${D}/usr/share/man/man1
    install -m 0644 ${S}/retchmailrc.5 ${D}/usr/share/man/man5
}