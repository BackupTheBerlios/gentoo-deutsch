#Jürg Marti <tschortsch@gmx.ch>

DESCRIPTION="A WindowMaker dock app showing network usage"
HOMEPAGE="http://www.voltar.org/dockapps/"

S=${WORKDIR}/${P}
SRC_URI="http://www.voltar.org/dockapps/wmjiface-1.7cb.tgz"
DEPEND="virtual/x11
	>=libdockapp-0.4.0"

SOURCE=${WORKDIR}/wmjiface

src_unpack(){
	unpack ${A} || die
	cd ${SOURCE}
	patch -p1 < ${FILESDIR}/Makefile.patch || die
}

src_compile() {
	cd ${SOURCE}/src 
	make || die
}

src_install () {
	cd ${SOURCE}/src
	mkdir ${D}/usr
	mkdir ${D}/usr/bin
	make prefix=${D}/usr/bin install || die
	cd ..
	dodoc README.firewall_trouble README CREDITS INSTALL COPYING \
		CHANGES README.ifacechk
}
 
