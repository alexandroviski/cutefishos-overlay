# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cutefishos/wallpapers.git"
	EGIT_CHECKOUT_DIR=wallpapers-${PV}
else
	SRC_URI="https://github.com/cutefishos/wallpapers/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 arm64 riscv"
fi

DESCRIPTION="CutefishOS's system wallpaper"
HOMEPAGE="https://github.com/cutefishos/wallpapers"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND=""
DEPEND=""
BDEPEND="${DEPEND}
	kde-frameworks/extra-cmake-modules
	dev-util/ninja
"

S="${WORKDIR}/wallpapers-${PV}"

src_configure(){
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/usr"
	)
	cmake_src_configure
}
