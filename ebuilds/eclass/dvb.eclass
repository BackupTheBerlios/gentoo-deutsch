# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/eclass/dvb.eclass,v 1.2 2004/08/11 12:56:31 austriancoder Exp $
#
# Matthias Schwarzott <zzam@gmx.de>

ECLASS=dvb
INHERITED="$INHERITED $ECLASS"

if [ "${KV:0:3}" == "2.6" ]; then
	DEPEND="sys-kernel/linux26-headers"
fi

#
# function to implement a "local" use variable called VDR_OPTS
#
vdr_opts() {
	local x
	for x in ${VDR_OPTS}
	do
		if [ "${x}" = "${1}" ]
		then
			einfo "Option ${1} found in VDR_OPTS"
			return 0
		fi
	done
	ewarn "No optional ${1} in VDR_OPTS"
	return 1
}

dvb_find_driver_include() {
	# Use linux26-headers
	DVB_DRIVER_INCLUDE=/usr

	DVB_ADDPATH=/include
	# Use DVB_ADDDVBPATH if set
	DVB_DRIVER_INCLUDE="${DVB_DRIVER_INCLUDE}${DVB_ADDPATH}"

	einfo "Using DVB-Driver-Includes from ${DVB_DRIVER_INCLUDE}"

	# replace / with \/
	DVB_DRIVER_INCLUDE_QUOTED="${DVB_DRIVER_INCLUDE//\//\/}"

}

dvb_patch_makefile() {
	dvb_find_driver_include

	einfo Patching Makefile for new path to dvb-driver
	# To not overwrite the global variable with local changes 
	local S="${S}"
	[ -z "${1}" ] || S="${1}"

	sed -i "s/^DVBDIR.*$/DVBDIR = ${DVB_DRIVER_INCLUDE_QUOTED}/" ${S}/Makefile

	sed -i 's/\$(DVBDIR)\/include/$(DVBDIR)/' ${S}/Makefile
}

