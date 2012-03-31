# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="3"

inherit eutils

BUILD_NUM="33893"
SRC_DIR="LogitechMediaServer_v${PV}"
MY_PN="${PN/-bin}"
MY_P_BUILD_NUM="${MY_PN}-${PV}-${BUILD_NUM}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Logitech Meda Server music server"
HOMEPAGE="http://www.mysqueezebox.com/download"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

SRC_URI="http://downloads.slimdevices.com/${SRC_DIR}/${MY_P}.tgz"

# Installation dependencies.
DEPEND="
	!media-sound/squeezecenter
	!media-sound/squeezeboxserver
	"

# Runtime dependencies.
RDEPEND="
	!prefix? ( >=sys-apps/baselayout-2.0.0 )
	!prefix? ( virtual/logger )
	>=dev-lang/perl-5.8.8
	>=dev-perl/Data-UUID-1.202
	"

S="${WORKDIR}/${MY_P_BUILD_NUM}"

RUN_UID=logitechmediaserver
RUN_GID=logitechmediaserver

OPTDIR="/opt/${MY_PN}"
RUNDIR="/var/run/${MY_PN}"
VARDIR="/var/opt/${MY_PN}"
CACHEDIR="${VARDIR}/cache"
PREFSDIR="${VARDIR}/prefs"
PLUGINSDIR="${VARDIR}/plugins"
PREFS="${PREFSDIR}/${MY_PN}.prefs"
DOCDIR="/usr/share/doc/${P}"
LOGDIR="/var/log/${MY_PN}"

pkg_setup() {

	# Create the user and group if not already present
	enewgroup ${RUN_GID}
	enewuser ${RUN_UID} -1 -1 "/dev/null" ${RUN_GID}
}

src_prepare() {
	# Apply patches
	epatch "${FILESDIR}/${P}-uuid-gentoo.patch"
}

src_install() {

	# Everthing into our package in the /opt hierarchy (LHS)
	dodir "${OPTDIR}"
	cp -aR "${S}"/* "${ED}${OPTDIR}" || die "Unable to install package files"

	# Documentation
	dodoc Changelog*.html
	dodoc Installation.txt
	dodoc License*.txt
	dodoc "${FILESDIR}/Gentoo-plugins-README.txt"
	dodoc "${FILESDIR}/Gentoo-detailed-changelog.txt"

	# Preferences directory
	dodir "${PREFSDIR}"
	fowners ${RUN_UID}:${RUN_GID} "${PREFSDIR}"
	fperms 770 "${PREFSDIR}"

	# Install init scripts
	newconfd "${FILESDIR}/logitechmediaserver.conf.d" "${MY_PN}"
	newinitd "${FILESDIR}/logitechmediaserver.init.d" "${MY_PN}"

	# Initialize run directory (where the PID file lives)
	dodir "${RUNDIR}"
	fowners ${RUN_UID}:${RUN_GID} "${RUNDIR}"
	fperms 770 "${RUNDIR}"

	# Initialize server cache directory
	dodir "${CACHEDIR}"
	fowners ${RUN_UID}:${RUN_GID} "${CACHEDIR}"
	fperms 770 "${CACHEDIR}"

	# Initialize the log directory
	dodir "${LOGDIR}"
	fowners ${RUN_UID}:${RUN_GID} "${LOGDIR}"
	fperms 770 "${LOGDIR}"
	touch "${ED}/${LOGDIR}/server.log"
	touch "${ED}/${LOGDIR}/scanner.log"
	touch "${ED}/${LOGDIR}/perfmon.log"
	fowners ${RUN_UID}:${RUN_GID} "${LOGDIR}/server.log"
	fowners ${RUN_UID}:${RUN_GID} "${LOGDIR}/scanner.log"
	fowners ${RUN_UID}:${RUN_GID} "${LOGDIR}/perfmon.log"

	# Initialise the user-installed plugins directory
	dodir "${PLUGINSDIR}"
	fowners ${RUN_UID}:${RUN_GID} "${PLUGINSDIR}"
	fperms 770 "${PLUGINSDIR}"

	# Install logrotate support
	insinto /etc/logrotate.d
	newins "${FILESDIR}/logitechmediaserver.logrotate.d" "${MY_PN}"
}

pkg_postinst() {
	einfo "Manually installed plugins should be placed in the following directory"
	einfo " ${PLUGINSDIR}"
}
