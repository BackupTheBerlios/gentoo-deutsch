# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/media-libs/libgd-gif/libgd-gif-1.8.4.ebuild,v 1.2 2003/02/01 23:55:03 wpbasti Exp $

MY_P=gd-1.8.4gif
S=${WORKDIR}/gd-1.8.4
DESCRIPTION="A graphics library for fast image creation"
SRC_URI="http://downloads.rhyme.com.au/gd/${MY_P}.tar.gz"
HOMEPAGE="http://www.rime.com.au/gd/"

DEPEND=">=media-libs/jpeg-6b
	>=media-libs/libpng-1.0.7
	~media-libs/freetype-1.3.1
	X? ( virtual/x11 )"
RDEPEND="!media-libs/libgd"

src_unpack() {

	unpack ${A}
	cd ${S}
	#cp Makefile Makefile.orig
	#if [ "`use X`" ]
	#then
	#	sed -e "s/^\(CFLAGS\)=.*/\1=$CFLAGS -DHAVE_XPM -DHAVE_JPEG -DHAVE_LIBTTF -DHAVE_PNG /" \
	#	-e "s/^\(LIBS\)=.*/\1=-lm -lgd -lpng -lz -ljpeg -lttf -lXpm -lX11/" \
	#	-e "s/^\(INCLUDEDIRS\)=/\1=-I\/usr\/include\/freetype /" \
	#	Makefile.orig > Makefile
	#else
	#	sed -e "s/^\(CFLAGS\)=.*/\1=$CFLAGS -DHAVE_JPEG -DHAVE_LIBTTF -DHAVE_PNG /" \
	#	-e "s/^\(LIBS\)=.*/\1=-lm -lgd -lpng -lz -ljpeg -lttf/" \
	#	-e "s/^\(INCLUDEDIRS\)=/\1=-I\/usr\/include\/freetype /" \
	#	Makefile.orig > Makefile
	#fi

}

src_compile() {

	emake || die

}

src_install() {
	
	dodir /usr/{bin,lib,include}
	
	make 	\
		INSTALL_LIB=${D}/usr/lib	\
		INSTALL_BIN=${D}/usr/bin \
		INSTALL_INCLUDE=${D}/usr/include	\
		install || die
	
	preplib /usr

	dodoc readme.txt
	dohtml -r ./

}
 
