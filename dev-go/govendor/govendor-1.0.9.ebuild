# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-build golang-vcs-snapshot

EGO_PN="github.com/kardianos/govendor"
VERSION="v1.0.9"
KEYWORDS="~amd64"
DESCRIPTION="Go vendor tool that works with the standard vendor file"
HOMEPAGE="https://github.com/kardianos/govendor"

SRC_URI="https://github.com/kardianos/govendor/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
IUSE=""

src_prepare() {
	default
}

src_compile() {
	pushd src/${EGO_PN} || die
	GOVENDOR_RELEASE="${VERSION}"
	GOPATH="${S}" go build -o ${PN} || die
	popd || die
}

src_install() {
	pushd src/${EGO_PN} || die
	dodoc -r README.md
	dobin govendor
	popd  || die
}


