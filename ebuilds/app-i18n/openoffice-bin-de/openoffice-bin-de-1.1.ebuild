# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/app-i18n/openoffice-bin-de/openoffice-bin-de-1.1.ebuild,v 1.1 2003/10/05 14:27:17 dertobi123 Exp $

IUSE="kde gnome"

inherit virtualx

# NOTE:  There are two big issues that should be addressed.
#
#        1)  Language support and fonts should be addressed.

LOC="/opt"

INSTDIR="${LOC}/OpenOffice.org1.1-de"
#MY_PV="`echo ${PV} | gawk '{ print tolower($1) }'`"
MY_PV="${PV}"
if [ `use ppc` ]; then
	MY_PV="${MY_PV/rc/RC}"
	MY_P="OOo_${MY_PV}_LinuxPPC_installer"
S="${WORKDIR}/OOo_1.1.0_LinuxIntel_install_de"
else
	MY_P="OOo_${MY_PV}_LinuxIntel_install_de" 
	S="${WORKDIR}/OOo_1.1.0_LinuxIntel_install_de"
fi;

OO_DICT="de_DE.zip"
OO_TH="OOo-Thesaurus-snapshot.zip"

DESCRIPTION="OpenOffice productivity suite"
SRC_URI="x86? ( ftp://ftp-stud.fht-esslingen.de/pub/Mirrors/ftp.openoffice.org/localized/de/1.1.0/OOo_1.1.0_LinuxIntel_install_de.tar.gz
		ftp://sunsite.informatik.rwth-aachen.de/pub/mirror/OpenOffice/contrib/dictionaries/$OO_DICT
		http://thesaurus.kdenews.org/download/$OO_TH)"

HOMEPAGE="http://www.openoffice.org"

DEPEND="sys-apps/findutils
	virtual/glibc
	>=dev-lang/perl-5.0
	virtual/x11
	app-arch/zip
	app-arch/unzip
	|| ( >=virtual/jdk-1.3.1 >=virtual/jre-1.3.1 )
	!app-office/openoffice"

RDEPEND="virtual/glibc
	>=dev-lang/perl-5.0
	virtual/x11
	app-arch/zip
	app-arch/unzip
	|| ( >=virtual/jdk-1.3.1 >=virtual/jre-1.3.1 )
	!app-office/openoffice"

LICENSE="LGPL-2 | SISSL-1.1"
SLOT="0"
KEYWORDS="~x86 -ppc -sparc "

