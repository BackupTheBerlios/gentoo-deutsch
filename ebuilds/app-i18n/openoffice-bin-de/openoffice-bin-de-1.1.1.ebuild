# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/app-i18n/openoffice-bin-de/openoffice-bin-de-1.1.1.ebuild,v 1.1 2004/04/02 15:28:04 elefantenfloh Exp $

IUSE="kde gnome"

inherit virtualx

LOC="/opt"
OO_build="OpenOffice.org${PV}"

INSTDIR="${LOC}/${OO_build}"
if [ `use ppc` ]; then
	MY_PV="${PV/rc/RC}"
	MY_P="OOo_${PV}_LinuxPPC_installer"
S="${WORKDIR}/OOo_${PV}_LinuxIntel_install_de"
else
	MY_P="OOo_${PV}_LinuxIntel_install_de" 
	S="${WORKDIR}/OOo_${PV}_LinuxIntel_install_de"
fi;

OO_DICT="de_DE.zip"
OO_TH="thes_de_DE.zip"
OO_HYPH="hyph_de_DE.zip"

# Ximian Stuff
X_VER="ooo-build-1.1.52"


DESCRIPTION="OpenOffice productivity suite (german language version)"

SRC_URI="x86? ( ftp://ftp-stud.fht-esslingen.de/pub/Mirrors/ftp.openoffice.org/localized/de/${PV}/OOo_${PV}_LinuxIntel_install_de.tar.gz
		ftp://ftp.leo.org/pub/openoffice/localized/de/${PV}/OOo_${PV}_LinuxIntel_install_de.tar.gz
		ftp://sunsite.informatik.rwth-aachen.de/pub/mirror/OpenOffice/contrib/dictionaries/$OO_DICT
		ftp://ftp.leo.org/pub/openoffice/contrib/dictionaries/$OO_DICT
		ftp://ftp.leo.org/pub/openoffice/contrib/dictionaries/$OO_TH
		ftp://sunsite.informatik.rwth-aachen.de/pub/mirror/OpenOffice/contrib/dictionaries/$OO_HYPH 
		ftp://ftp.leo.org/pub/openoffice/contrib/dictionaries/$OO_HYPH
		http://ooo.ximian.com/packages/OOO_1_1_1/${X_VER}.tar.gz )"

HOMEPAGE="http://de.openoffice.org"

LICENSE="LGPL-2 | SISSL-1.1"
SLOT="0"
KEYWORDS="~x86 -ppc -sparc"


DEPEND="sys-apps/findutils
	virtual/glibc
	>=dev-lang/perl-5.0
	virtual/x11
	app-arch/zip
	app-arch/unzip
	|| ( >=virtual/jdk-1.3.1 >=virtual/jre-1.3.1 )
	!app-office/openoffice
	!app-office/openoffice-bin"

