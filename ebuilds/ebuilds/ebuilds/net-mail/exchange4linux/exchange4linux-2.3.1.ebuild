# Copyright 2003 Alexander Holler
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/gentoo-deutsch/Repository/ebuilds/ebuilds/ebuilds/net-mail/exchange4linux/Attic/exchange4linux-2.3.1.ebuild,v 1.1 2003/08/22 15:27:33 fow0ryl Exp $

DESCRIPTION="exchange4linux - exchange4linux is a production/stable server solution to store/exchange workgroup data on Linux in a style simular to Exchange. Main goal is to provide Outlook users a free and open server alternative on Linux."
HOMEPAGE="http://www.exchange4linux.org/"

SRC_URI="http://www.neuberger-hughes.com/pub/exchange4linux/exchange4linux_${PV}.orig.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

# omniORBpy includes a dependency to omniORB
# postgresql isn't included in depend because it needs to be build with
# python as use-flag (see below)

RDEPEND="virtual/glibc
    dev-lang/python
    >=dev-python/omniORBpy-2.1"

DEPEND="virtual/glibc
    dev-lang/python
    >=dev-python/omniORBpy-2.1"

pkg_setup() {

  # There has to be a better way to determine if a particular package
  # is installed with a needed USE variable
  if ! test -f /usr/lib/python2.2/site-packages/pg.py ; then
    die "You have to install postgresql with USE flag python, e.g. with: 'USE=\"python\" emerge postgresql'"
  fi
  
}

src_compile() {

  cd BILL-StorageServer-${PV}
  omniidlrun.py -bpython msgstore.idl
  python /usr/lib/python2.2/compileall.py .
  mv server.sh server.sh.orig
  sed <server.sh.orig >server.sh -e 's/^clear/#clear/'
  rm server.sh.orig
  chmod +x server.sh
  cd ../BILL-StorageMailer-${PV}
  python /usr/lib/python2.2/compileall.py .
  rm mail.local.sh

}

src_install () {
  
  dodoc README* BILL-StorageServer-${PV}/LICENCE.TXT
  insinto /etc
  newins BILL-StorageServer-${PV}/bill.conf.ex bill.conf
  exeinto /etc/init.d
  doexe ${FILESDIR}/exchange4linux
  chown root.postgres ${D}etc/bill.conf
  chmod 660 ${D}etc/bill.conf
  touch ${D}etc/billpasswd
  chown root.postgres ${D}etc/billpasswd
  chmod 660 ${D}etc/billpasswd
  rm BILL-StorageServer-${PV}/bill.conf.ex
  rm BILL-StorageServer-${PV}/LICENCE.TXT
  rm BILL-StorageServer-${PV}/README.TXT
  mkdir ${D}usr/share/exchange4linux
  mv BILL-StorageServer-${PV} ${D}usr/share/exchange4linux/BILL-StorageServer
  mv BILL-StorageMailer-${PV} ${D}usr/share/exchange4linux/BILL-StorageMailer
  exeinto /usr/sbin  
  doexe ${FILESDIR}/exchange4linux-deliver
  mkdir ${D}var
  mkdir ${D}var/run
  mkdir ${D}var/run/exchange4linux/
  chown postgres.postgres ${D}var/run/exchange4linux/
  touch ${D}var/run/exchange4linux/exchange4linux.pid
  chown postgres.postgres ${D}var/run/exchange4linux/exchange4linux.pid
	
}

pkg_postinst() {

  einfo "**************************************"
  einfo "* Use                                *"
  einfo "*   /etc/init.d/exchange4linux admin *"
  einfo "* to setup users.                    *"
  einfo "**************************************"

}

pkg_postrm() {

  einfo "***************************************"
  einfo "* The postgresql database (mstore009) *"
  einfo "* for exchange4linux is not removed.  *"
  einfo "* You have to do this by hand, e.g.   *"
  einfo "*   su - postgres                     *"
  einfo "*   dropdb mstore009                  *"
  einfo "*   exit                              *"
  einfo "***************************************"

}