src_install() {
	# Sandbox issues; bug #8587
	addpredict "/user"
	addpredict "/share"
	addpredict "/pspfontcache"
	addpredict "/usr/bin/soffice"
	
	# Sandbox issues; bug 8063
	addpredict "/dev/dri"	

	# Autoresponse file for main installation
	cat > ${T}/rsfile-global <<-"END_RS"
		[ENVIRONMENT]
		INSTALLATIONMODE=INSTALL_NETWORK
		INSTALLATIONTYPE=STANDARD
		DESTINATIONPATH=<destdir>
		OUTERPATH=
		LOGFILE=
		LANGUAGELIST=<LANGUAGE>

		[JAVA]
		JavaSupport=preinstalled_or_none
	END_RS
	
	# Autoresponse file for user installation
	cat > ${T}/rsfile-local <<-"END_RS"
		[ENVIRONMENT]
		INSTALLATIONMODE=INSTALL_WORKSTATION
		INSTALLATIONTYPE=WORKSTATION
		DESTINATIONPATH=<home>/.openoffice/<pv>

		[JAVA]
		JavaSupport=none
	END_RS

	# Fixing install location in response file
	sed -e "s|<destdir>|${D}${INSTDIR}|" \
		${T}/rsfile-global > ${T}/autoresponse

	einfo "Installing OpenOffice.org into build root..."
	dodir ${INSTDIR}
	cd ${S}
	# Setup virtualmake
	export maketype="./setup"
	# We need X to install...
	virtualmake "-v -r:${T}/autoresponse"

	echo
	einfo "Removing build root from registry..."
	# Remove totally useless stuff.
	rm -f ${D}${INSTDIR}/program/{setup.log,sopatchlevel.sh}
	# Remove build root from registry and co
	egrep -rl "${D}" ${D}${INSTDIR}/* | \
		xargs -i perl -pi -e "s|${D}||g" {} || :

	einfo "Fixing permissions..."
	# Fix permissions
	find ${D}${INSTDIR}/ -type f -exec chmod a+r {} \;
	chmod a+x ${D}${INSTDIR}/share/config/webcast/*.pl

	# Fix symlinks
	for x in "soffice program/spadmin" \
		"program/setup setup" \
		"program/spadmin spadmin"
	do
		dosym $(echo ${x} | awk '{print $1}') \
			${INSTDIR}/$(echo ${x} | awk '{print $2}')
	done

	# Install user autoresponse file
	insinto /etc/openoffice
	sed -e "s|<pv>|${PV}|g" ${T}/rsfile-local > ${T}/autoresponse-${PV}.conf
	doins ${T}/autoresponse-${PV}.conf
	
	# Install wrapper script
	exeinto /usr/bin
	sed -e "s|<pv>|${PV}|g" \
		${FILESDIR}/${PV}/ooffice-wrapper-1.3 > ${T}/ooffice
	doexe ${T}/ooffice
	# Component symlinks
	dosym /opt/OpenOffice.org1.1-de/program/scalc /usr/bin/oocalc
        dosym /opt/OpenOffice.org1.1-de/program/sdraw /usr/bin/oodraw
        dosym /opt/OpenOffice.org1.1-de/program/simpress /usr/bin/ooimpress
        dosym /opt/OpenOffice.org1.1-de/program/smath /usr/bin/oomath
        dosym /opt/OpenOffice.org1.1-de/program/swriter /usr/bin/oowriter
        dosym /opt/OpenOffice.org1.1-de/program/sweb /usr/bin/ooweb
        dosym /opt/OpenOffice.org1.1-de/setup /usr/bin/oosetup
        dosym /opt/OpenOffice.org1.1-de/program/soffice /usr/bin/soffice
        dosym /opt/OpenOffice.org1.1-de/program/soffice.bin /opt/OpenOffice.org1.1-de/program/ooffice.bin
        dosym /opt/OpenOffice.org1.1-de/program/soffice.bin /opt/OpenOffice.org1.1-de/program/oooffice.bin
        dosym /opt/OpenOffice.org1.1-de/program/spadmin.bin /opt/OpenOffice.org1.1-de/program/oopadmin.bin
        dosym /opt/OpenOffice.org1.1-de/program/setup.bin /opt/OpenOffice.org1.1-de/setup.bin
        dosym /opt/OpenOffice.org1.1-de/program/spadmin /usr/bin/oopadmin
        dosym /opt/OpenOffice.org1.1-de/program/soffice /usr/bin/ooffice
        dosym /opt/OpenOffice.org1.1-de/program/soffice /usr/bin/oooffice

	einfo
	einfo "Installiere Menü Shortcuts (benötigt \"gnome\" oder \"kde\" als USE-Flag)..."
	einfo

	if [ -n "`use gnome`" ]
	then
		insinto /usr/share/gnome/apps/OpenOffice.org
		# Install the files needed for the catagory
		doins ${D}${INSTDIR}/share/gnome/net/.directory
		doins ${D}${INSTDIR}/share/gnome/net/.order

		# Change this to ooo*.desktop from *.desktop for now, since
		# otherwise two sets of icons will appear in the GNOME menu.
		# <brad@gentoo.org> (04 Aug 2003)
		for x in ${D}${INSTDIR}/share/gnome/net/ooo*.desktop
		do
			# We have to handle setup differently
			perl -pi -e "s:${INSTDIR}/program/setup:/usr/bin/oosetup:g" ${x}
			# Now fix the rest
			perl -pi -e "s:${INSTDIR}/program/s:/usr/bin/oo:g" ${x}
			doins ${x}
		done
	fi

	if [ -n "`use kde`" ]
	then
		local kdeloc="${D}${INSTDIR}/share/kde/net/"

		insinto /usr/share/applnk/OpenOffice.org\ 1.1
		# Install the files needed for the catagory
		doins ${kdeloc}/.directory
		#doins ${kdeloc}/.order
		dodir /usr/share
		# Install the icons and mime info
		cp -r ${D}${INSTDIR}/share/kde/net/share/mimelnk ${D}${INSTDIR}/share/kde/net/share/icons ${D}/usr/share
		
		for x in ${kdeloc}/*.desktop
		do
			# We have to handle setup differently
			perl -pi -e "s:${INSTDIR}/program/setup:/usr/bin/oosetup:g" ${x}
			# Now fix the rest
			perl -pi -e "s:${INSTDIR}/program/s:/usr/bin/oo:g" ${x}
			doins ${x}
		done
	fi

	# Unneeded, as they get installed into /usr/share...
#	rm -rf ${D}${INSTDIR}/share/{cde,gnome,kde}
	rm -rf ${D}${INSTDIR}/share/cde

	for f in ${D}/usr/share/gnome/apps/OpenOffice.org/* ; do
		echo 'Categories=Application;Office;' >> ${f}
	done


	# Make sure these do not get nuked.
	keepdir ${INSTDIR}/user/registry/res/en-us/org/openoffice/{Office,ucb}
	keepdir ${INSTDIR}/user/psprint/{driver,fontmetric}
	keepdir ${INSTDIR}/user/{autocorr,backup,plugin,store,temp,template}

	einfo 
	einfo "Deutsches Wörterbuch und Thesaurus werden installiert ..."
	einfo 

	# Entpacke das Wörterbuch in share/dict/ooo
	mkdir -p ${D}${LOC}/OpenOffice.org1.1-de/share/dict/ooo/
	cd ${D}${LOC}/OpenOffice.org1.1-de/share/dict/ooo/
	unzip -o ${DISTDIR}/${OO_DICT} || die "Konnte das deutsche Wörterbuch nicht entpacken !"


	# Entpacke den Thesaurus in share/dict/ooo/
	#cd ${D}${LOC}/OpenOffice.org1.1-de/share/dict/ooo/
	unzip -o ${DISTDIR}/${OO_TH} || die "Konnte den Thesaurus nicht entpacken !"
	mv ${D}${LOC}/OpenOffice.org1.1-de/share/dict/ooo/OOo-Thesaurus/* ${D}${LOC}/OpenOffice.org1.1-de/share/dict/ooo
	rm -r ${D}${LOC}/OpenOffice.org1.1-de/share/dict/ooo/OOo-Thesaurus 

	echo "DICT de DE de_DE" >> ${D}${LOC}/OpenOffice.org1.1-de/share/dict/ooo/dictionary.lst
	echo "HYPH de DE hyph_de_DE" >> ${D}${LOC}/OpenOffice.org1.1-de/share/dict/ooo/dictionary.lst
	echo "THES de DE th_de_DE" >> ${D}${LOC}/OpenOffice.org1.1-de/share/dict/ooo/dictionary.lst
        

	#touch files to make portage uninstalling happy (#22593)
	find ${D} -type f -exec touch {} \;
}

pkg_preinst() {

	# The one with OO-1.0.0 was not valid
	if [ -f ${ROOT}/etc/openoffice/autoresponse.conf ]
	then
		rm -f ${ROOT}/etc/openoffice/autoresponse.conf
	fi
}

pkg_postinst() {
	
	einfo "********************************************************************"
	einfo " Um OpenOffice.org zu starten führe:"
	einfo
	einfo "   $ ooffice"
	einfo
	einfo " aus."
	einfo
	einfo " Die einzelnen Komponenten kannst du mit folgenden Befehlen starten:"
	einfo
	einfo "   oocalc, oodraw, ooimpress, oomath, ooweb oder oowriter"
	einfo
	einfo " Evtl. musst du unter Extras/Optionen/Spracheinstellung/Linguistik"
	einfo "	noch den Thesaurus und die "
	einfo "	deutsche Rechtschreibprüfung aktivieren."
	einfo "********************************************************************"
	if [ "${LC_ALL}" == "german" ]; then 	
	echo
	echo
        einfo "********************************************************************"
        einfo " ACHTUNG! "
	einfo 	
	einfo "	Deine LC_ALL Variable ist auf 'german' gesetzt, "
	einfo " dies kann evtl. zu Problemen führen. "
	einfo " Für weitere Informationen schau dir den Thread in den "
	einfo " Gentoo Foren an."
	einfo 
	einfo " http://forums.gentoo.org/viewtopic.php?p=504396"
        einfo "********************************************************************"
        fi


}

