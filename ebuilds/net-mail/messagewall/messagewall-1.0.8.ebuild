# Copyright 2003 Alexander Holler
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/net-mail/messagewall/messagewall-1.0.8.ebuild,v 1.3 2003/08/23 20:56:12 ripclaw Exp $


S=${WORKDIR}/${PN}

DESCRIPTION="MessageWall - MessageWall is a free software SMTP proxy. It sits between the outside world and your mail server and keeps out viruses, spam and mail relaying."
HOMEPAGE="http://messagewall.org/"
SRC_URI="http://messagewall.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~alpha ~hppa ~arm"

DEPEND="virtual/glibc
	dev-libs/openssl
	dev-libs/firestring
	dev-libs/firedns"

pkg_setup() {

	if ! grep -q ^mwall: /etc/group ; then
		einfo "Adding group mwall"
		groupadd mwall
	fi
	if ! grep -q ^mwall: /etc/passwd ; then
		einfo "Adding user mwall"
		useradd -g mwall -c "User for MessageWall (normal)" -d /var/mwall mwall
	fi
	if ! grep -q ^mwalla: /etc/group ; then
		einfo "Adding group mwalla"
		groupadd mwalla
	fi
	if ! grep -q ^mwalla: /etc/passwd ; then
		einfo "Adding user mwalla"
		useradd -g mwalla -c "User for MessageWall (authentication)" -d /var/mwalla mwalla
	fi

}

src_compile() {

	./configure
	make PREFIX="/usr" CONFDIR="/etc/messagewall" || die "compile problem"

}

src_install () {

	make PREFIX="${D}usr" CONFDIR="${D}etc/messagewall" install || die "install problem"
	sed ${D}etc/messagewall/messagewall.conf \
		-e 's:^#profile_dir=/usr/local/etc/profiles/:profile_dir=/etc/messagewall/profiles/:' \
		-e 's:^#pid_dir=:pid_dir=:' \
		-e 's:^#root=/home/mwall:root=/var/mwall:' \
		-e 's:^#user=:user=:' \
		-e 's:^#group=:group=:' \
		-e 's:^#auth_root=/home/mwalla:auth_root=/var/mwalla:' \
		-e 's:^#auth_user=:auth_user=:' \
		-e 's:^#auth_group=:auth_group=:' \
		> ${D}etc/messagewall/messagewall.conf.sample
	rm ${D}etc/messagewall/messagewall.conf
	dodir /var/log/mail
	dodir /etc/messagewall/profiles
	insinto /etc/messagewall/profiles
	doins profiles/*
	dodir /etc/init.d
	exeinto /etc/init.d
	doexe ${FILESDIR}/messagewall
	dodir /var/mwall/pids
	chown mwall:mwall ${D}var/mwall/pids
	insinto /var/mwall
	doins virus.patterns
	dodir /var/mwalla/pids
	chown mwalla:mwalla ${D}var/mwalla/pids
	insinto /etc/messagewall/profiles
	doins profiles/*
	dodoc README
	docinto contrib
	dodoc contrib/redhat-startup-scripts/messagewall.logrotate
	docinto profiles
	dodoc profiles/*

}
