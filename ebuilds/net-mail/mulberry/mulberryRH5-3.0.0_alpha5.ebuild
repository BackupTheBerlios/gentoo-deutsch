# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-mail/mulberry/Attic/mulberryRH5-3.0.0_alpha5.ebuild,v 1.1 2002/11/19 23:19:19 dimorph Exp $
IUSE="xfree"

S="${WORKDIR}"
DESCRIPTION="Mulberry is a high-performance, scalable, and graphically groovy internet mail client. It uses the IMAP (IMAP4rev1, IMAP4, and IMAP2bis) protocol for accessing mail messages on a server, the standard SMTP protocol for sending messages, and does lots and lots of things with MIME parts for mixed text and "attachments" of many different types of files and data."
HOMEPAGE="http://www.cyrusoft.com/mulberry/index.html"
DEPEND="x11-base/xfree"
RDEPEND=${DEPEND}
FILENAME="mulberry-3_0a5-rh5.tgz"
LICENSE="Mulberry-Licence"
DESTDIR="/opt/mulberry"
SRC_URI=""
KEYWORDS="x86"
SLOT=1

src_unpack() {
if [ ! -f ${DISTDIR}/${FILENAME} ]; then
ewarn "Please download ${FILENAME} from ${HOMEPAGE} and move it to ${DISTDIR}"
exit 1
else
unpack "${FILENAME}"
fi
cd "${S}"
}

src_install () {
# Install
insinto ${DESTDIR}
insopts -m0444
doins Mulberry_License

insinto ${DESTDIR}
insopts -m555
doins mulberry

for i in .mulberry/*
do
if [ ! -d $i ]; then
dodoc $i
fi
done;

insinto ${DESTDIR}/.mulberry/Plug-ins
doins .mulberry/Plug-ins/*

insopts -m0644
insinto /usr/share/icons
doins .mulberry/icons/*
}

pkg_postinst () {
   einfo "Please Read the Mulberry_Licence File in ${DESTDIR}"
   echo ""
   einfo "****************************************************************************"
   einfo "* Every user must install the Plugins in the \"\$HOME\"                       *"
   einfo "* directory, or make for EVERY PLUGIN a symlink.                           *"
   ewarn "*** Do NOT make a symlink to the whole directory!                        ***"
   einfo "****************************************************************************"
}

