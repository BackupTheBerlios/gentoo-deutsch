# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/sys-kernel/love-sources/love-sources-2.6.7_rc3-r2.ebuild,v 1.1 2004/06/19 09:07:53 austriancoder Exp $

# Only set MMV to numeric value of -mm release
# Version of Andrew Morton's patchset
MMV="2"

K_PREPATCHED="yes"
K_NOSETEXTRAVERSION="don't_set_it"

ETYPE="sources"
inherit kernel-2
detect_version

# Create -mm patch version, -mm patch source, -love patch source
MMPV="${KV/-love*/}-mm${MMV}"
MMPV_SRC="mirror://kernel/linux/kernel/people/akpm/patches/2.6/${MMPV/-mm*/}/${MMPV}/${MMPV}.bz2"
LOVEPV_SRC="http://oneofone.limitlessfx.com/love-sources/${KV}.bz2"

UNIPATCH_STRICTORDER="yes"
UNIPATCH_LIST="${DISTDIR}/${MMPV}.bz2 ${DISTDIR}/${KV}.bz2"

DESCRIPTION="Development branch of the Linux Kernel with Andrew Morton's patchset and other performance-ish patches and tweaks. Maintained by Lovechild, steel300, and OneOfOne"
HOMEPAGE="http://oneofone.limitlessfx.com/love-sources/"
SRC_URI="${KERNEL_URI} ${MMPV_SRC} ${LOVEPV_SRC}"

KEYWORDS="x86 ~amd64 ~ia64 -*"

K_EXTRAEWARN="IMPORTANT: steel300 and OneOfOne remind you that the patches
here are sometimes experimental and could explode upon impact, make your
[soda|pop] really bland, or other badness. We aren't responsible for that,
but we will mention that these patches will also make your kernel
ROCK LIKE NINJA. If you experience problems while using love-sources,
go back to a vanilla kernel and see if the problem persists. If the problems
are still there, then you can bug somebody. (Preferably us and 
not the Gentoo devs!)
pass rootflags=nopseudo to disable metas/ for root reiser4
pgrep hdXY | xargs renice -15 to fix reiser4 root lock ups under load"

