inherit kde

need-qt 3

DESCRIPTION="SQLite Database Browser is a freeware, public domain, open source visual tool used to create, design and edit database files compatible with SQLite 2.x"
SRC_URI="mirror://sourceforge/sqlitebrowser/${P}-src.tar"
S="${WORKDIR}/${PN}/${PN}"
LICENSE="Public Domain"

src_compile() {
    qmake
    emake
}

src_install() {
    dodir /usr/bin
    install -s -m 0755 ${PN} ${D}/usr/bin/
    dodoc LICENSING
}