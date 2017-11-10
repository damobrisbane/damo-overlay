# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-build golang-vcs-snapshot

EGO_PN="github.com/magiconair/vendorfmt"
VERSION="9999"
KEYWORDS="~amd64"
DESCRIPTION="Rewrite vendor.json to more merge-friendly format "
HOMEPAGE="https://github.com/magiconair/vendorfmt"

EGIT_COMMIT="0fde667441ebc14dbd64a1de758ab656b78c607b"
ARCHIVE_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
SRC_URI="${ARCHIVE_URI}"

LICENSE="MIT"
SLOT="0"
IUSE=""

src_prepare() {
	default
}

src_compile() {
	pushd src/${EGO_PN} || die
	GOVENDOR_RELEASE="${VERSION}"
	GOPATH="${S}" go build -v -o ${PN} cmd/vendorfmt/main.go || die
	popd || die
}

src_install() {
	pushd src/${EGO_PN} || die
	dodoc -r README.md
	dobin vendorfmt
	popd  || die
}


