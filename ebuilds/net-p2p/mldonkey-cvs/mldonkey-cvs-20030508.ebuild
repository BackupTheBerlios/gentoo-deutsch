# Copyright 2003 Markus Kuppe
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-p2p/mldonkey-cvs/mldonkey-cvs-20030508.ebuild,v 1.2 2003/05/29 00:25:30 lemmy Exp $

IUSE="gtk pango pthread multinet"

ECVS_SERVER="subversions.gnu.org:/cvsroot/mldonkey"
ECVS_MODULE="mldonkey"
ECVS_USER="anoncvs"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${ECVS_BRANCH}"

PANGO_SRC_URI="ftp://download.berlios.de/pub/${ECVS_MODULE}/pango/pango-latest.tar.gz"

inherit cvs

S="${WORKDIR}/${ECVS_MODULE}"

DESCRIPTION="mldonkey is a new client to access the eDonkey network. It is written in Objective-Caml, and comes with its own GTK GUI, an HTTP interface and a telnet interface."
HOMEPAGE="http://savannah.nongnu.org/projects/mldonkey/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="gtk? ( >=lablgtk-1.2.3 )
	>=dev-lang/ocaml-3.06
	dev-lang/perl"
RDEPEND=${DEPEND}

src_compile() {
	use gtk || export GTK_CONFIG="no"
	
	local myconf
	use pthread && myconf="${myconf} --enable-pthread" 
	
	use multinet || myconf="${myconf} --disable-multinet"

	if use pango; then
	    cd ${S}
	    wget -t 3 ${PANGO_SRC_URI}
	    tar xfz pango-latest.tar.gz
	    patch -t -p0 -E -s --dry-run < pango.patch 
	    if [ $? -eq 0 ]; then
		patch -p0 -E -s < pango.patch
	    else
		eerror "pango-patch didn't apply. continuing without it"
	    fi
	fi
	    
	# the dirs are not (yet) used, but it doesn't hurt to specify them anyway
	econf \
		--sysconfdir=/etc/mldonkey \
		--sharedstatedir=/var/mldonkey \
		--localstatedir=/var/mldonkey \
		--enable-ocamlver=3.06 \
		${myconf}

	emake || die
}

src_install() {
	# avoid error msg if !USE="gtk"
	if use gtk; then
	    dobin mlnet mlnet+gui mlgui mlchat mlguistarter mlim
	else
	    dobin mlnet
	fi         

	cd docs
	dodoc *.txt *.pdf *tex
	dohtml *.html
	insinto /usr/share/doc/${PF}/images
	doins images/*
	
	cd ${S}/distrib
	dodoc AUTHORS BUGS COPYING ChangeLog Developers.txt ed2k_links.txt \
		Readme.txt TODO 
	dohtml FAQ.html
	
	insinto /usr/share/doc/${PF}/scripts
	doins kill_mldonkey mldonkey_command mldonkey_previewer;
}

pkg_postinst() {
	einfo "pthread and pango-patch is available. USE=pthread and/or USE=pango"
	einfo "If you don't want to buildin multinet support, than USE=-multinet"
	einfo "To launch mldonkey, start mlnet inside a seperate directory."
	einfo "Eg: cd /seperate/directory && mlnet >> mld.log &"
	einfo "A good Place of Knowledge:"
	einfo "http://mldonkey.berlios.de/modules.php?name=Wiki"
	einfo "IMPORTANT: Don't run mlnet as root!"
}
