# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-build golang-vcs-snapshot user

EGO_PN="github.com/fabiolb/fabio"
KEYWORDS="~amd64"
DESCRIPTION="Zero-conf load balancer/https router for microservices managed by consul"
HOMEPAGE="http://www.fabio.io"

SRC_URI="https://github.com/fabiolb/fabio/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
IUSE=""

RESTRICT="test"

DEPEND="dev-go/vendorfmt
	dev-go/govendor"

RDEPEND="${DEPEND}"

pkg_preinst() {
	enewgroup fabio
	enewuser fabio -1 -1 /var/lib/${PN} fabio
}

src_prepare() {
	default
	#
	# -X main.version=... ****shell git*** ... ; breaks ebuild compile
	#
	sed -e 's:\$(shell git describe --tags):'${PV}':' \
		-i "${S}/src/${EGO_PN}/Makefile" || die
}

src_compile() {
	GOPATH="${S}" \
	GOBIN="${S}/bin" \
	GOFLAGS="-ldflags" \
		emake -C "${S}/src/${EGO_PN}" build
}

src_install() {
	pushd src/${EGO_PN} || die
	dodoc -r CHANGELOG.md  CODE_OF_CONDUCT.md  CONTRIBUTING.md  README.md

	dobin fabio
	popd  || die

	for x in /var/{lib,log}/${PN}; do
		keepdir "${x}"
		fowners fabio:fabio "${x}"
	done

	newinitd "${FILESDIR}/fabio.initd" "${PN}"
	newconfd "${FILESDIR}/fabio.confd" "${PN}"
	insinto /etc/logrotate.d
	newins "${FILESDIR}/${PN}.logrotated" "${PN}"
}