RDEPEND="${DEPEND}"


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
	#einfo "Removing build root from registry..."
    # Remove totally useless stuff.
    rm -f ${D}${INSTDIR}/program/{setup.log,sopatchlevel.sh}
    # Remove build root from registry and co
    egrep -rl "${D}" ${D}${INSTDIR}/* | \
        xargs -i perl -pi -e "s|${D}||g" {} || :
	                                                                                                                                                             
	einfo "Korrigiere Berechtigungen ..."
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
    sed -e "s|<pv>|${PV//_rc4}|g" ${T}/rsfile-local > ${T}/autoresponse-${PV}.conf
    doins ${T}/autoresponse-${PV}.conf
	                                                                                                                                                             
    # Install wrapper script
    exeinto /usr/bin
    sed -e "s|<pv>|${PV}|g" \
        ${FILESDIR}/ooffice-wrapper-1.3 > ${T}/ooffice
    doexe ${T}/ooffice

    # Component symlinks
    dosym ooffice /usr/bin/oocalc
    dosym ooffice /usr/bin/oodraw
    dosym ooffice /usr/bin/ooimpress
    dosym ooffice /usr/bin/oomath
    dosym ooffice /usr/bin/oowriter
    dosym ooffice /usr/bin/ooweb
    dosym ooffice /usr/bin/oosetup
    dosym ooffice /usr/bin/oopadmin


	einfo
	einfo "Installiere Menü Shortcuts (benötigt \"gnome\" oder \"kde\" als USE-Flag)..."
	einfo

	if [ -n "`use gnome`" ]
	then
		insinto /usr/share/gnome/apps/OpenOffice.org
		# Install the files needed for the catagory
		doins ${D}${INSTDIR}/share/gnome/net/.directory
		doins ${D}${INSTDIR}/share/gnome/net/.order

		# Apply Ximian stuff
		# Replace original ooo-menu-icons with icons from ximian

		unpack ${X_VER}.tar.gz 
			
		mkdir -p ${D}/usr/share/icons/ooo

		cp ${S}/${X_VER}/desktop/ximian-openoffice-*.png ${D}/usr/share/icons/ooo

		# Delete original .desktop-files from gnome/apps and add Ximian's and gentoo.de .desktop-files to share/applications
		rm -r ${D}/usr/share/gnome/
		mkdir -p ${D}/usr/share/applications
		cd ${D}/usr/share/applications/
		tar xvf ${FILESDIR}/1.1/menu-entries.tar

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
	rm -rf ${D}${INSTDIR}/share/cde

	# Make sure these do not get nuked.
	keepdir ${INSTDIR}/user/registry/res/en-us/org/openoffice/{Office,ucb}
	keepdir ${INSTDIR}/user/psprint/{driver,fontmetric}
	keepdir ${INSTDIR}/user/{autocorr,backup,plugin,store,temp,template}

	einfo "Deutsches Wörterbuch und Thesaurus werden installiert ..."
	
	# Entpacke das Wörterbuch in share/dict/ooo
	mkdir -p ${D}${LOC}/${OO_build}/share/dict/ooo/
	cd ${D}${LOC}/${OO_build}/share/dict/ooo/
	unzip -o ${DISTDIR}/${OO_DICT} || die "Konnte das deutsche Wörterbuch nicht entpacken !"

	# Entpacke den Thesaurus in share/dict/ooo/
	unzip -o ${DISTDIR}/${OO_TH} || die "Konnte den Thesaurus nicht entpacken !"

	# Entpacke Silbentrennungsregeln in share/dict/ooo/
	unzip -o ${DISTDIR}/${OO_HYPH} || die "Konnte die Silbentrennungsregeln nicht entpacken !"

	echo "DICT de DE de_DE" >> ${D}${LOC}/${OO_build}/share/dict/ooo/dictionary.lst
	echo "HYPH de DE hyph_de_DE" >> ${D}${LOC}/${OO_build}/share/dict/ooo/dictionary.lst
	echo "THES de DE th_de_DE" >> ${D}${LOC}/${OO_build}/share/dict/ooo/dictionary.lst
        

	#touch files to make portage uninstalling happy (#22593)
	find ${D} -type f -exec touch {} \;
}

pkg_postinst() {
	
	einfo "********************************************************************"
	einfo " Um OpenOffice.org zu starten führen Sie"
	einfo
	einfo "   $ ooffice"
	einfo
	einfo " aus."
	einfo
	einfo " Die einzelnen Komponenten können Sie mit folgenden Befehlen starten:"
	einfo
	einfo "   oocalc, oodraw, ooimpress, oomath, ooweb oder oowriter"
	einfo
	einfo "********************************************************************"
	if [ "${LC_ALL}" == "german" ]; then 	
	echo
	echo
        einfo "********************************************************************"
        einfo " ACHTUNG! "
	einfo 	
	einfo " Ihre LC_ALL Variable ist auf 'german' gesetzt, "
	einfo " dies kann evtl. zu Problemen führen. "
	einfo " Für weitere Informationen schauen Sie in den Gentoo Foren Thread"
	einfo 
	einfo " http://forums.gentoo.org/viewtopic.php?p=504396"
        einfo "********************************************************************"
        fi

}

